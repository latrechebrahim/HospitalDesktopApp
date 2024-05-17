import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/doctor/doctor_appointments.dart';
import 'package:hospital_managements/doctor/doctor_settings.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/appointments_classes.dart';
import 'package:hospital_managements/utils/calendar.dart';
import 'package:hospital_managements/utils/menu.dart';
import '../Connection/connection.dart';
import '../services/dio.dart';
import '../utils/Cards/slidingCard.dart';
import '../utils/custom_input.dart';

class HomeDoctor extends StatefulWidget {
  final Map<String, dynamic> Data;
  const HomeDoctor({
    super.key,
    required this.Data,
  });

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  DioService dioService = DioService();
  late int countAppointments = 0;
  late int countAppointmentsNotConfirmed = 0;
  bool isLoading = true;
  TextEditingController imagePathController = TextEditingController();



  @override
  void initState() {
    super.initState();
    imagePathController.text = widget.Data['path'] ?? 'images/person.jpg';
    getCounts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCounts() async {
    try {
      Map<String, dynamic> data = await dioService.countAppointmentsDoctor(widget.Data['id'].toString());
      setState(() {
        countAppointments = data['countAppointments'] ?? 0;
        countAppointmentsNotConfirmed = data['countAppointmentsNotconfirmed'] ?? 0;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching counts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<Map<String, dynamic>> fetchData() async {
    try {
      Map<String, dynamic> response = await dioService.showHospital_info('1');
      if (response['status'] == 200) {
        return response['users'];
      } else {
        // Handle the case where status is not 200
        return {};
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return {};
    }
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;

    int isMode = 1;

    return Scaffold(
      backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
      body: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: 230,
              height: sh > 150 ? sh * 2 : 150,
              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
              child: AnimationLimiter(
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
                          ElevatedButtonPressed(
                            text: "Home",
                            icon: Icons.home,
                            x: 150,
                            y: 40,
                            targetPage: (BuildContext context) => HomeDoctor(Data: widget.Data),
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
                          ElevatedButtonNotPressed(
                            text: "Settings",
                            icon: AppIcons.settings,
                            x: 150,
                            y: 40,
                            targetPage: (BuildContext context) => SettingsDoctor(Data: widget.Data),
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
                            targetPage: (BuildContext context) => HomeDoctor(Data: widget.Data),
                            isMode: isMode,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: sw > 85 ? sw * 0.9 : 85,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                    child: AnimationLimiter(
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Icons.home,
                                  color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imagePathController.text.isNotEmpty
                                            ? FileImage(File(imagePathController.text as String) as File) as ImageProvider<Object>
                                            : AssetImage('images/person.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                        color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.darkDark, isMode),
                                        width: 1,
                                      )),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                  },
                                  child: Text(widget.Data['lastname'] ?? 'No Data',style: TextStyle(color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.lightWhite, isMode)),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                    child: Row(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 1000),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 300.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                      children: [
                        Container(
                          color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                          width: sw > 150 ? sw * 0.5 : 150,
                          child: AnimationLimiter(
                            child: Column(
                              children: [
                                Container(
                                  color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                  height: sh > 150 ? sh * 0.25 : 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: AnimationConfiguration.toStaggeredList(
                                      duration: const Duration(milliseconds: 2000),
                                      childAnimationBuilder: (widget) => SlideAnimation(
                                        horizontalOffset: 200.0,
                                        child: FadeInAnimation(
                                          child: widget,
                                        ),
                                      ),
                                    children: [
                                      Appointments_Statistics(
                                        tital: 'Total Appointments',
                                        total: countAppointments,
                                        icons: 'images/Med_Bottle.png',
                                        sh: sh,
                                        sw: sw,
                                        isMode: isMode,
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Appointments_Statistics(
                                        tital: 'Appointments In Progress',
                                        total: countAppointmentsNotConfirmed,
                                        icons: 'images/Med_Bottle2.png',
                                        sh: sh,
                                        sw: sw,
                                        isMode: isMode,
                                      ),
                                    ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sh > 1450 ? sh * 0.65 : sh * 0.65,
                                  width: sw < 1140 ? sw * 0.6 : 600,
                                  decoration: BoxDecoration(
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkBlue, isMode),
                                    borderRadius:
                                        BorderRadius.circular(sw * 0.02),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkWhite, isMode)
                                            .withOpacity(0.4),
                                        blurRadius: 30,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Appointments List",
                                              style: GoogleFonts.labrada(
                                                fontSize: 22,
                                                color: AppTheme.getModeColor(
                                                    AppTheme.darkWhite, AppTheme.lightWhite, isMode),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AppointmentsDoctor(Data: widget.Data)));
                                              },
                                              child: Text(
                                                'Show All',
                                                style: GoogleFonts.labrada(
                                                  fontSize: 22,
                                                  color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: sh > 1450 ? sh * 0.6: sh * 0.6,
                                        child: FutureBuilder<Map<String, dynamic>>(
                                      future: dioService.showAppointmentsDoctor(
                                        widget.Data['id'].toString()
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        } else if (snapshot.data == null || snapshot.data!['appointmentsData'] == null) {
                                          return Center(child: Text('No data available'));
                                        } else {
                                          List<dynamic> appointmentsData = snapshot.data!['appointmentsData'];
                                          return ListView(
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsetsDirectional.all(10),
                                            clipBehavior: Clip.antiAlias,
                                            children: AnimationConfiguration.toStaggeredList(
                                              duration: const Duration(milliseconds: 1000),
                                              childAnimationBuilder: (widget) => SlideAnimation(
                                                verticalOffset: 100.0,
                                                child: FadeInAnimation(
                                                  child: widget,
                                                ),
                                              ),
                                              children: appointmentsData.map((userData) {
                                                Map<String, dynamic> appointment = userData['appointment'];
                                                Map<String, dynamic> userOriginalData = userData['userData']['original']['userData'];
                                                return SlidingCard(
                                                  sh: sh,
                                                  sw: sw,
                                                  Name: userOriginalData['Patient']?['firstname'] ?? 'No data',
                                                  image: userOriginalData['Patient']?['photo'] ?? 'images/person.jpg',
                                                  date: appointment['date'] ?? 'No data',
                                                  isConformed: appointment['confirmed'] == 1,
                                                  isMode: isMode,
                                                );
                                              }).toList(), // Convert the map to a list
                                            ),
                                          );
                                        }
                                      },
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      FutureBuilder<Map<String, dynamic>>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            Map<String, dynamic> data = snapshot.data ?? {};
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: sh > 1000 ? 400 : 300,
                                      width: sw > 1450 ? sw * 0.28 : 300,
                                      decoration: BoxDecoration(
                                        color: AppTheme.getModeColor(AppTheme.lightWhite.withOpacity(0.8), AppTheme.darkBlue, isMode),
                                        borderRadius: BorderRadius.circular(sw * 0.02),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.getModeColor(AppTheme.lightBlue.withOpacity(0.4), AppTheme.darkBlue.withOpacity(0.1), isMode),
                                            blurRadius: 30,
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("images/02-.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Gap(sw * 0.03),
                                                Text(
                                                  "Hospital Name",
                                                  style: GoogleFonts.labrada(
                                                    fontSize: 24,
                                                    color: AppTheme.getModeColor(AppTheme.lightDark, AppTheme.lightWhite, isMode),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: sw > 1600 ? sw * 0.05 : 10,
                                            top: sh * 0.12,
                                            child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: AnimationConfiguration.toStaggeredList(
                                              duration: const Duration(milliseconds: 2000),
                                              childAnimationBuilder: (widget) => SlideAnimation(
                                                horizontalOffset: 200.0,
                                                child: FadeInAnimation(
                                                  child: widget,
                                                ),
                                              ),
                                              children: [
                                                CustomOut(
                                                  sw: sw,
                                                  sh: sh,
                                                  labelText: 'hospital',
                                                  controller: data['phonenumber'] ?? '',
                                                  icon: Icons.phone,
                                                  isMode: isMode,
                                                ),
                                                CustomOut(
                                                  sw: sw,
                                                  sh: sh,
                                                  labelText: 'hospital',
                                                  controller: data['website'] ?? '',
                                                  icon: Icons.g_mobiledata_outlined,
                                                  isMode: isMode,
                                                ),
                                                CustomOut(
                                                  sw: sw,
                                                  sh: sh,
                                                  labelText: 'hospital',
                                                  controller: data['email'] ?? '',
                                                  icon: Icons.email,
                                                  isMode: isMode,
                                                ),
                                              ],
                                            ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: sh >  1000 ? 450  : 350,
                                      width: sw > 1450 ? sw * 0.28 : 300,
                                      decoration: BoxDecoration(
                                        color: AppTheme.getModeColor(AppTheme.lightWhite.withOpacity(0.8), AppTheme.darkBlue, isMode),
                                        borderRadius: BorderRadius.circular(sw * 0.02),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.getModeColor(AppTheme.lightBlue.withOpacity(0.4), AppTheme.darkBlue.withOpacity(0.1), isMode),
                                            blurRadius: 30,
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Column(

                                          children: AnimationConfiguration.toStaggeredList(
                                            duration: const Duration(milliseconds: 2000),
                                            childAnimationBuilder: (widget) => SlideAnimation(
                                              horizontalOffset: 200.0,
                                              child: FadeInAnimation(
                                                child: widget,
                                              ),
                                            ),

                                            children: [
                                              SizedBox(
                                                height: sh > 1000 ? 450  : 350,
                                                child: calendar_today(
                                                  isMode: isMode,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),

                      ],
                      ),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
