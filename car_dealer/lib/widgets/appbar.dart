import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(
          "assets/images/logo5.png",
          fit: BoxFit.contain,
          height: 19,
        ),
      ),
      backgroundColor: Color(0xFF041E42),
      title: Text(
        "Car Buddy",
        style: GoogleFonts.oswald(),
      ),
    )
    ;
  }
}
