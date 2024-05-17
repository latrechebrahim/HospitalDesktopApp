import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import '../../services/dio.dart';

class DoctorsCard extends StatefulWidget {
  final String Name;
  final String photo;
  final String Phone_number;
  final String Specialization;
  final bool isAvailable;
  final double sh;
  final double sw;
  final int isMode;

  const DoctorsCard({
    super.key,
    required this.Name,
    required this.photo,
    required this.Phone_number,
    required this.Specialization,
    required this.isAvailable,
    required this.sh, 
    required this.sw,
    required this.isMode,
  });

  @override
  _DoctorsCardState createState() => _DoctorsCardState();
}

class _DoctorsCardState extends State<DoctorsCard> {

  DioService dioService = DioService();

  @override
  Widget build(BuildContext context) {
    var Name = widget.Name;
    var photo = widget.photo;
    var Specialization = widget.Specialization;
    var Phone_number = widget.Phone_number;
    var isAvailable = widget.isAvailable;
    var isMode = widget.isMode;

    return SizedBox(
      height: 100,
      child: Card(
        color: AppTheme.getModeColor(
            AppTheme.lightBlue, AppTheme.darkWhite, isMode),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  child: isAvailable
                      ? Container(
                    alignment: AlignmentDirectional.center,
                    width:  120,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppTheme.getModeColor(AppTheme.lightgreen, AppTheme.darkgreen, isMode),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getModeColor(AppTheme.lightgreen, AppTheme.darkgreen, isMode),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      'Available',
                      style: TextStyle(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                      :Container(
                    alignment: AlignmentDirectional.center,
                    width:  120,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode).withOpacity(.4),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      ('Un Available'),
                      style: TextStyle(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightRed, isMode),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(0),
                                      topStart: Radius.circular(10),
                                    bottomEnd: Radius.circular(100),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(photo),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          Gap(10),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  Name,
                                  style: TextStyle(
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                    fontSize: 20,
                                  ),
                                ),
                                Gap(10),
                                widget.sw < 1450
                                    ? Text('')
                                    : Text(
                                  Specialization,
                                  style: TextStyle(
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                    fontSize: 15,
                                  ),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
