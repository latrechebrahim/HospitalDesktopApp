import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';

class Appointments_Statistics extends StatelessWidget {
  const Appointments_Statistics({
    super.key,
    required this.sh,
    required this.sw,
    required this.tital,
    required this.total,
    required this.icons,
    required this.isMode,
  });
  final String tital;
  final int total;
  final String icons;
  final double sh;
  final double sw;
  final int isMode;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: sh * 0.20,
      width: sw * 0.20,
      decoration: BoxDecoration(
        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkBlue, isMode),
        borderRadius: BorderRadius.circular(sw * 0.02),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkWhite, isMode).withOpacity(0.4),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: sh * 0.13,
              width: sw * 0.08,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkWhite, isMode).withOpacity(0.4),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode).withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(sw * 0.1),
                  topLeft: Radius.circular(sw * 0.026),
                ),
              ),
              alignment: AlignmentDirectional.topStart,
              child: Image(
                image: AssetImage(icons),
              ),
            ),
          ),
          Positioned(
            top: sh * 0.05,
            right: sw * 0.04,
            child: Text(
              total.toString(),
              style: GoogleFonts.labrada(
                fontSize: 30,
                color: AppTheme.getModeColor(
                    AppTheme.darkWhite, AppTheme.lightWhite, isMode),
              ),
            ),
          ),
          Positioned(
            top: sh * 0.13,
            right: sw < 1440 ? sw * 0.01 : sw * 0.02,
            child: Text(
              tital,
              style: GoogleFonts.labrada(
                fontSize: sw < 1440 ? 16 : 22,
                color: AppTheme.getModeColor(
                    AppTheme.darkWhite, AppTheme.lightWhite, isMode),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
