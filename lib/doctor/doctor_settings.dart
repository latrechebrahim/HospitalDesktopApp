

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/doctor/doctor_home.dart';
import 'package:hospital_managements/utils/menu.dart';
import '../Connection/connection.dart';
import '../connection/validation.dart';
import '../helper/Notif_error.dart';
import '../services/dio.dart';
import '../utils/custom_input.dart';
import '../utils/app_styles.dart';
import 'doctor_about.dart';
import 'doctor_appointments.dart';

import 'doctor_themes.dart';

class SettingsDoctor extends StatefulWidget {
  const SettingsDoctor({super.key, required this.Data});

  final Map<String, dynamic> Data;

  @override
  State<SettingsDoctor> createState() => _SettingsDoctorState();
}

class _SettingsDoctorState extends State<SettingsDoctor> {
  Text? ErrorText;
  Text? ErrorTextconfirmpassword;
  Text? ErrorTextpassword;
  Text? ErrorTextvalidatephonenumber;
  Text? ErrorTextvalidationfirstname;
  Text? ErrorTextvalidationlastname;
  TextEditingController SpecialtyController = TextEditingController();
  Color? borderColorvalidationfirstname;

  TextEditingController date_birthController = TextEditingController();
  DioService dioService = DioService();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController oldepasswordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();
  String? selectedSpecialty;
  List<String> specialtyList = [
    'Cardiology',
    'Dermatology',
    'Endocrinology',
    'Gastroenterology',
    'Hematology',
    'Neurology',
    'Oncology',
    'Pediatrics',
  ];

  Icon? suffixIcon;
  Icon? suffixIconpassword;
  Icon? suffixIconvalidatephonenumber;
  Icon? suffixIconvalidationfirstname;
  Icon? suffixIconvalidationlastname;
  bool? validationconfirmpassword = false;
  bool? validationemail = false;
  Validations validationemail1 = Validations();
  bool? validationfirstname = false;
  bool? validationlastname = false;
  bool? validationpassword = false;
  bool? validationphonenumber = false;
  bool? validationspecialty = false;

