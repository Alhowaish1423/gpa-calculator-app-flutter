import 'package:flutter/material.dart';

class GpaOutOfWhatButton extends StatelessWidget {
  // is anther way to make a named argument
  const GpaOutOfWhatButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.gradientColors});

  final String buttonText;
  final void Function() onTap;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    /* there is two containers (outter and inner) 
    the inner has only the color so it will 
    cut the edges of the color only without the shadow(outer continer)
    */
    return Container(
      width: 200,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 12,
              offset: const Offset(5, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                // to make the button the same size and shape of the container behied it
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                // to remove the shadow appering when the button is clicked
                shadowColor: Colors.transparent,
                // colors.transparent to make the button with no color only shdow ( to abule to see the gradient color background behied it )
                //elevation : 0 is to delete the shadw of the button
                backgroundColor: Colors.transparent,
                elevation: 0),
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 22,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
