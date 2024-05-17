import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'dart:async';

class NotifContainer extends StatelessWidget {
  const NotifContainer({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String? title;
  final String? content;



  @override
  Widget build(BuildContext context) {
  int isMode =1;

    return AlertDialog(
      title: Text(
        title ?? '',
        style: TextStyle(
            color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode), fontSize: 20, fontWeight: FontWeight.normal),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (content != null)
            Padding(
              padding: EdgeInsets.only(bottom: 1),
              child: AnimatedTextKit(animatedTexts: [
                ColorizeAnimatedText(content!,
                    textStyle: GoogleFonts.akshar(
                        fontSize: 20,
                        color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.darkDark, isMode),
                        fontStyle: FontStyle.italic
                        ),
                        colors: [
                            AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                          AppTheme.getModeColor(AppTheme.lightDark, AppTheme.darkDark, isMode),
                        ]
                        ),
              ]),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(100, 30)),
              foregroundColor: MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
              backgroundColor: MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
            ),
            child: Text(
              "OK",
              style: TextStyle(
                  color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      shadowColor: Colors.black,
      backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
      icon: Icon(
        Icons.notifications,
        color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
        size: 30,
      ),
      elevation: 5.0,
    );
  }
}

///////////////////////////////////

void showDelayedAnimatedDialog(
    BuildContext context, String title, String content, Duration delay) {
  Future.delayed(delay, () {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.6),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.fromDirection(BorderSide.strokeAlignCenter),
                  end: Offset.zero,
                ).animate(animation),
                child: NotifContainer(
                  title: title,
                  content: content,
                ),
              ),
            ],
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  });
}
