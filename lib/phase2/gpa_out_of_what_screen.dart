import 'package:flutter/material.dart';
import 'package:mygpa_app/helpers/gpa_out_of_what_button.dart';

class GpaOutOfWhatScreen extends StatelessWidget {
  const GpaOutOfWhatScreen({
    super.key,
    required this.chooseGPA4,
    required this.chooseGPA5,
    required this.chooseGPA100,
  });

  final void Function() chooseGPA4;
  final void Function() chooseGPA5;
  final void Function() chooseGPA100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              Image.asset(
                'images/fb50d010ef7944aa9577fe5844eb9a1b.png',
                width: screenWidth * 0.6,
              ),
              SizedBox(height: screenHeight * 0.03),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: screenHeight * 0.5,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 12,
                          offset: const Offset(5, 12),
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
                            Text(
                              'Choose Grade System',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onSecondary,
                                  ),
                            ),
                            GpaOutOfWhatButton(
                              buttonText: 'out of 5',
                              onTap: chooseGPA5,
                              gradientColors: const [
                                Color.fromARGB(255, 52, 122, 145),
                                Color.fromARGB(255, 84, 143, 159),
                                Color.fromARGB(255, 116, 165, 173),
                              ],
                            ),
                            GpaOutOfWhatButton(
                              buttonText: 'out of 4',
                              onTap: chooseGPA4,
                              gradientColors: const [
                                Color.fromARGB(255, 223, 104, 58),
                                Color.fromARGB(255, 225, 140, 105),
                                Color.fromARGB(255, 228, 176, 153),
                              ],
                            ),
                            GpaOutOfWhatButton(
                              buttonText: 'out of 100',
                              onTap: chooseGPA100,
                              gradientColors: const [
                                Color.fromARGB(255, 112, 90, 55),
                                Color.fromARGB(255, 159, 138, 102),
                                Color.fromARGB(255, 206, 187, 150)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}