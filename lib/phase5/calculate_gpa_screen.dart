import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';

class CalculateGpaScreen extends StatelessWidget {
  const CalculateGpaScreen(
      {super.key,
      required this.oldTotalHours,
      required this.lastGPA,
      required this.backButton});
  final TextEditingController oldTotalHours;
  final TextEditingController lastGPA;
  final void Function() backButton;

  @override
  Widget build(BuildContext context) {
    var registeredCourses = Course.registeredCourses;
    List<String> grades = [
      'A+',
      'A',
      'B+',
      'B',
      'C+',
      'C',
      'D+',
      'D',
      'F',
      'DN'
    ];
    List<double> gradePoints = [];
    // List<dynamic> is dynamic because it can be either grades or Percentage  ['A+','C','B+'] OR  [92,86,79]

    double GPA;
    double previousGPA = 0.0; // for the cumulitive gpa
    int previousTotalHours = 0; //  for the cumulitive gap
    double totalGradePoints = 0;
    int totalCreditHours = 0;

    List<dynamic> studentGradesList = registeredCourses(Course.gpaDvideable)
        .map((course) => course.courseGrades)
        .toList();
    List<int> studentCreditHoursList = registeredCourses(Course.gpaDvideable)
        .map((course) => int.parse(course.courseHours))
        .toList();

    String gpaImage = 'images/gpaImage.png';
    double GPAtoPercentage = 0.0;
    String ClassHonors = '';
    String GPAname = '';
    double gpaDvideable = Course.gpaDvideable;
    String WarningExplain =
        'If you get 3 academic warnings, you will be expelled from the university. You must have above a ${gpaDvideable - 3.00} GPA to not get an academic warning.';
    int totalCoursesPoint = 0;
    int studentMarkPoints = 0;

    // total credit hours
    for (int temp in studentCreditHoursList) {
      totalCreditHours += temp;
    }

    void calculateTheGpaFor5and4() {
      // calclate the gpa
      for (int i = 0; i < studentGradesList.length; i++) {
        String grade = studentGradesList[i];
        int hours = studentCreditHoursList[i];

        // Find the index of the grade in the grades list
        int gradeIndex = grades.indexOf(grade);

        // Get the corresponding grade points
        double gradePoint = gradePoints[gradeIndex];

        // Calculate the weighted grade points for this course
        totalGradePoints += gradePoint * hours;
      }
    }

// the DN is == 1.0 not 0.0 as i thoght
    if (Course.gpaDvideable == 5) {
      gradePoints = [5.0, 4.75, 4.5, 4.0, 3.5, 3.0, 2.5, 2.0, 1.0, 1.0];
      calculateTheGpaFor5and4();
    } else if (Course.gpaDvideable == 4) {
      gradePoints = [4.0, 3.75, 3.5, 3.0, 2.5, 2.0, 1.50, 1.0, 0.0, 0.0];
      calculateTheGpaFor5and4();
    } else if (Course.gpaDvideable == 100 &&
        Course.UniversityOrHighSchool == 1) {
      for (int i = 0; i < studentGradesList.length; i++) {
        int hours = studentCreditHoursList[i];
        totalGradePoints += (studentGradesList[i] as int) * hours;
      }
    } else if (Course.gpaDvideable == 100 &&
        Course.UniversityOrHighSchool == 2) {
      totalCoursesPoint = (registeredCourses(gpaDvideable).length);
      for (int i = 0; i < studentGradesList.length; i++) {
        studentMarkPoints += (studentGradesList[i] as int);
      }
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////

    if (Course.UniversityOrHighSchool == 1) {
      // cumulative gpa
      if (Course.SemesterOrCumulative == 2) {
        previousGPA = double.parse(lastGPA.text.trim().replaceAll(',', '.'));
        previousTotalHours = int.parse(oldTotalHours.text);
        GPA = (totalGradePoints + (previousGPA * previousTotalHours)) /
            (totalCreditHours + previousTotalHours);
      } else {
        // term gpa
        GPA = totalGradePoints / totalCreditHours;
      }
    } else {
      // term gpa
      GPA = studentMarkPoints / totalCoursesPoint;
      // cumulative
      if (Course.SemesterOrCumulative == 2) {
        previousGPA = double.parse(lastGPA.text.trim().replaceAll(',', '.'));
        GPA = (previousGPA + GPA) / 2;
      }
    }

    if (gpaDvideable == 5 || gpaDvideable == 4) {
      GPAtoPercentage = gpaDvideable == 5 ? GPA * 20 : GPA * 25;

      // 4.50 - 5.00
      // 3.50 - 4.00
      if (GPA >= (gpaDvideable - 0.50) && GPA <= gpaDvideable) {
        if (GPA >= (gpaDvideable - 0.25)) {
          ClassHonors = '-First Honors-';
        } else if (GPA < (gpaDvideable - 0.25) &&
            GPA >= (gpaDvideable - 0.75)) {
          ClassHonors = '-Second Honors-';
        }

        GPAname = 'Excellent';
        //3.75 - less than 4.50
        //2.75 - less than 3.50
      } else if (GPA >= (gpaDvideable - 1.25) && GPA < (gpaDvideable - 0.50)) {
        if (GPA >= (gpaDvideable - 0.75)) {
          ClassHonors = '-Second Honors-';
        }

        GPAname = 'Very Good';
        //2.75 - less than 3.75
        //1.75 - less than 2.75
      } else if (GPA >= (gpaDvideable - 2.25) && GPA < (gpaDvideable - 1.25)) {
        GPAname = 'Good';
        // 2.00 - less than 2.75
        //1.00 - less than 1.75
      } else if (GPA >= (gpaDvideable - 3.00) && GPA < (gpaDvideable - 2.25)) {
        GPAname = 'Pass';
        // less than 2.00
        // less than 1.00
      } else if (GPA < (gpaDvideable - 3.00)) {
        GPAname = 'Fail';
        ClassHonors = '- Academic Warning !!! -';
        gpaImage = 'images/fail1.png';
      }
    } else {
      if (GPA >= 90 && GPA <= 100) {
        if (GPA >= 95) {
          ClassHonors = '-First Honors-';
        } else if (GPA < 95 && GPA >= 85) {
          ClassHonors = '-Second Honors-';
        }

        GPAname = 'Excellent';
        //3.75 - less than 4.50
        //2.75 - less than 3.50
      } else if (GPA >= 75 && GPA < 90) {
        if (GPA >= 85) {
          ClassHonors = '-Second Honors-';
        }

        GPAname = 'Very Good';
        //2.75 - less than 3.75
        //1.75 - less than 2.75
      } else if (GPA >= 55 && GPA < 75) {
        GPAname = 'Good';
        // 2.00 - less than 2.75
        //1.00 - less than 1.75
      } else if (GPA >= 40 && GPA < 55) {
        GPAname = 'Pass';
        // less than 2.00
        // less than 1.00
      } else if (GPA < 40) {
        GPAname = 'Fail';
        ClassHonors = '- Academic Warning !!! -';
        gpaImage = 'images/fail1.png';
      }
    }

// just to print the fail image

    Widget showPercentage() {
      if (gpaDvideable != 100) {
        return Align(
          alignment: Alignment.center,
          child: Text(
            'Percentage: ${GPAtoPercentage.toStringAsFixed(2)}%',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 25,
            ),
          ),
        );
      } else {
        return const SizedBox
            .shrink(); // to retern nothing and do not do any rendring
      }
    }
     Widget showClassHonors() {
      if (Course.UniversityOrHighSchool == 1) {
        return Align(
                alignment: Alignment.center,
                child: Text(
                  ClassHonors,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 25,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.justify,
                ),
              );
      } else {
        return const SizedBox
            .shrink(); // to retern nothing and do not do any rendring
      }
    }

    Widget showWarningExplain() {
      if (ClassHonors == '- Academic Warning !!! -'&& Course.UniversityOrHighSchool ==1) {
        if (gpaDvideable == 100) {
          WarningExplain =
              'If you get 3 academic warnings, you will be expelled from the university. You must have above a 40% GPA to not get an academic warning.';
        }
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 30, 5, 15),
            child: Text(
              WarningExplain,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 25,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return Column(
      children: [
        Image.asset(gpaImage),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  (gpaDvideable == 100
                      ? 'Percentage: ${GPA.toStringAsFixed(2)}%'
                      : 'GPA: ${GPA.toStringAsFixed(2)}'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 38),
                ),
              ),
              showPercentage(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'General Grade: $GPAname',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 25,
                      fontWeight: FontWeight.normal),
                ),
              ),
              showClassHonors(),
              
              showWarningExplain(),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: backButton,
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 25,
          ),
          label: Text('Back'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 251, 255, 0)),
        )
      ],
    );
  }
}
