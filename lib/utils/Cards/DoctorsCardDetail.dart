import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'dart:io';

import '../../services/dio.dart';

class DoctorsCardDetail extends StatefulWidget {
  final VoidCallback onDelete;
  final String Name;
  final String Email;
  final String photo;
  final String Phone_number;
  final String Specialization;
  final bool isAvailable;
  final double sh;
  final double sw;
  final int isMode;

  const DoctorsCardDetail({
    super.key,
    required this.Name,
    required this.photo,
    required this.Phone_number,
    required this.Specialization,
    required this.isAvailable,
    required this.sh, 
    required this.sw,
    required this.onDelete,
    required this.Email,
    required this.isMode,

  });

  @override
  _DoctorsCardDetailState createState() => _DoctorsCardDetailState();
}

class _DoctorsCardDetailState extends State<DoctorsCardDetail> {
  DioService dioService = DioService();

  @override
  Widget build(BuildContext context) {
    var Name = widget.Name;
    var photo = widget.photo;
    var Email = widget.Email;
    var Specialization = widget.Specialization;
    var Phone_number = widget.Phone_number;
    var isAvailable = widget.isAvailable;
    var isMode = widget.isMode;

    return SizedBox(
      height: 150,
      child: Card(
        color: AppTheme.getModeColor(
            AppTheme.lightBlue2, AppTheme.darkWhite, isMode),
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
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(0),
                    topStart: Radius.circular(120),
                    bottomEnd: Radius.circular(0),
                    topEnd: Radius.circular(0),
                  ),
                  color: AppTheme.getModeColor(
                      AppTheme.lightBlue.withOpacity(.6), AppTheme.lightDark, isMode),
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
              top: 1,
              right: 1,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text("Are you sure you want to delete this doctor?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
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
                      );
                    },
                  ),


                ],
              ),
            ),
            Positioned(
                bottom: 40,
                right: 30,
                child: Container(
                  child: isAvailable
                      ? Container(
                    alignment: AlignmentDirectional.center,
                    width:  150,
                    height: 40,
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
                    width:  150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getModeColor(AppTheme.lightRed, AppTheme.darkRed, isMode),
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
                                    image: photo.isNotEmpty
                                        ? FileImage(File(photo) as File) as ImageProvider<Object>
                                        : AssetImage('images/person.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          Gap(10),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(10),
                                Text(
                                  Name,
                                  style: TextStyle(
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                    fontSize: 24,
                                  ),
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.spellcheck_sharp,
                                      color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                    ),
                                    Gap(5),
                                    Text(
                                      Specialization,
                                      style: TextStyle(
                                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                    ),
                                    Gap(5),
                                    Text(
                                      Email,
                                      style: TextStyle(
                                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                    ),
                                    Gap(5),
                                    Text(
                                      Phone_number,
                                      style: TextStyle(
                                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                        fontSize: 16,
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
                  ],
                ),
      ),
    );
  }
}
