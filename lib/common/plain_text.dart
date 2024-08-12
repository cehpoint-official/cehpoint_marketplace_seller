import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlainText extends StatelessWidget {
  const PlainText({
    super.key,
    required this.name,
    required this.fontsize,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign = TextAlign.start,
  });
  final String name;
  final TextAlign textAlign;
  final double fontsize;
  final FontWeight? fontWeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: textAlign,
      style: GoogleFonts.roboto(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
