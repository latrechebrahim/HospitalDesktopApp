import 'dart:ui';

import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_styles.dart';

class CustomInputContainer extends StatefulWidget {
  const CustomInputContainer({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.icon,
    required this.keyboardType,
    required this.isMode,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final Icon icon;
  final TextInputType keyboardType;
  final int isMode;

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInputContainer> {
  @override
  Widget build(BuildContext context) {
    var isMode = widget.isMode;
    return Container(
      width: 330,
      height: 100,
      child: TextField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        style: TextStyle(
            color: AppTheme.getModeColor(
                AppTheme.darkWhite, AppTheme.lightWhite, widget.isMode)
        ),
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
        color: AppTheme.getModeColor(
        AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
      ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            icon: widget.icon),
      ),
    );
  }
}

class CustomInputPassword extends StatefulWidget {
  const CustomInputPassword({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.icon,
    required this.isMode,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final Icon icon;
  final int isMode;

  @override
  _CustomInputPasswordState createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
  int isMode = widget.isMode;

    return Container(
      width: 330,
      height: 100,
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
            color: AppTheme.getModeColor(
                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
          ),
          icon: widget.icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
              size: 17,
              color: AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
            ),
          ),
        ),
        obscureText: _obscureText,
      ),
    );
  }
}


class CustomOut extends StatefulWidget {
  const CustomOut({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.icon,
    required this.sh,
    required this.sw, required this.isMode,
  }) : super(key: key);

  final String labelText;
  final String controller;
  final IconData icon;
  final double sh;
  final double sw;
  final int isMode;

  @override
  _CustomOutState createState() => _CustomOutState();
}

class _CustomOutState extends State<CustomOut> {


  @override
  Widget build(BuildContext context) {
    var isMode = widget.isMode;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 50,
        width: 300,
            child:
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkWhite.withOpacity(0.1),isMode),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        widget.icon,
                        color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue, isMode),
                        size: widget.sw * 0.02,
                      ),
                    ),
                    Gap(widget.sh * 0.01),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkWhite.withOpacity(0.1),isMode),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoScrollText(
                              curve: Curves.fastOutSlowIn,
                              widget.controller,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue, isMode),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}


