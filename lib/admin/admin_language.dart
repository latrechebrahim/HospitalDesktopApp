import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../connection/validation.dart';
import '../helper/Notif_error.dart';
import '../services/dio.dart';
import '../utils/app_styles.dart';
import '../utils/utils_doctors/Temes.dart';
import 'admin_settings.dart';

class Language extends StatefulWidget {
  const Language({
    Key? key,
    required this.sw,
    required this.sh,
    required this.isMode,
  }) : super(key: key);

  final double sw;
  final double sh;
  final int isMode;

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    double sh = widget.sh;
    double sw = widget.sw;
    int isMode = widget.isMode;

    return Container(
      width: 500,
      height: sh * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getModeColor(
          AppTheme.lightBlue.withOpacity(0.4),
          AppTheme.darkBlue,
          isMode,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getModeColor(
              AppTheme.lightWhite,
              AppTheme.darkWhite.withOpacity(.4),
              isMode,
            ),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
