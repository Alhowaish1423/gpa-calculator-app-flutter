import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';
import 'package:mygpa_app/helpers/drawer_screen.dart';

import 'package:mygpa_app/phase1.1/gpa_screen.dart';
import 'package:mygpa_app/phase1/stage_screen.dart';
import 'package:mygpa_app/phase2/gpa_out_of_what_screen.dart';
import 'package:mygpa_app/phase3/add_courses_screen.dart';

import 'package:mygpa_app/phase5/calculate_gpa_screen.dart';

class MyGpa extends StatefulWidget {
  const MyGpa({super.key});

  static String language = 'ar'; // used to change the language
  @override
  State<MyGpa> createState() {
    return _MyGpaState();
  }
}

class _MyGpaState extends State<MyGpa> {
  final TextEditingController _oldTotalHours = TextEditingController();
  final TextEditingController _lastGPA = TextEditingController();
  var activeScreen = 'chooseStageScreen';

  @override
  void dispose() {
    _oldTotalHours.dispose();
    _lastGPA.dispose();
    super.dispose();
  }

  void chooseTypeOfGpaScreen1() {
    setState(
      () {
        activeScreen = 'GpaScreen';
        Course.UniversityOrHighSchool = 1; // University
      },
    );
  }

  void chooseTypeOfGpaScreen2() {
    setState(
      () {
        activeScreen = 'GpaScreen';
        Course.UniversityOrHighSchool = 2; // high school
      },
    );
  }

  void chooseGpaScreen1() {
    Course.SemesterOrCumulative = 1; // Semester gpa
    if (Course.UniversityOrHighSchool == 1) {
      setState(
        () {
          activeScreen = 'chooseGpaScreen';
        },
      );
    } else {
      Course.gpaDvideable = 100;
      // go dirictly to the addCourse screen - no need to choose a gpa , gpa=100
      setState(() {
        activeScreen = 'TermScreen';
      });
    }
  }

  void chooseGpaScreen2() {
    Course.SemesterOrCumulative = 2; // Cumulative gpa
    if (Course.UniversityOrHighSchool == 1) {
      setState(
        () {
          activeScreen = 'chooseGpaScreen';
        },
      );
    } else {
      // go dirictly to the addCourse screen - no need to choose a gpa , gpa=100
      Course.gpaDvideable = 100;
      setState(() {
        activeScreen = 'cumulativeScreen';
      });
    }
  }

  void chooseGPA4() {
    setState(
      () {
        Course.gpaDvideable = 4;
        if (Course.SemesterOrCumulative == 1) {
          activeScreen = 'TermScreen';
        } else if (Course.SemesterOrCumulative == 2) {
          activeScreen = 'cumulativeScreen';
        }
      },
    );
  }

  void chooseGPA5() {
    setState(
      () {
        Course.gpaDvideable = 5;
        if (Course.SemesterOrCumulative == 1) {
          activeScreen = 'TermScreen';
        } else if (Course.SemesterOrCumulative == 2) {
          activeScreen = 'cumulativeScreen';
        }
      },
    );
  }

  void chooseGPA100() {
    setState(
      () {
        //so does not mistakly enter tha out of 4 or 5 last gpa
        _lastGPA.clear();
        Course.gpaDvideable = 100;
        if (Course.SemesterOrCumulative == 1) {
          activeScreen = 'TermScreen';
        } else if (Course.SemesterOrCumulative == 2) {
          activeScreen = 'cumulativeScreen';
        }
      },
    );
  }

  void backToGpaScreen() {
    setState(
      () {
        if (activeScreen == 'GpaScreen') {
          activeScreen = 'chooseStageScreen';
        }
        if (activeScreen == 'chooseGpaScreen') {
          activeScreen = 'GpaScreen';
        } else if (activeScreen == 'TermScreen' ||
            activeScreen == 'cumulativeScreen') {
          if (Course.UniversityOrHighSchool == 2) {
            activeScreen = 'GpaScreen';
          } else {
            activeScreen = 'chooseGpaScreen';
          }
        } else if (activeScreen == 'calculateScreen' &&
            Course.SemesterOrCumulative == 1) {
          activeScreen = 'TermScreen';
        } else if (activeScreen == 'calculateScreen' &&
            Course.SemesterOrCumulative == 2) {
          activeScreen = 'cumulativeScreen';
        }
      },
    );
  }

  void calculateScreen() {
    setState(
      () {
        activeScreen = 'calculateScreen';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StageScreen(
        chooseTypeOfGpaScreen1: chooseTypeOfGpaScreen1,
        chooseTypeOfGpaScreen2: chooseTypeOfGpaScreen2);
    // only the start (first) screen  appbar
    AppBar currentAppBar = AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
        child: Text('My GPA'),
      ),
      actions: [
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
                onPressed: Scaffold.of(context).openEndDrawer,
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 40,
                )),
          );
        })
      ],
    );
    AppBar allOthersScreensAppBar = AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),

      // I used builder to can make padding to the icondButton in the appbar
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: IconButton(
            onPressed: backToGpaScreen,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 35,
            )),
      ),

      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
        child: Text('My GPA'),
      ),
      actions: [
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
                onPressed: Scaffold.of(context).openEndDrawer,
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 40,
                )),
          );
        })
      ],
    );
    if (activeScreen == 'GpaScreen') {
      screenWidget = GpaScreen(
        chooseGpaScreen1: chooseGpaScreen1,
        chooseGpaScreen2: chooseGpaScreen2,
      );
      currentAppBar = allOthersScreensAppBar;
    }

    if (activeScreen == 'chooseGpaScreen') {
      screenWidget = GpaOutOfWhatScreen(
        chooseGPA4: chooseGPA4,
        chooseGPA5: chooseGPA5,
        chooseGPA100: chooseGPA100,
      );
      currentAppBar = allOthersScreensAppBar;
    } else if (activeScreen == 'TermScreen' ||
        activeScreen == 'cumulativeScreen') {
      screenWidget = AddCoursesScreen(
        calculateScreen: calculateScreen,
        oldTotalHours: _oldTotalHours,
        lastGPA: _lastGPA,
      );

      currentAppBar = allOthersScreensAppBar;
    } else if (activeScreen == 'calculateScreen') {
      screenWidget = CalculateGpaScreen(
        oldTotalHours: _oldTotalHours,
        lastGPA: _lastGPA,
        backButton: backToGpaScreen,
      );
      currentAppBar = allOthersScreensAppBar;
    }

    return Scaffold(
      appBar: currentAppBar,
      endDrawer: const DrawerScreen(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  maxHeight: constraints.maxHeight,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: screenWidget,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
