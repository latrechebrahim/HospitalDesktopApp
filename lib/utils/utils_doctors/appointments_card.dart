import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/text_edit.veiw.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import '../../doctor/doctor_appointments.dart';
import '../../services/dio.dart';

class AppointmentsCard extends StatefulWidget {
  final VoidCallback onDelete;
  final String Name;
  final String image;
  final String date;
  final String Content;
  final bool isConformed;
  final double sh;
  final double sw;
  final int isMode;
  final int id;
  const AppointmentsCard({
    super.key,
    required this.Name,
    required this.date,
    required this.image,
    required this.sh,
    required this.sw,
    required this.isConformed,
    required this.Content,
    required this.isMode,
    required this.id,
    required this.onDelete,

  });

  @override
  _AppointmentsCardState createState() => _AppointmentsCardState();
}

class _AppointmentsCardState extends State<AppointmentsCard> {
  bool _isLoading = false;
  DioService dioService = DioService();
  TextEditingController date = TextEditingController();
  TextEditingController id = TextEditingController();

  Map<String, dynamic> _currentData = {};

  Future<void> _refreshData() async {
    if (!mounted) return;
    final id = widget.id;
    if (id != null) {
      final idString = id.toString();
      try {
        final data = await dioService.showinfoDoctor(idString);
        if (!mounted) return;
        setState(() {
          Map<String, dynamic> userData = data['user'];
          print(userData.toString());
          _currentData = userData;
        });
      } catch (error) {
        print('Error occurred while refreshing data: $error');
      }
    } else {
      print('Error: Doctor ID is null');
    }
  }

  @override
  void initState() {
    super.initState();
    id.text = widget.id.toString();
    date.text = widget.date.toString();
  }
  @override
  Widget build(BuildContext context) {
    var isMode = widget.isMode;
    var sw = widget.sw;
    var sh = widget.sh;

    return SizedBox(
      height: 150,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: widget.isConformed ? AppTheme.getModeColor(AppTheme.lightgreen, AppTheme.darkgreen, isMode): AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode),
                title: Container(
                  height: 80,
                  width: 400,
                  decoration: BoxDecoration(
                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(sw * 0.02),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.darkDark, isMode).withOpacity(0.4),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'The patient condition',
                          style: TextStyle(
                            color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.lightWhite, isMode),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                          borderRadius: BorderRadius.circular(sw * 0.02),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode).withOpacity(.4),
                              blurRadius: 30,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.Content,
                              style: TextStyle(
                                color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.lightWhite, isMode),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                       TextField(
                         style: TextStyle(
                           color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                         ),
                            readOnly: false,
                            controller: date,
                            cursorColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                            onTap: () async {
                              DateTime initialDate = DateTime.now();
                              if (widget.date != null &&
                                  widget.date.isNotEmpty) {
                                try {
                                  initialDate = DateTime.parse(
                                      widget.date);
                                } catch (e) {
                                  print('Error parsing date: $e');
                                }
                              }
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: initialDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2080)
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  date.text = formatDate(
                                      selectedDate, [yyyy, '/', mm, '/', dd]).toString();
                                });
                              }
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_month,
                                color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: "Date",
                              labelStyle:  TextStyle(
                            color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                         fontSize: 16,
                       ),
                            ),
                       ),
                    ],
                  ),
                ),
                actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm Deletion"),
                                    content: Text("Are you sure you want to delete this Appointment?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                          setState(() {});
                                          widget.onDelete();
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              ); // Close the dialog
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                borderRadius: BorderRadiusDirectional.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.darkDark, isMode),
                                    blurRadius: 30,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        TextButton(
                          onPressed: () async {
                            dioService.updateAppointments(
                              context,
                              widget.id.toString(),
                              date.text.toString(),
                            );

                            Navigator.of(context).pop();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: _isLoading
                              ? CircularProgressIndicator(
                            color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                          )
                              :Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                              borderRadius: BorderRadiusDirectional.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.darkDark, isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 Icon(
                                    Icons.update,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                ],
              );
            },
          );
        },
        child: Card(
          color: AppTheme.getModeColor(
              AppTheme.lightBlue, AppTheme.darkWhite, isMode),
          elevation: 4,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 150,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(0),
                            topStart: Radius.circular(100),
                            bottomEnd: Radius.circular(0),
                            topEnd: Radius.circular(0),
                          ),
                          color: AppTheme.getModeColor(
                              AppTheme.lightBlue2.withOpacity(.6), AppTheme.lightDark, isMode),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 180,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/DNA.png'),
                              fit: BoxFit.cover

                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 25,
                      bottom: 40,
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
                    Container(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(30),
                              topStart: Radius.circular(0),
                              topEnd: Radius.circular(0),
                              bottomEnd: Radius.circular(80),
                            ),
                            image: DecorationImage(
                              image: AssetImage(widget.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(10),
                        Column(
                          children: [
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
                                : Container(
                              child: Text(
                                ("in Progress   "),
                                style: TextStyle(
                                  color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                                        ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
