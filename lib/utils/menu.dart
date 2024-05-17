import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';

class ElevatedButtonPressed extends StatelessWidget {
  ElevatedButtonPressed({
    super.key,
    required this.text,
    required this.icon,
    required this.x,
    required this.y,
    required this.targetPage,
    required this.isMode,
  });
  final WidgetBuilder targetPage;
  final String text;
  final IconData icon;
  final double x;
  final double y;
  final int isMode;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: targetPage),
        );
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(x, y)),
        foregroundColor: MaterialStateProperty.all(AppTheme.getModeColor(
            AppTheme.lightWhite, AppTheme.darkWhite, isMode)),
        backgroundColor: MaterialStateProperty.all(AppTheme.getModeColor(
            AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppTheme.getModeColor(
                AppTheme.lightWhite, AppTheme.lightWhite, isMode),
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppTheme.getModeColor(
                  AppTheme.lightWhite, AppTheme.lightWhite, isMode),
            ),
          ),
        ],
      ),
    );
  }
}

class ElevatedButtonNotPressed extends StatelessWidget {
  const ElevatedButtonNotPressed({
    super.key,
    required this.text,
    required this.icon,
    required this.x,
    required this.y,
    required this.targetPage,
    required this.isMode,
  });
  final WidgetBuilder targetPage;
  final String text;
  final IconData icon;
  final double x;
  final double y;
  final int isMode;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: targetPage),
        );
      },
      style: ButtonStyle(fixedSize: MaterialStateProperty.all(Size(x, y))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: AppTheme.getModeColor(
                  AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppTheme.getModeColor(
                AppTheme.lightBlue,
                AppTheme.darkBlue,
                isMode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Mun2ContainerPressed extends StatelessWidget {
  Mun2ContainerPressed({
    super.key,
    required this.text,
    required this.icon,
    required this.sw,
    required this.sh,
    required this.onPressed,
    required this.isMode,
  });
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final double sw;
  final double sh;
  final int isMode;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed;
      },
      child: sw < 1450
          ? Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkWhite,isMode)?.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(
                            AppTheme.lightBlue, AppTheme.darkBlue, isMode).withOpacity(0.4),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: AppTheme.getModeColor(
                    AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                size: 40,
              ),
            )
          : Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkWhite,isMode)?.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(
              AppTheme.lightBlue, AppTheme.darkBlue, isMode).withOpacity(0.4),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: AppTheme.getModeColor(
                        AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                    size: 40,
                  ),
                  Gap(10),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppTheme.getModeColor(
                          AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class Mun2ContainerNotPressed extends StatelessWidget {
  const Mun2ContainerNotPressed({
    super.key,
    required this.text,
    required this.icon,
    required this.sw,
    required this.sh,
    required this.onPressed,
    required this.isMode,
  });
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final double sw;
  final double sh;
  final int isMode;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: sw < 1450
          ? Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.getModeColor(
                    AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(
                            AppTheme.lightBlue, AppTheme.darkBlue.withOpacity(.7), isMode),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: AppTheme.getModeColor(
                    AppTheme.lightBlue1, AppTheme.darkBlue, isMode),
                size: 40,
              ),
            )
          : Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.getModeColor(
                    AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getModeColor(
                            AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                        .withOpacity(.7),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.darkBlue, isMode),
                    size: 40,
                  ),
                  Gap(10),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppTheme.getModeColor(
                          AppTheme.lightBlue1, AppTheme.darkBlue, isMode),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
