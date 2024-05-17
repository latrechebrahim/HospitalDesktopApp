import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/admin/admin_home.dart';
import 'package:hospital_managements/utils/menu.dart';
import '../Connection/connection.dart';
import '../connection/validation.dart';
import '../helper/Notif_error.dart';
import '../services/dio.dart';
import '../utils/custom_input.dart';
import '../utils/app_styles.dart';
import 'admin_about.dart';
import 'admin_appointments.dart';
import 'admin_doctors_list.dart';
import 'admin_language.dart';
import 'admin_patients_list.dart';
import 'admin_themes.dart';

class SettingsAdmin extends StatefulWidget {
  const SettingsAdmin({super.key, required this.Data, this.isMode});

  final Map<String, dynamic> Data;
  final int? isMode;

  @override
  State<SettingsAdmin> createState() => _SettingsDoctorState();
}

class _SettingsDoctorState extends State<SettingsAdmin> {
  Text? ErrorText;
  Text? ErrorTextconfirmpassword;
  Text? ErrorTextpassword;
  Text? ErrorTextvalidatephonenumber;
  Text? ErrorTextvalidationfirstname;
  Text? ErrorTextvalidationlastname;
  Text? ErrorTextvalidationWebsite;
  Color? borderColorvalidationfirstname;

  DioService dioService = DioService();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController oldepasswordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
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

  Icon? suffixIconWebsite;
  Icon? suffixIconpassword;

  bool? validationconfirmpassword = false;
  bool? validationemail = false;

  Validations validationemail1 = Validations();

  bool? validationpassword = false;

  Map<String, dynamic> _currentData = {};
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.Data['firstname'];
    lastnameController.text = widget.Data['lastname'];
    emailController.text = widget.Data['email'];
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

