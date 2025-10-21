import 'package:flutter/material.dart';

class AllSetLogo extends StatelessWidget {
  final bool isWhite;
  const AllSetLogo({super.key, this.isWhite = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      // alignment: AlignmentGeometry.centerRight,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                text: 'a',
                children: [
                  TextSpan(
                    text: 'l',
                    style: TextStyle(
                      color: isWhite ? Colors.white : Color(0xFFFF3131),
                    ),
                  ),
                  TextSpan(
                    text: 'l',
                    style: TextStyle(
                      color: isWhite ? Colors.white : Color(0xFFFFDE59),
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                color: isWhite ? Colors.white : Color(0xFF38B6FF),
                fontSize: 75,
                fontFamily: 'Telegraf',
                fontWeight: FontWeight.w800,
              ),
            ),
            Text.rich(
              TextSpan(
                text: 's',
                children: [
                  TextSpan(text: 'e'),
                  TextSpan(text: 't'),
                ],
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 75,
                fontFamily: 'Telegraf',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Positioned(
          right: -29,
          top: 15,
          child: Image.asset(
            'assets/images/tick.png',
            fit: BoxFit.cover,
            scale: 10,
          ),
        ),
      ],
    );
  }
}
