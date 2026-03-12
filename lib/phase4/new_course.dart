import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';
import 'package:mygpa_app/helpers/pop_up_messages.dart';

class NewCourse extends StatefulWidget {
  const NewCourse({
    super.key,
    required this.addNewCourse,
  })  : savedHours = '1',
        savedGrades = 'A+',
        savedCourseName = '',
        savedPercentage = '';

  const NewCourse.editCard({
    super.key,
    required this.addNewCourse,
    required this.savedHours,
    required this.savedGrades,
    required this.savedCourseName,
    required this.savedPercentage,
  });
  final void Function(Course course) addNewCourse;
  static int courseIndexGPA4or5 = 1;
  static int courseIndexGPA100 = 1;
  final String savedHours;
  final String savedGrades;
  final String savedCourseName;
  final String savedPercentage;

  @override
  State<NewCourse> createState() {
    return _NewCourseState();
  }
}

class _NewCourseState extends State<NewCourse> {
  final _courseNameController =
      TextEditingController(); // this not a string or text > it will stor the name of the coures > so we have to convert it to text by .text
  final _coursePercentageController = TextEditingController();

  var hours = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var grades = ['A+', 'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'F', 'DN'];

  var _selectedHours = '';
  var _selectedGrades = '';
  var enterdPercentage = 0;

  @override
  void initState() {
    super.initState();
    _selectedHours = hours[hours.indexOf(widget.savedHours)];
    _selectedGrades = Course.gpaDvideable == 100
        ? widget.savedGrades
        : grades[grades.indexOf(widget.savedGrades)];
    _courseNameController.text = widget.savedCourseName;
    _coursePercentageController.text = widget.savedPercentage;
  }

  // _NewCourseState.editCouse(String _courseNameController) {
  //   _selectedHours = hours[0];
  //   _selectedGrades = grades[0];
  // }

  @override
  void dispose() {
    _courseNameController.dispose();
    _coursePercentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton.filled(
                style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.clear_rounded,
                    size: 30, color: Theme.of(context).colorScheme.onError)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
            child: TextField(
              // input text color
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              // the color of this | | | | when inputing
              cursorColor: Theme.of(context).colorScheme.onSurface,
              // when the user cilck to type , the kybord will be the defult one not the phone call keybord
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  'Course Name',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                hintText: 'Optional',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(150, 100, 100, 100)),
                // TO make the hinttext appear all the time
                floatingLabelBehavior: FloatingLabelBehavior.always,

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3), // Border color when enabled but not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3), // Border color when focused
                ),
              ),
              // onChanged: functun  ======== this onchanged will store the text you enterd to a varable in a functoun see vid 109

              controller: _courseNameController,
            ),
          ),
          Row(
            children: [
              // expanded -> container -> dropdownbutton
              // to make the dropdownbutton take half the space availaboul (and must add isExpanded in drpdownbutton) -> epanded
              // styal and coloring the drpdouwnbutton -> container
              // anything insied the dropdownbutton styling (iconSize - underline) -> drpdowunbutton
              showHoursDropButton(),

              Expanded(
                child: Container(
                  // color: Colors.blueAccent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          Course.gpaDvideable == 100 ? 'Mark' : 'Grade',
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface), //textAlign:TextAlign.justify, //Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color.fromARGB(255, 116, 240, 8))
                        ),
                      ),
                      checkGPA100(),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   width: 16,
              // ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 33, 16, 0),
                  child: SizedBox(
                    height: 53,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: Text(
                          'save',
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // it will get out of the current context (((( the new expense secreen ))))
              },
              child: const Text(
                'cancel',
                style: TextStyle(fontSize: 25),
              ))
        ],
      ),
    );
  }

  Widget showHoursDropButton() {
    if (Course.UniversityOrHighSchool == 1) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text(
                'Hours',
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface), //textAlign:TextAlign.justify, //Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color.fromARGB(255, 116, 240, 8))
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: DropdownButton(
                    menuWidth: 100,
                    menuMaxHeight: 220,
                    borderRadius: BorderRadius.circular(5),

                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    isExpanded: true,
                    // empty container to delet the underline of the dropdownbutton
                    underline: Container(),
                    iconSize: 40,
                    value: _selectedHours,
                    items: hours.map((ctx) {
                      return DropdownMenuItem(
                        alignment: Alignment.centerLeft,
                        value: ctx,
                        child: Text(ctx),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedHours = value as String;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget checkGPA100() {
    if (Course.gpaDvideable == 100) {
      return SizedBox(
        height: 54,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: TextField(
            // input text color
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            // the color of this | | | | when inputing
            cursorColor: Theme.of(context).colorScheme.onSurface,
            cursorHeight: 20,

            // when the user cilck to type , the kybord will be the defult one not the phone call keybord
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text(
                '%',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3), // Border color when enabled but not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3), // Border color when focused
              ),
              hintText: '100',
              hintStyle: const TextStyle(
                color: Color.fromARGB(150, 100, 100, 100),
                fontSize: 25,
                // to move the hint txet up and down 0.1 - 1.3 ...
                height: 1.2,
              ),
            ),

            // onChanged: functun  ======== this onchanged will store the text you enterd to a varable in a functoun see vid 109

            controller: _coursePercentageController,
          ),
        ),
      );
      //TextField(
      //   maxLength: 50,
      //   // when the user cilck to type , the kybord will be the defult one not the phone call keybord
      //   keyboardType: TextInputType.number,
      //   decoration: const InputDecoration(
      //       label: Text('Grade'),
      //       border: OutlineInputBorder(),
      //       hintText: '100',
      //       hintStyle: TextStyle(color: Color.fromARGB(150, 100, 100, 100))),
      //   // onChanged: functun  ======== this onchanged will store the text you enterd to a varable in a functoun see vid 109

      //   controller: _coursePercentageController,
      // );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                child: DropdownButton(
                  menuWidth: 100,
                  menuMaxHeight: 220,
                  borderRadius: BorderRadius.circular(5),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  isExpanded: true,
                  underline: Container(),
                  iconSize: 40,
                  value: _selectedGrades,
                  items: grades.map((ctx) {
                    return DropdownMenuItem(
                      alignment: Alignment.centerLeft,
                      value: ctx,
                      child: Text(ctx),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGrades = value as String;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  void _submitExpenseData() {
    ///////////////////////// for the 100 GPA ////////////////////////
    if (Course.gpaDvideable == 100) {
      String errorTitleMassage = '';

      if (_coursePercentageController.text.isEmpty) {
        errorTitleMassage = 'Missing Input';
      } else if (int.tryParse(_coursePercentageController.text)! > 100 ||
          int.tryParse(_coursePercentageController.text)! < 0) {
        errorTitleMassage = 'Invalid Input';
      }
      // showDialog massage
      if (errorTitleMassage != '') {
        erorrMassage(context, errorTitleMassage,
            'Please enter a number between 0 and 100 in the Mark text field');
      } else {
        // i added the ! to conferm that the _coursePercentageController.text will be an int
        enterdPercentage = int.tryParse(_coursePercentageController.text)!;
        if (_courseNameController.text.isEmpty) {
          // we did it here befor the submiting because the course name will appear in the text field
          if (Course.registeredCourses(Course.gpaDvideable).isEmpty) {
            NewCourse.courseIndexGPA100 = 1;
          }
          _courseNameController.text =
              'Course_${NewCourse.courseIndexGPA100++}'; // we can ues Course.registeredCourses(widget.gpaDvideable).length but i prefer to go 1 2 7 9 than 3 3 4 4 4 as names of courses
        }

        widget.addNewCourse(Course(
            courseName: _courseNameController.text,
            courseGrades: enterdPercentage,
            courseHours: _selectedHours,
            coursePercentage: enterdPercentage.toString()));

        Navigator.pop(context);
        toastPopUp(context, 'Course added successfully');
      }
    }
    ///////////////////////// for the 100 GPA ////////////////////////

    //if GPA is 4 or 5 +_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+

    else {
      if (_courseNameController.text.isEmpty) {
        if (Course.registeredCourses(Course.gpaDvideable).isEmpty) {
          NewCourse.courseIndexGPA4or5 = 1;
        }
        _courseNameController.text = 'Course_${NewCourse.courseIndexGPA4or5++}';
      }
      widget.addNewCourse(Course(
          courseName: _courseNameController.text,
          courseGrades: _selectedGrades,
          courseHours: _selectedHours,
          coursePercentage: enterdPercentage.toString()));

      Navigator.pop(context);
      toastPopUp(context, 'Course added successfully');
    }
    //if GPA is 4 or 5 +_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+
  }
}
