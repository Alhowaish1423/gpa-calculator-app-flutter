class Course {
  final String courseName;
  var courseGrades;
  final String courseHours;
  final String coursePercentage;

  static final List<Course> _registeredCourses = [];
  static final List<Course> _registeredCourseGPA100 = [];
  static double gpaDvideable = 0.00; // 4 or 5 or 100
  static int SemesterOrCumulative = 0; 
  static int UniversityOrHighSchool = 0; 

  static List<Course> registeredCourses(double gpaDvideable) {
    if (gpaDvideable == 100) {
      return _registeredCourseGPA100;
    } else {
      return _registeredCourses;
    }
  }

  Course({
    required this.courseName,
    required this.courseGrades,
    required this.courseHours,
    required this.coursePercentage,
  });
}