  Map<String, dynamic> _currentData = {};
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.Data['firstname'] ?? '';
    lastnameController.text = widget.Data['lastname'] ?? '';
    SpecialtyController.text = widget.Data['specialty'] ?? '';
    emailController.text = widget.Data['email'] ?? '';
    phonenumberController.text = widget.Data['phonenumber'] ?? '';
    date_birthController.text = widget.Data['date_birth'] ?? '';
    imagePathController.text = widget.Data['path'] ?? 'images/person.jpg';
    _validatelastname(lastnameController.text);
    _validatefirstname(firstnameController.text);
    _validateEmail(emailController.text);
    _validatephonenumber(phonenumberController.text);
  }
  void _validatefirstname(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
          Validations().validatefirstname(text);
      ErrorTextvalidationfirstname = validationResults['errorText'];
      suffixIconvalidationfirstname = validationResults['icon'];
      validationfirstname = validationResults['validation'];
    });
  }

  void _validatelastname(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
          Validations().validatelastname(text);
      ErrorTextvalidationlastname = validationResults['errorText'];
      suffixIconvalidationlastname = validationResults['icon'];
      validationlastname = validationResults['validation'];
    });
  }

  void _validatephonenumber(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
          Validations().validatephonenumber(text);
      ErrorTextvalidatephonenumber = validationResults['errorText'];
      suffixIconvalidatephonenumber = validationResults['icon'];
      validationphonenumber = validationResults['validation'];
    });
  }

  void _validateEmail(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
          validationemail1.validateEmail(text);
      ErrorText = validationResults['errorText'];
      suffixIcon = validationResults['icon'];
      validationemail = validationResults['validation'];
    });
  }


  Future<void> _refreshData() async {
    if (!mounted) return;
    final id = widget.Data['id'];
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

  int _currentStep = 1;

  void _info() {
    setState(() {
      _currentStep = 1;
    });
  }
  void _security() {
    setState(() {
      _currentStep = 2;
    });
  }
  void _Language() {
    setState(() {
      _currentStep = 3;
    });
  }
  void _Themes() {
    setState(() {
      _currentStep = 4;
    });
  }
  void _About() {
    setState(() {
      _currentStep = 5;
    });
  }

  int isMode =1;


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    return Scaffold(
      backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
      body: SizedBox.expand(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: 250,
              height: sh > 150 ? sh * 2 : 150,
              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 1000),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: -100.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Container(
                      height: sw > 85 ? sw * 0.1 : 85,
                      width: sw > 85 ? sw * 0.1 : 85,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/02-.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        ElevatedButtonNotPressed(
                          text: "Home",
                          icon: Icons.home,
                          x: 150,
                          y: 40,
                          targetPage: (BuildContext context) =>
                              HomeDoctor(Data: widget.Data),
                          isMode: isMode,
                        ),
                        SizedBox(height: 20),
                        ElevatedButtonNotPressed(
                          text: "Appointments",
                          icon: AppIcons.calendar_today,
                          x: 200,
                          y: 40,
                          targetPage: (BuildContext context) =>
                              AppointmentsDoctor(Data: widget.Data),
                          isMode: isMode,
                        ),
                        SizedBox(height: 20),
                        ElevatedButtonPressed(
                          text: "Settings",
                          icon: AppIcons.settings,
                          x: 150,
                          y: 40,
                          targetPage: (BuildContext context) =>
                              SettingsDoctor(Data: widget.Data),
                          isMode: isMode,
                        ),
                        SizedBox(height: 200),
                        ElevatedButtonNotPressed(
                          text: "Logout",
                          icon: AppIcons.logout,
                          x: 150,
                          y: 40,
                          targetPage: (BuildContext context) =>
                              ConnectionLogin(),
                          isMode: isMode,
                        ),
                        SizedBox(height: 20),
                        ElevatedButtonNotPressed(
                          text: "Help & Support",
                          icon: AppIcons.support_agent,
                          x: 200,
                          y: 40,
                          targetPage: (BuildContext context) =>
                              AppointmentsDoctor(Data: widget.Data),
                          isMode: isMode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Container(
                    width: sw < 1450 ? sw * 0.8 : sw * 0.87,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 1000),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: -100.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextButton(
                                onPressed: () {
                                  _refreshData();
                                },
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      color: AppTheme.getModeColor(
                          AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                      width: sw,
                      height: sh,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 1000),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 100.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                        children: [
                          AnimatedSwitcher(
                            reverseDuration: Durations.medium3,
                            switchInCurve: Curves.easeInOutCubic,
                            duration: Duration(milliseconds: 800),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: _currentStep == 1
                                ? Container(
                                    key: ValueKey<int>(1),
                                    child: info(sw, sh, context),
                                  )
                                : _currentStep == 2
                                    ? Container(
                                        key: ValueKey<int>(2),
                                        child: security(sw, sh, context),
                                      )
                                    : _currentStep == 3
                                        ? Container(
                                            key: ValueKey<int>(3),
                                            child: Language(sw, sh, context),
                                          )
                                        : _currentStep == 4
                                            ? Container(
                                                key: ValueKey<int>(4),
                                                child: Themes(sw: sw, sh: sh,isMode: isMode),
                                              )
                                            : Container(
                                                key: ValueKey<int>(5),
                                                child: About(sw: sw, sh: sh,isMode: isMode),
                                              ),
                          ),
                          _currentStep == 1
                              ? Container(
                            width: sw < 1450 ? 200 : 400,
                            height: sh * 0.8,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getModeColor(
                                  AppTheme.lightBlue,
                                  AppTheme.darkBlue,
                                  isMode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getModeColor(
                                      AppTheme.lightBlue,
                                      AppTheme.darkWhite,
                                      isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Mun2ContainerPressed(
                                  text: 'Personal Information',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.insert_drive_file_outlined,
                                  onPressed: _info,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Password and security',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.security,
                                  onPressed: _security,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Language',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.mode,
                                  onPressed: _Language,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Themes',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.color_lens_outlined,
                                  onPressed: _Themes,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'About this App',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.info_rounded,
                                  onPressed: _About,
                                  isMode: isMode,
                                ),
                              ],
                            ),
                          )
                              : _currentStep == 2
                              ? Container(
                            width: sw < 1450 ? 200 : 400,
                            height: sh * 0.8,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getModeColor(
                                  AppTheme.lightBlue,
                                  AppTheme.darkBlue,
                                  isMode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getModeColor(
                                      AppTheme.lightBlue,
                                      AppTheme.darkWhite,
                                      isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Mun2ContainerNotPressed(
                                  text: 'Personal Information',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.insert_drive_file_outlined,
                                  onPressed: _info,
                                  isMode: isMode,
                                ),
                                Mun2ContainerPressed(
                                  text: 'Password and security',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.security,
                                  onPressed: _security,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Language',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.mode,
                                  onPressed: _Language,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Themes',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.color_lens_outlined,
                                  onPressed: _Themes,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'About this App',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.info_rounded,
                                  onPressed: _About,
                                  isMode: isMode,
                                ),
                              ],
                            ),
                          )
                              : _currentStep == 3
                              ? Container(
                            width: sw < 1450 ? 200 : 400,
                            height: sh * 0.8,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getModeColor(
                                  AppTheme.lightBlue,
                                  AppTheme.darkBlue,
                                  isMode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getModeColor(
                            AppTheme.lightBlue,
                                AppTheme.darkWhite,
                                isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              borderRadius:
                              BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Mun2ContainerNotPressed(
                                  text: 'Personal Information',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons
                                      .insert_drive_file_outlined,
                                  onPressed: _info,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Password and security',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.security,
                                  onPressed: _security,
                                  isMode: isMode,
                                ),
                                Mun2ContainerPressed(
                                  text: 'Language',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.mode,
                                  onPressed: _Language,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Themes',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.color_lens_outlined,
                                  onPressed: _Themes,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'About this App',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.info_rounded,
                                  onPressed: _About,
                                  isMode: isMode,
                                ),
                              ],
                            ),
                          )
                              : _currentStep == 4
                              ? Container(
                            width: sw < 1450 ? 200 : 400,
                            height: sh * 0.8,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getModeColor(
                                  AppTheme.lightBlue,
                                  AppTheme.darkBlue,
                                  isMode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getModeColor(
                                AppTheme.lightBlue,
                                AppTheme.darkWhite,
                                isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              borderRadius:
                              BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Mun2ContainerNotPressed(
                                  text: 'Personal Information',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons
                                      .insert_drive_file_outlined,
                                  onPressed: _info,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Password and security',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.security,
                                  onPressed: _security,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Language',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.mode,
                                  onPressed: _Language,
                                  isMode: isMode,
                                ),

                                Mun2ContainerPressed(
                                  text: 'Themes',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.color_lens_outlined,
                                  onPressed: _Themes,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'About this App',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.info_rounded,
                                  onPressed: _About,
                                  isMode: isMode,
                                ),
                              ],
                            ),
                          )
                              : Container(
                            width: sw < 1450 ? 200 : 400,
                            height: sh * 0.8,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getModeColor(
                                  AppTheme.lightBlue,
                                  AppTheme.darkBlue,
                                  isMode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getModeColor(
                                      AppTheme.lightBlue,
                                      AppTheme.darkWhite,
                                      isMode),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              borderRadius:
                              BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Mun2ContainerNotPressed(
                                  text: 'Personal Information',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons
                                      .insert_drive_file_outlined,
                                  onPressed: _info,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Password and security',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.security,
                                  onPressed: _security,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Language',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.mode,
                                  onPressed: _Language,
                                  isMode: isMode,
                                ),
                                Mun2ContainerNotPressed(
                                  text: 'Themes',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.color_lens_outlined,
                                  onPressed: _Themes,
                                  isMode: isMode,
                                ),
                                Mun2ContainerPressed(
                                  text: 'About this App',
                                  sh: sh,
                                  sw: sw,
                                  icon: Icons.info_rounded,
                                  onPressed: _About,
                                  isMode: isMode,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Container info(double sw, double sh, BuildContext context) {
    return Container(
      width: 500,
      height: sh * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getModeColor(
          AppTheme.lightBlue.withOpacity(0.4),
          AppTheme.darkBlue,
          isMode,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getModeColor(AppTheme.lightWhite,
                AppTheme.darkWhite.withOpacity(.4), isMode),
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
                        title: Text('Edit User Information',
                          style: TextStyle(
                          color: AppTheme.getModeColor(
                              AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                        ),),
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
                                width: 400,
                                height: 100,
                                child: TextField(
                                  controller: firstnameController,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      Map<String, dynamic> validationResults =
                                          Validations().validatefirstname(text);
                                      ErrorTextvalidationfirstname =
                                          validationResults['errorText'];
                                      suffixIconvalidationfirstname =
                                          validationResults['icon'];
                                      validationfirstname =
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
                                          ErrorTextvalidationfirstname?.data,
                                      suffix: suffixIconvalidationfirstname,
                                      icon: Icon(
                                        Icons.person,
                                        color: AppTheme.getModeColor(
                                            AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                      )),
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 100,
                                child: TextField(
                                  controller: lastnameController,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      Map<String, dynamic> validationResults =
                                          Validations().validatelastname(text);
                                      ErrorTextvalidationlastname =
                                          validationResults['errorText'];
                                      suffixIconvalidationlastname =
                                          validationResults['icon'];
                                      validationlastname =
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
                                    labelText: "Family_Name",
                                    labelStyle: TextStyle(
                                        color: AppTheme.getModeColor(
                                            AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                    ),
                                    errorText:
                                        ErrorTextvalidationlastname?.data,
                                    suffix: suffixIconvalidationlastname,
                                    icon: Icon(
                                      Icons.person,
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 100,
                                child: TextField(
                                  readOnly: false,
                                  controller: date_birthController,
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                  ),
                                  onTap: () async {
                                    DateTime initialDate = DateTime.now();
                                    if (widget.Data['date_birth'] != null &&
                                        widget.Data['date_birth'].isNotEmpty) {
                                      try {
                                        initialDate = DateTime.parse(
                                            widget.Data['date_birth']);
                                      } catch (e) {
                                        print('Error parsing date: $e');
                                      }
                                    }
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        date_birthController.text = formatDate(
                                                selectedDate,
                                                [yyyy, '/', mm, '/', dd])
                                            .toString();
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    labelText: "Date of Birth",
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
                                width: 400,
                                height: 100,
                                child: DropdownButtonFormField(

                                  focusColor: AppTheme.getModeColor(
                                      AppTheme.lightBlue1, AppTheme.lightDark, isMode),
                                  dropdownColor: AppTheme.getModeColor(
                                      AppTheme.lightBlue1, AppTheme.lightDark, isMode),
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                  ),
                                  value: selectedSpecialty,
                                  items: specialtyList.map((String value) {
                                    if (specialtyList.isNotEmpty) {
                                      selectedSpecialty = specialtyList.first;
                                    }
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedSpecialty = newValue!;
                                      SpecialtyController.text = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    labelText: "Specialty",
                                    labelStyle: TextStyle(
                                        color: AppTheme.getModeColor(
                                            AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                    ),
                                    icon: Icon(
                                      Icons.work,
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 100,
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                  ),
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
                                width: 400,
                                height: 80,
                                child: TextField(
                                  controller: phonenumberController,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                  ),
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
                            child: Text('Cancel',
                              style: TextStyle(
                                color: AppTheme.getModeColor(
                                    AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                            ),),
                          ),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (validationemail == true &&
                                  validationfirstname == true &&
                                  validationlastname == true &&
                                  validationphonenumber == true) {
                                setState(() {
                                  _isLoading = false;
                                });
                                print(imagePathController.text);
                                dioService.updateinfo(
                                  context,
                                  widget.Data['id'].toString(),
                                  firstnameController.text.toString(),
                                  lastnameController.text.toString(),
                                  selectedSpecialty.toString(),
                                  imagePathController.text.toString(),
                                  emailController.text.toString(),
                                  phonenumberController.text.toString(),
                                  date_birthController.text.toString(),
                                );
                                await _refreshData();
                                print(_currentData.toString());
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingsDoctor(
                                      Data: _currentData ?? {},
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
                                    color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                                  )
                                : Text('Save',
                              style: TextStyle(
                                color: AppTheme.getModeColor(
                                    AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                            ),),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Edit',
                  style: TextStyle(
                    color: AppTheme.getModeColor(
                        AppTheme.lightWhite.withOpacity(.4), AppTheme.lightWhite, isMode)
                ),),
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
                  widget.Data['firstname'] ?? 'No data',
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
                  'Family_ Name:',
                  style: TextStyle(
                    color:  AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(15),
                Text(
                  widget.Data['lastname'] ?? 'No data',
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
                  'Date of birth:',
                  style: TextStyle(
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(15),
                Text(
                  widget.Data['date_birth'] ?? 'No data',
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
                  'Specialty:',
                  style: TextStyle(
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(15),
                Text(
                  widget.Data['specialty'] ?? 'No data',
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
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(15),
                Text(
                  widget.Data['email'] ?? 'No data',
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
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(15),
                Text(
                  widget.Data['phonenumber'] ?? 'No data',
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

  Container security(double sw, double sh, BuildContext context) {
    return Container(
      width: 500,
      height: sh * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getModeColor(
          AppTheme.lightBlue.withOpacity(0.4),
          AppTheme.darkBlue,
          isMode,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getModeColor(AppTheme.lightWhite,
                AppTheme.darkWhite.withOpacity(.4), isMode),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Reset password",
            style: GoogleFonts.lobster(
              fontSize: 30,
              color: AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 330,
            height: 100,
            child: TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              style: TextStyle(
                  color: AppTheme.getModeColor(
                      AppTheme.lightBlue1, AppTheme.lightWhite, isMode)),
              onChanged: (text) {
                setState(() {
                  Map<String, dynamic> validationResults =
                  Validations().validatepassword(text);
                  ErrorTextpassword = validationResults['errorText'];
                  suffixIconpassword = validationResults['icon'];
                  validationpassword = validationResults['validation'];
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
                labelText: 'New Password',
                labelStyle: TextStyle(
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.lightWhite, isMode)),
                icon: Icon(
                  Icons.security,
                  color: AppTheme.getModeColor(
                      AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                ),
                errorText: ErrorTextpassword?.data,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    size: 17,
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                  ),
                ),
              ),
            ),
          ),
          CustomInputPassword(
            labelText: 'Confirm Password',
            controller: confirmpasswordController,
            icon: Icon(
              Icons.security,
              color: AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
            ),
            isMode: isMode,
          ),
          CustomInputPassword(
            labelText: 'Your Password',
            controller: oldepasswordController,
            icon: Icon(
              Icons.security,
              color: AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
            ),
            isMode: isMode,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              if (validationpassword == true &&
                  validationconfirmpassword == true) {
                Future<Map<String, dynamic>> response = dioService.ResetPass(
                    widget.Data['id'].toString(),
                    oldepasswordController.text.toString(),
                    passwordController.text.toString(),
                    confirmpasswordController.text.toString()
                );
                response.then((value) async {
                  setState(() {
                    _isLoading = false;
                  });
                  if (value['status'] == 200) {
                    showDelayedAnimatedDialog(
                      context,
                      'successfully',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                    await _refreshData();
                  } else if (value['status'] == 400)  {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  }else if (value['status'] == 401)  {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  } else if (value['status'] == 402)  {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  } else if (value['status'] == 403)  {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  }
                }).catchError((error) {
                  setState(() {
                    _isLoading = false;
                  });
                  showDelayedAnimatedDialog(
                    context,
                    'error',
                    "An error occurred during Reset: $error",
                    Duration(microseconds: 1000),
                  );
                });
              } else {
                setState(() {
                  _isLoading = false;
                });
                showDelayedAnimatedDialog(
                  context,
                  'error',
                  "Error: Please verify your input Before Save...",
                  Duration(microseconds: 1000),
                );
              }
            },

            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(150, 40)),
              foregroundColor: MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode)),
              backgroundColor: MaterialStateProperty.all(AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightBlue, isMode)),
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: _isLoading
                ? CircularProgressIndicator(
              color: AppTheme.getModeColor(
                  AppTheme.darkWhite, AppTheme.lightWhite, isMode),
            )
                : Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                  color: AppTheme.getModeColor(
                      AppTheme.lightWhite, AppTheme.lightWhite, isMode)
              ),
            ),
          )
        ],
      ),
    );
  }

  Container Language(double sw, double sh, BuildContext context) {
    return Container(
      width:  500,
      height: sh * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getModeColor(
          AppTheme.lightBlue.withOpacity(0.4),
          AppTheme.darkBlue,
          isMode,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getModeColor(
              AppTheme.lightWhite,
              AppTheme.darkWhite.withOpacity(.4),
              isMode,
            ),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }


}
