import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../connection/validation.dart';
import '../helper/Notif_error.dart';
import '../services/dio.dart';
import '../utils/app_styles.dart';
import 'admin_settings.dart';

class About extends StatefulWidget {
  const About({
    Key? key,

    required this.sw,
    required this.sh,
    required this.Data,
    required this.Info,
    required this.isMode,
  }) : super(key: key);

  final double sw;
  final double sh ;
  final Map<String, dynamic> Info;
  final Map<String, dynamic> Data;
  final int isMode;

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  TextEditingController NameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController IdController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();

  Text? ErrorText;
  Text? ErrorTextvalidatephonenumber;
  Text? ErrorTextvalidationName;
  Text? ErrorTextvalidation;
  Text? ErrorTextvalidationWebsite;
  Color? borderColorvalidationfirstname;

  DioService dioService = DioService();

  Icon? suffixIcon;
  Icon? suffixIconWebsite;
  Icon? suffixIconvalidatephonenumber;
  Icon? suffixIconvalidationName;
  Icon? suffixIconvalidation;



  Validations validation = Validations();

  bool? validationemail = false;
  bool? validationName = false;
  bool? validationphonenumber = false;
  bool? validateWebsite = false;
  bool _isLoading = false;

  void _validatephonenumber(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      validation.validatephonenumber(text);
      ErrorTextvalidatephonenumber = validationResults['errorText'];
      suffixIconvalidatephonenumber = validationResults['icon'];
      validationphonenumber = validationResults['validation'];
    });
  }
  void _validateEmail(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      validation.validateEmail(text);
      ErrorText = validationResults['errorText'];
      suffixIcon = validationResults['icon'];
      validationemail = validationResults['validation'];
    });
  }
  void _validateWebsite(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      validation.validateWebsite(text);
      ErrorTextvalidationWebsite = validationResults['errorText'];
      suffixIconWebsite = validationResults['icon'];
      validateWebsite = validationResults['validation'];
    });
  }
  void _validateName(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      validation.validateName(text);
      ErrorTextvalidationName = validationResults['errorText'];
      suffixIconvalidationName = validationResults['icon'];
      validationName = validationResults['validation'];
    });
  }

  Map<String, dynamic> _currentData = {};

  Future<void> _refreshData() async {
    if (!mounted) return;
    final id = widget.Data['id'];
    if (id != null) {
      final idString = id.toString();
      try {
        final data = await dioService.Hospital_info(idString);
        if (!mounted) return;
        setState(() {
          Map<String, dynamic> userData = data['user'];
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
    NameController.text = widget.Data['Name'];
    websiteController.text = widget.Data['website'];
    EmailController.text = widget.Data['email'];
    PhoneController.text = widget.Data['phonenumber'];
    imagePathController.text = widget.Data['path'] ?? 'images/person.jpg';
    _validateName(NameController.text);
    print(validationName);
    _validateEmail(EmailController.text);
    _validateWebsite(websiteController.text);
    _validatephonenumber(PhoneController.text);
  }


  @override
  Widget build(BuildContext context) {
    double sh = widget.sh;
    double sw = widget.sw;
    final Map<String, dynamic> data = widget.Data;
    int isMode = widget.isMode;

    return Container(
            width: 500,
            height: widget.sh * 0.8,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color:  AppTheme.getModeColor(
                  AppTheme.lightBlue.withOpacity(0.4),
                  AppTheme.darkBlue, isMode),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(200),
                          topStart: Radius.circular(0),
                          bottomEnd: Radius.circular(200),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue.withOpacity(.4), isMode),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                        image: DecorationImage(
                          image: imagePathController.text.isNotEmpty
                              ? FileImage(File(imagePathController.text as String) as File) as ImageProvider<Object>
                              : AssetImage('images/person.jpg'),
                               fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(100, 40)),
                        foregroundColor: MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue, isMode).withOpacity(0.4)),
                        backgroundColor:
                        MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue, isMode).withOpacity(0.4)),
                        mouseCursor: MaterialStateMouseCursor.clickable,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                              title: Text(
                                  'Edit User Information',
                               style: TextStyle(
                                 color: AppTheme.getModeColor(
                                     AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                               ),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final filePath = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['jpg', 'jpeg', 'png'],
                                        );
                                        if (filePath != null && filePath.files.isNotEmpty) {
                                          setState(() {
                                            imagePathController.text = filePath.files.first.path!;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200), // Circular border radius
                                          image: DecorationImage(
                                            image: imagePathController.text.isNotEmpty
                                                ? FileImage(File(imagePathController.text as String) as File) as ImageProvider<Object>
                                                : AssetImage('images/person.jpg'),

                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(20),
                                    Container(
                                      width: 330,
                                      height: 100,
                                      child: TextField(
                                        controller: NameController,
                                        style: TextStyle(
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                        ),
                                        keyboardType: TextInputType.name,
                                        onChanged: (text) {
                                          setState(() {
                                            Map<String, dynamic> validationResults =
                                            Validations().validateName(text);
                                            ErrorTextvalidationName =
                                            validationResults['errorText'];
                                            suffixIconvalidationName =
                                            validationResults['icon'];
                                            validationName =
                                            validationResults['validation'];
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide:
                                              BorderSide(color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
                                            ),
                                            labelText: "Name",
                                            labelStyle: TextStyle(
                                                color: AppTheme.getModeColor(
                                                    AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                            ),
                                            errorText:
                                            ErrorTextvalidationName?.data,
                                            suffix: suffixIconvalidationName,
                                            icon: Icon(
                                              Icons.person,
                                              color: AppTheme.getModeColor(
                                                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                            )),
                                      ),
                                    ),
                                    Container(
                                      width: 330,
                                      height: 100,
                                      child: TextField(
                                        controller: websiteController,
                                        style: TextStyle(
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                        ),
                                        keyboardType: TextInputType.url,
                                        onChanged: (text) {
                                          setState(() {
                                            Map<String, dynamic> validationResults =
                                            Validations().validateWebsite(text);
                                            ErrorTextvalidationWebsite =
                                            validationResults['errorText'];
                                            suffixIconWebsite =
                                            validationResults['icon'];
                                            validateWebsite =
                                            validationResults['validation'];
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide:
                                              BorderSide(
                                                  color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
                                            ),
                                            labelText: "website",
                                            labelStyle: TextStyle(
                                                color: AppTheme.getModeColor(
                                                    AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                            ),
                                            errorText:
                                            ErrorTextvalidationWebsite?.data,
                                            suffix: suffixIconWebsite,
                                            icon: Icon(
                                              Icons.web,
                                              color: AppTheme.getModeColor(
                                                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                            )),
                                      ),
                                    ),
                                    Container(
                                      width: 330,
                                      height: 100,
                                      child: TextField(
                                        controller: EmailController,
                                        style: TextStyle(
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (text) {
                                          setState(() {
                                            Map<String, dynamic> validationResults =
                                            Validations().validateEmail(text);
                                            ErrorText =
                                            validationResults['errorText'];
                                            suffixIcon = validationResults['icon'];
                                            validationemail =
                                            validationResults['validation'];
                                          });
                                        },
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.email,
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          labelText: "Email Address",
                                          labelStyle: TextStyle(
                                              color: AppTheme.getModeColor(
                                                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                          ),
                                          errorText: ErrorText?.data,
                                          suffix: suffixIcon,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 330,
                                      height: 80,
                                      child: TextField(
                                        controller: PhoneController,
                                        style: TextStyle(
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                        ),
                                        keyboardType: TextInputType.phone,
                                        onChanged: (text) {
                                          setState(() {
                                            Map<String, dynamic> validationResults =
                                            Validations()
                                                .validatephonenumber(text);
                                            ErrorTextvalidatephonenumber =
                                            validationResults['errorText'];
                                            suffixIconvalidatephonenumber =
                                            validationResults['icon'];
                                            validationphonenumber =
                                            validationResults['validation'];
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          labelText: 'Phone Number',
                                          labelStyle: TextStyle(
                                              color: AppTheme.getModeColor(
                                                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                          ),
                                          errorText:
                                          ErrorTextvalidatephonenumber?.data,
                                          suffix: suffixIconvalidatephonenumber,
                                          icon: Icon(
                                            Icons.phone,
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Add more input fields for other user information
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text(
                                      'Cancel',
                                    style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    print(NameController.text.toString());
                                    print(validationName);
                                    print(validateWebsite);
                                    print(validationphonenumber);
                                    if (validationemail == true &&
                                        validationName == true &&
                                        validateWebsite == true &&
                                        validationphonenumber == true) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      dioService.updateHospital_info(
                                        context,
                                        '1',
                                        NameController.text.toString(),
                                        websiteController.text.toString(),
                                        EmailController.text.toString(),
                                        PhoneController.text.toString(),
                                          imagePathController.text.toString()
                                      );
                                      await _refreshData();
                                      About(sw: sw,sh: sh,Data: widget.Info , Info: _currentData,isMode: isMode);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SettingsAdmin(
                                            Data: widget.Info ?? {},
                                          ), // Replace YourPageNameHere with the name of your page
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      showDelayedAnimatedDialog(
                                          context,
                                          "Validation Error",
                                          "Please verify your input Before update...",
                                          Duration(microseconds: 300));
                                    }
                                  },
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                    color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                                  )
                                      : Text(
                                      'Save',
                                       style: TextStyle(
                                        color: AppTheme.getModeColor(
                                            AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                          'Edit',
                        style: TextStyle(
                            color: AppTheme.getModeColor(
                                AppTheme.lightWhite, AppTheme.lightWhite, isMode)
                        ),

                      ),
                    )
                  ],
                ),
                Gap(sh * 0.03),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode)?.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode).withOpacity(.4),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(50),
                      Text(
                        'Name:',
                        style: TextStyle(
                          color: AppTheme.getModeColor(
                              AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(15),

                      Text(
                        data['Name'] ?? 'No data',
                        style: GoogleFonts.labrada(
                          fontSize: 20,
                          color: AppTheme.getModeColor(
                              AppTheme.darkWhite, AppTheme.lightWhite, isMode),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(sh * 0.01),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode)?.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode).withOpacity(.4),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(50),
                      Text(
                        'Website:',
                        style: TextStyle(
                          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(15),
                      Text(
                        data['website'] ?? 'No data',
                        style: GoogleFonts.labrada(
                          fontSize: 20,
                          color: AppTheme.getModeColor(
                              AppTheme.darkWhite, AppTheme.lightWhite, isMode),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(sh * 0.01),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode)?.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode).withOpacity(.4),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(50),
                      Text(
                        'Email:',
                        style: TextStyle(
                          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(15),
                      Text(
                        data['email'] ?? 'No data',
                        style: GoogleFonts.labrada(
                          fontSize: 20,
                          color: AppTheme.getModeColor(
                              AppTheme.darkWhite, AppTheme.lightWhite, isMode),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(sh * 0.01),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode)?.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode).withOpacity(.4),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(50),
                      Text(
                        'Phone Number:',
                        style: TextStyle(
                          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(15),
                      Text(
                        data['phonenumber'] ?? 'No data',
                        style: GoogleFonts.labrada(
                          fontSize: 20,
                          color: AppTheme.getModeColor(
                              AppTheme.darkWhite, AppTheme.lightWhite, isMode),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
}