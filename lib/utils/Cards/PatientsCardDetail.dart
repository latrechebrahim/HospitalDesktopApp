import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'dart:io';

class PatientsCardDetail extends StatefulWidget {
  final String Name;
  final String photo;
  final String Phone_number;
  final String id;
  final String email;
  final VoidCallback onDelete;
  final double sh;
  final double sw;
  final int isMode;
  const PatientsCardDetail({
    super.key,
    required this.Name,
    required this.photo,
    required this.Phone_number,
    required this.id,
    required this.sh, 
    required this.sw,
    required this.onDelete,
    required this.isMode,
    required this.email,
  });

  @override
  _PatientsCardDetailState createState() => _PatientsCardDetailState();
}

class _PatientsCardDetailState extends State<PatientsCardDetail> {


  @override
  Widget build(BuildContext context) {
    var Name = widget.Name;
    var photo = widget.photo;
    var id = widget.id;
    var Phone_number = widget.Phone_number;
    var isMode = widget.isMode;
    var email = widget.email;
    return SizedBox(
      height: 150,
      child: Card(
        color: AppTheme.getModeColor(
            AppTheme.lightBlue2, AppTheme.darkWhite, isMode),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
         topLeft:  Radius.circular(30),
          topRight: Radius.circular(0),
        )),
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
                    topStart: Radius.circular(150),
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
              right: 100,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/Ban.png'),

                  ),
                ),
              ),
              ),
            Positioned(
              top: 50,
              right: 10,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text("Are you sure you want to delete this patients?"),
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(0),
                                      topStart: Radius.circular(20),
                                    topEnd: Radius.circular(0),
                                    bottomEnd: Radius.circular(100),
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
                                      id,
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
                                      email,
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
