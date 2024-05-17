import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class SlidingCard extends StatefulWidget {
  final String Name;
  final String image;
  final String date;
  final bool isConformed;
  final double sh;
  final double sw;
  final int isMode;
  const SlidingCard({
    super.key,
    required this.Name,
    required this.date,
    required this.image,
    required this.sh,
    required this.sw,
    required this.isConformed,
    required this.isMode,
  });

  @override
  _SlidingCardState createState() => _SlidingCardState();
}

class _SlidingCardState extends State<SlidingCard> {

  @override
  Widget build(BuildContext context) {
    var isMode = widget.isMode;
    var sw = widget.sw;
    var sh = widget.sh;
    return SizedBox(
      height: 100,
      child: Card(
        color: AppTheme.getModeColor(
            AppTheme.lightBlue, AppTheme.darkWhite, isMode),
        elevation: 4,
        child: Stack(children: [
          Positioned(
            right: 25,
            bottom: 25,
            child: widget.isConformed
                ? Container(
                    alignment: AlignmentDirectional.center,
                    width: 150,
                    height: sh * 0.05,
                    decoration: BoxDecoration(
                      color: AppTheme.getModeColor(AppTheme.lightgreen, AppTheme.darkgreen, isMode),
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getModeColor(AppTheme.lightgreen, AppTheme.darkgreen.withOpacity(.01), isMode),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      'Conformed',
                      style: TextStyle(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightgreen, isMode),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                : Container(
                    alignment: AlignmentDirectional.center,
                    width: 150,
                    height: sh * 0.05,
                    decoration: BoxDecoration(
                      color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode),
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode).withOpacity(.4),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      ('In Progress'),
                      style: TextStyle(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightRed, isMode),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(0),
                  topStart: Radius.circular(10),
                  bottomEnd: Radius.circular(100),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gap(20),
                Container(
                  child: Text(
                    widget.Name,
                    style: TextStyle(
                      color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                      fontSize: 20,
                    ),
                  ),
                ),
                Gap(30),
                widget.isConformed
                    ? Container(
                        child: Text(
                          widget.date,
                          style: TextStyle(
                            color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                            fontSize: 20,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ]),
        ]),
      ),
    );
  }
}
