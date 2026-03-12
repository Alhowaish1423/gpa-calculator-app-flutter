import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';
import 'package:mygpa_app/phase4/course_item.dart';

class CourseList extends StatelessWidget {
  const CourseList(
      {super.key,
      required this.courses,
      required this.onRemoveCouruse,
      required this.getsCourseContent});
  final List<Course> courses;
  final void Function(Course course) onRemoveCouruse;
  final void Function(Course course) getsCourseContent;

  @override
  Widget build(BuildContext context) {
    // this ListView is used just like colum but it better for outputing lists , because it better pformens. also the ListViwe will make it scrolable by defult
    // .builder -- it will display the llist that have been called only so that if thier 100000 list it will display only the colled one so that the porgram dose not crash
    // => just like retern #########  (){ retern Text } === () => Text
    return ListView.builder(
       // must wrap the listview with expanded so it will apperr in the screen
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(courses[index]),
          background: Container(
            color: const Color.fromARGB(255, 255, 0, 0),
          ),
          onDismissed: (direction) => onRemoveCouruse(courses[index]),
          child:  GestureDetector(
            onTap: () => getsCourseContent(courses[index]),
            child:  CourseItem(courses[index]),// Your card content
          ),
         
        );
      },
    );
  }
}
