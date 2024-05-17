import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hospital_managements/utils/app_styles.dart';

class AppointmentsCardAdmin extends StatefulWidget {
  final String NameDoctor;
  final String NamePatient;
  final String imageDoctor;
  final String imagePatient;
  final String date;
  final bool isConformed;
  final double sh;
  final double sw;
  final int isMode;
  const AppointmentsCardAdmin({
    super.key,
    required this.NameDoctor,
    required this.NamePatient,
    required this.imageDoctor,
    required this.imagePatient,
    required this.date,
    required this.sh,
    required this.sw,
    required this.isConformed,
    required this.isMode,
  });

  @override
  _AppointmentsCardAdminState createState() => _AppointmentsCardAdminState();
}

class _AppointmentsCardAdminState extends State<AppointmentsCardAdmin> {
  @override
  Widget build(BuildContext context) {
    var isMode = widget.isMode;
    var sw = widget.sw;
    var sh = widget.sh;
    return SizedBox(
      child: TextButton(
        onPressed: () {},
        child: Card(
          color:  AppTheme.getModeColor(
              AppTheme.lightBlue, AppTheme.darkWhite, isMode),
          elevation: 4,
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(100),
                            image: DecorationImage(
                              image: widget.imageDoctor.isNotEmpty
                                  ? FileImage(File(widget.imageDoctor) as File) as ImageProvider<Object>
                                  : AssetImage('images/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.NameDoctor,
                            style: TextStyle(
                              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    widget.isConformed
                        ? Container(
                            child: Text(
                              widget.date,
                              style: TextStyle(
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                fontSize: 20,
                              ),
                            ),
                          )
                        : Container(
                            child: Text(
                              ("in Progress   "),
                              style: TextStyle(
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                fontSize: 20,
                              ),
                            ),
                          ),
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(100),
                            image: DecorationImage(
                              image: widget.imagePatient.isNotEmpty
                                  ? FileImage(File(widget.imagePatient) as File) as ImageProvider<Object>
                                  : AssetImage('images/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.NamePatient,
                            style: TextStyle(
                              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    widget.isConformed
                        ? Container(
                            alignment: AlignmentDirectional.center,
                            width: 150,
                            height: sh * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green,
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Text(
                              'Conformed',
                              style: TextStyle(
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
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
                                  color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Text(
                              ('In Progress'),
                              style: TextStyle(
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