  Future<Map<String, dynamic>> fetchData() async {
    try {
      Map<String, dynamic> response = await dioService.showHospital_info('1');
      if (response['status'] == 200) {
        return response['users'];
      } else {
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    int isMode;
    if (widget.isMode == null) {
      isMode = 1;
    } else {
      isMode = widget.isMode!;
    }
    return Scaffold(
      backgroundColor: AppTheme.getModeColor(
          AppTheme.lightWhite, AppTheme.darkWhite, isMode),
      body: SizedBox.expand(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: 250,
              height: sh > 150 ? sh * 2 : 150,
              color: AppTheme.getModeColor(
                  AppTheme.lightWhite, AppTheme.darkWhite, isMode),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                            AdminHome(Data: widget.Data),
                        isMode: isMode,
                      ),
                      SizedBox(height: 20),
                      ElevatedButtonNotPressed(
                        text: "Appointments",
                        icon: AppIcons.calendar_today,
                        x: 200,
                        y: 40,
                        targetPage: (BuildContext context) =>
                            AppointmentsList(Data: widget.Data),
                        isMode: isMode,
                      ),
                      SizedBox(height: 20),
                      ElevatedButtonNotPressed(
                        text: "Doctors",
                        icon: Icons.person,
                        x: 200,
                        y: 40,
                        targetPage: (BuildContext context) =>
                            DoctorsList(Data: widget.Data),
                        isMode: isMode,
                      ),
                      SizedBox(height: 20),
                      ElevatedButtonNotPressed(
                        text: "Patients",
                        icon: AppIcons.personal_injury_outlined,
                        x: 200,
                        y: 40,
                        targetPage: (BuildContext context) =>
                            PatientsList(Data: widget.Data),
                        isMode: isMode,
                      ),
                      SizedBox(height: 20),
                      ElevatedButtonPressed(
                        text: "Settings",
                        icon: AppIcons.settings,
                        x: 150,
                        y: 40,
                        targetPage: (BuildContext context) => SettingsAdmin(
                          Data: widget.Data,
                        ),
                        isMode: isMode,
                      ),
                      SizedBox(height: 200),
                      ElevatedButtonNotPressed(
                        text: "Logout",
                        icon: AppIcons.logout,
                        x: 150,
                        y: 40,
                        targetPage: (BuildContext context) => ConnectionLogin(),
                        isMode: isMode,
                      ),
                      SizedBox(height: 20),
                      ElevatedButtonNotPressed(
                        text: "Help & Support",
                        icon: AppIcons.support_agent,
                        x: 200,
                        y: 40,
                        targetPage: (BuildContext context) =>
                            AdminHome(Data: widget.Data),
                        isMode: isMode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Container(
                    width: sw < 1450 ? sw * 0.8 : sw * 0.87,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue, AppTheme.darkBlue, isMode),
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
                                color: AppTheme.getModeColor(
                                    AppTheme.lightWhite,
                                    AppTheme.lightBlue,
                                    isMode),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                    color: AppTheme.getModeColor(
                                        AppTheme.lightWhite,
                                        AppTheme.lightBlue,
                                        isMode),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
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
                                      child: info(sw, sh, context, isMode),
                                    )
                                  : _currentStep == 2
                                      ? Container(
                                          key: ValueKey<int>(2),
                                          child:
                                              security(sw, sh, context, isMode),
                                        )
                                      : _currentStep == 3
                                          ? Container(
                                              key: ValueKey<int>(3),
                                              child: Language(
                                                sw: sw,
                                                sh: sh,
                                                isMode: isMode,
                                              ),
                                            )
                                          : _currentStep == 4
                                              ? Container(
                                                  key: ValueKey<int>(4),
                                                  child: Themes(
                                                    sw: sw,
                                                    sh: sh,
                                                  ),
                                                )
                                              : FutureBuilder<
                                                  Map<String, dynamic>>(
                                                  future: fetchData(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      Map<String, dynamic>
                                                          data =
                                                          snapshot.data ?? {};
                                                      return Container(
                                                        key: ValueKey<int>(5),
                                                        child: About(
                                                          sh: sh,
                                                          sw: sw,
                                                          Info: widget.Data,
                                                          Data: data,
                                                          isMode: isMode,
                                                        ),
                                                      );
                                                    }
                                                  },
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
                                          icon:
                                              Icons.insert_drive_file_outlined,
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
                                                  icon:
                                                      Icons.color_lens_outlined,
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
                                                      color:
                                                          AppTheme.getModeColor(
                                                              AppTheme
                                                                  .lightBlue,
                                                              AppTheme
                                                                  .darkWhite,
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Mun2ContainerNotPressed(
                                                      text:
                                                          'Personal Information',
                                                      sh: sh,
                                                      sw: sw,
                                                      icon: Icons
                                                          .insert_drive_file_outlined,
                                                      onPressed: _info,
                                                      isMode: isMode,
                                                    ),
                                                    Mun2ContainerNotPressed(
                                                      text:
                                                          'Password and security',
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
                                                      icon: Icons
                                                          .color_lens_outlined,
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
                                                      color:
                                                          AppTheme.getModeColor(
                                                              AppTheme
                                                                  .lightBlue,
                                                              AppTheme
                                                                  .darkWhite,
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Mun2ContainerNotPressed(
                                                      text:
                                                          'Personal Information',
                                                      sh: sh,
                                                      sw: sw,
                                                      icon: Icons
                                                          .insert_drive_file_outlined,
                                                      onPressed: _info,
                                                      isMode: isMode,
                                                    ),
                                                    Mun2ContainerNotPressed(
                                                      text:
                                                          'Password and security',
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
                                                      icon: Icons
                                                          .color_lens_outlined,
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

  Container info(double sw, double sh, BuildContext context, int isMode) {
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
                    image: AssetImage('images/person.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Gap(sh * 0.03),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.getModeColor(
                      AppTheme.lightWhite, AppTheme.darkWhite, isMode)
                  ?.withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.getModeColor(
                          AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                      .withOpacity(.4),
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
              color: AppTheme.getModeColor(
                      AppTheme.lightWhite, AppTheme.darkWhite, isMode)
                  ?.withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.getModeColor(
                          AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                      .withOpacity(.4),
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
                    color: AppTheme.getModeColor(
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
              color: AppTheme.getModeColor(
                      AppTheme.lightWhite, AppTheme.darkWhite, isMode)
                  ?.withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.getModeColor(
                          AppTheme.lightBlue, AppTheme.darkBlue, isMode)
                      .withOpacity(.4),
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
        ],
      ),
    );
  }

  Container security(double sw, double sh, BuildContext context, int isMode) {
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
              style: TextStyle(
                  color: AppTheme.getModeColor(
                      AppTheme.lightBlue1, AppTheme.lightWhite, isMode)),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                    confirmpasswordController.text.toString());
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
                  } else if (value['status'] == 400) {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  } else if (value['status'] == 401) {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  } else if (value['status'] == 402) {
                    showDelayedAnimatedDialog(
                      context,
                      'error',
                      value['message'],
                      Duration(microseconds: 1000),
                    );
                  } else if (value['status'] == 403) {
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
              foregroundColor: MaterialStateProperty.all(AppTheme.getModeColor(
                  AppTheme.lightWhite, AppTheme.darkWhite, isMode)),
              backgroundColor: MaterialStateProperty.all(AppTheme.getModeColor(
                  AppTheme.lightBlue1, AppTheme.lightBlue, isMode)),
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: _isLoading
                ? CircularProgressIndicator(
                    color: AppTheme.getModeColor(
                        AppTheme.darkWhite, AppTheme.lightWhite, isMode))
                : Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppTheme.getModeColor(
                            AppTheme.lightWhite, AppTheme.lightWhite, isMode)),
                  ),
          )
        ],
      ),
    );
  }
}
