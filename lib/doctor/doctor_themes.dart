
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_styles.dart';

class Themes extends StatefulWidget {
  const Themes({
    Key? key,

    required this.sw,
    required this.sh,
    required this.isMode,

  }) : super(key: key);

  final double sw;
  final double sh ;
  final int isMode;
  @override
  _ThemesState createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {

  @override
  Widget build(BuildContext context) {
    double sh = widget.sh;
    double sw = widget.sw;
    var isMode = widget.isMode;

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
                isMode),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 50,
            child: GestureDetector(
              onTap: () {
                setState((){
                isMode = 1;
                });
              },
              child: Container(
                width: 220,
                height: sh * 0.3,
                decoration: BoxDecoration(
                  color: AppTheme.getModeColor(
                      AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.getModeColor(
                          AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                          .withOpacity(.4),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppTheme.lightBlue1,
                        AppTheme.lightBlue2,
                        AppTheme.lightBlue,
                        AppTheme.lightGray,
                        AppTheme.lightWhite,
                      ]),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: GestureDetector(
              onTap: () {
                setState((){
                  isMode = 2;
                });
              },
              child: Container(
                width: 220,
                height: sh * 0.3,
                decoration: BoxDecoration(
                  color: AppTheme.getModeColor(
                      AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.getModeColor(
                          AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                          .withOpacity(.4),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppTheme.darkBlue1,
                        AppTheme.darkBlue2,
                        AppTheme.darkBlue,
                        AppTheme.darkGray,
                        AppTheme.darkWhite,
                      ]),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: Container(
              width: 220,
              height: sh * 0.3,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: AppTheme.getModeColor(
                    AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                        .withOpacity(.4),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 50,
            child: Container(
              width: 220,
              height: sh * 0.3,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: AppTheme.getModeColor(
                    AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                        .withOpacity(.4),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}