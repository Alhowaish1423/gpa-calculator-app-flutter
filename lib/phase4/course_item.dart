import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';

class CourseItem extends StatelessWidget {
  const CourseItem(this.course, {super.key});

  // to reseve a expense ( date , tital , amount , ets)
  final Course course;

  Widget UniversityOrHighSchool(context) {
    if (Course.gpaDvideable == 100 && Course.UniversityOrHighSchool == 2) {
      return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            course.courseName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,fontWeight: FontWeight.normal),
                  
          ),
            ],
          ),
        ),

        const SizedBox(width: 40,),

        // Right side: smaller text aligned to bottom
        Column(
          mainAxisAlignment: MainAxisAlignment.start, // push it to the bottom of the column
          children: [
            Text(
                'Mark: ${course.courseGrades}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,fontWeight: FontWeight.normal),
                   
              ),
          ],
        ),
      ],
    );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            course.courseName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          Row(
            children: [
              Text(
                'Hour: ${course.courseHours}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
              const Spacer(),
              Text(
                Course.gpaDvideable == 100
                    ? 'Mark: ${course.courseGrades}'
                    : 'Grade: ${course.courseGrades}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
       elevation: 3,
       
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        child: UniversityOrHighSchool(context),
      ),
    );
  }
}
