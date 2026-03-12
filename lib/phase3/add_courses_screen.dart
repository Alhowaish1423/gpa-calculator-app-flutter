import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';
import 'package:mygpa_app/helpers/pop_up_messages.dart';
import 'package:mygpa_app/phase4/course_list.dart';
import 'package:mygpa_app/phase4/new_course.dart';

class AddCoursesScreen extends StatefulWidget {
  const AddCoursesScreen({
    super.key,
    required this.calculateScreen,
    required this.oldTotalHours,
    required this.lastGPA,
  });

  final void Function() calculateScreen;
  final TextEditingController oldTotalHours;
  final TextEditingController lastGPA;

  @override
  State<AddCoursesScreen> createState() => _AddCoursesScreenState();
}

class _AddCoursesScreenState extends State<AddCoursesScreen> {
  void _openAddCourseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.83,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NewCourse(addNewCourse: _addCourse),
        );
      },
    );
  }

  void _addCourse(Course course) {
    setState(() {
      Course.registeredCourses(Course.gpaDvideable).add(course);
    });
  }

  void _removeallCourse() {
    setState(() {
      if (Course.registeredCourses(Course.gpaDvideable).isEmpty) {
        toastPopUp(context, 'No registered courses to be deleted');
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Are you sure?',
              textAlign: TextAlign.center,
            ),
            content: const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: Text(
                'All the registered courses will be deleted!',
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel', style: TextStyle(fontSize: 19)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Course.registeredCourses(Course.gpaDvideable).clear();
                    if (Course.gpaDvideable == 100) {
                      NewCourse.courseIndexGPA100 = 1;
                    } else {
                      NewCourse.courseIndexGPA4or5 = 1;
                    }
                  });
                  Navigator.pop(ctx);
                  toastPopUp(ctx, 'All courses deleted');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.errorContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onErrorContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Delete', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        );
      }
    });
  }

  void _removeCourse(Course course) {
    final index = Course.registeredCourses(Course.gpaDvideable).indexOf(course);
    setState(() {
      Course.registeredCourses(Course.gpaDvideable).remove(course);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Course deleted'),
        action: SnackBarAction(
          label: 'Cancel',
          onPressed: () {
            setState(() {
              Course.registeredCourses(Course.gpaDvideable)
                  .insert(index, course);
            });
          },
        ),
      ),
    );
  }

  void getsCourseContent(Course course) {
    var index = Course.registeredCourses(Course.gpaDvideable).indexOf(course);
    toastPopUp(context, 'Modifying...');
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.83,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NewCourse.editCard(
            savedHours: course.courseHours,
            savedGrades: course.courseGrades.toString(),
            savedCourseName: course.courseName,
            savedPercentage: course.courseGrades.toString(),
            addNewCourse: (course) {
              setState(() {
                Course.registeredCourses(Course.gpaDvideable)
                    .insert(index, course);
                Course.registeredCourses(Course.gpaDvideable)
                    .removeAt(index + 1);
              });
            },
          ),
        );
      },
    );
  }

  void _calculateCheck() {
    String errorTitle = '';
    String errorContent = '';

    if (Course.registeredCourses(Course.gpaDvideable).isEmpty) {
      errorTitle = 'No Registered Courses';
      errorContent = 'Please add at least one course to calculate GPA';
    } else if (Course.SemesterOrCumulative == 2) {
      final oldHoursText = widget.oldTotalHours.text.trim().replaceAll(',', '.');
      final lastGPAText = widget.lastGPA.text.trim().replaceAll(',', '.');

      if ((oldHoursText.isEmpty && Course.UniversityOrHighSchool == 1) ||
          lastGPAText.isEmpty) {
        errorTitle = 'Missing Input';
        errorContent = 'Please enter both previous hours and previous GPA';
      } else {
        if (Course.UniversityOrHighSchool == 1 &&
            int.tryParse(oldHoursText) == null) {
          errorTitle = 'Invalid Hours';
          errorContent =
              'Don\'t use fraction or decimal numbers. Please enter whole numbers for the Previous Hours.';
        }

        final parsedGPA = double.tryParse(lastGPAText);
        if (parsedGPA == null ||
            parsedGPA < 0 ||
            parsedGPA > Course.gpaDvideable) {
          errorTitle = 'Invalid GPA';
          errorContent =
              'GPA must be between 0.00 and ${Course.gpaDvideable}.00';
        }
      }
    }

    if (errorTitle.isNotEmpty) {
      erorrMassage(context, errorTitle, errorContent);
      return;
    }

    widget.calculateScreen();
  }

  Widget checkGPAcumulative() {
    if (Course.SemesterOrCumulative == 2) {
      if (Course.UniversityOrHighSchool == 1) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 16, 0),
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
                  cursorHeight: 18,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Previous Hours',
                        style: TextStyle(fontSize: 19)),
                    border: OutlineInputBorder(),
                    hintText: '74',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(200, 150, 150, 150),
                      fontSize: 18,
                    ),
                  ),
                  controller: widget.oldTotalHours,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 32, 0),
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
                  cursorHeight: 18,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text('Previous GPA',
                        style: TextStyle(fontSize: 19)),
                    border: const OutlineInputBorder(),
                    hintText: Course.gpaDvideable == 100 ? '82.47' : '3.50',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(200, 150, 150, 150),
                      fontSize: 18,
                    ),
                  ),
                  controller: widget.lastGPA,
                ),
              ),
            ),
          ],
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: TextField(
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
            cursorHeight: 18,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: const Text('Previous GPA',
                  style: TextStyle(fontSize: 19)),
              border: const OutlineInputBorder(),
              hintText: Course.gpaDvideable == 100 ? '82.47' : '3.50',
              hintStyle: const TextStyle(
                color: Color.fromARGB(200, 150, 150, 150),
                fontSize: 18,
              ),
            ),
            controller: widget.lastGPA,
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Course.UniversityOrHighSchool == 1
              ? 'images/786af4a4a3756b9dacab344f6fffac11.png'
              : 'images/b1dcf849502577c4aca7c026c1a7d087.png',
          width: 250,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(3, 4),
                      ),
                    ],
                  ),
                  child: IconButton.filled(
                    onPressed: _openAddCourseOverlay,
                    icon: const Icon(Icons.add),
                    iconSize: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (Course.registeredCourses(Course.gpaDvideable).isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 32, 18, 0),
            child: Text(
              'Tap the + button above to add your courses.'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        Expanded(
          child: CourseList(
            courses: Course.registeredCourses(Course.gpaDvideable),
            onRemoveCouruse: _removeCourse,
            getsCourseContent: getsCourseContent,
          ),
        ),
        checkGPAcumulative(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 0, 10),
              child: IconButton.outlined(
                style: IconButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.errorContainer,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                    width: 1,
                  ),
                ),
                iconSize: 35,
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                onPressed: _removeallCourse,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 32, 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  onPressed: _calculateCheck,
                  child: const Text('Calculate'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
