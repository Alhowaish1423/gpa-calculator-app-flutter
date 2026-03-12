import 'package:flutter/material.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({
    super.key,
    required this.chooseTypeOfGpaScreen1,
    required this.chooseTypeOfGpaScreen2,
  });

  final void Function() chooseTypeOfGpaScreen1;
  final void Function() chooseTypeOfGpaScreen2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/258000afc3b4703d8d0079467949343b.png',
                width: screenWidth * 4,
                height: screenHeight * 0.3, // Give it a consistent height
                //fit: BoxFit.contain,
               // gaplessPlayback: true, // Prevents flashing
              ),
              SizedBox(height: screenHeight * 0.05),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.45,
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
                              padding: EdgeInsets.fromLTRB(0,
                                  screenHeight * 0.015, 0, screenHeight * 0.04),
                              child: Text(
                                'Select GPA Type',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                              ),
                            ),
                            // University Button
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
                                onPressed: chooseTypeOfGpaScreen1,
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    screenWidth * 0.7,
                                    screenHeight * 0.08,
                                  ),
                                ),
                                child: const Text('University'),
                              ),
                            ),
                            // High School Button
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
                                onPressed: chooseTypeOfGpaScreen2,
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    screenWidth * 0.7,
                                    screenHeight * 0.08,
                                  ),
                                ),
                                child: const Text('High School'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share, size: screenWidth * 0.08),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.star_rate, size: screenWidth * 0.08),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'images/linkedin.png',
                        width: screenWidth * 0.08,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
