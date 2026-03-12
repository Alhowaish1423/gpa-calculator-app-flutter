import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/course.dart';

class GpaScreen extends StatelessWidget {
  const GpaScreen(
      {super.key,
      required this.chooseGpaScreen1,
      required this.chooseGpaScreen2});
  final void Function() chooseGpaScreen1;
  final void Function() chooseGpaScreen2;




  @override
  Widget build(BuildContext context) {
    
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Course.UniversityOrHighSchool==1? 'images/3842b946cdd8c7db1e5aac21ea3655b5.png': 'images/d38c5a15d856ec2a5d6a41330f327b17.png', width: 300),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(6, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                        child: Text(
                          'Select GPA Type',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(4, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: chooseGpaScreen1,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(250, 75),
                          ),
                          child: const Text('Semester'),
                        ),
                      ),
                      //SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(4, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: chooseGpaScreen2,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(250, 75),
                          ),
                          child: const Text('Cumulative'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star_rate,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'images/linkedin.png',
                  width: 35,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
