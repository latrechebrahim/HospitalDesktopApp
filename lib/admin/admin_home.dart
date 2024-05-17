
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/admin/admin_patients_list.dart';
import 'package:hospital_managements/services/dio.dart';
import '../Connection/connection.dart';
import '../doctor/doctor_home.dart';
import '../utils/Cards/DoctorsCard.dart';
import '../utils/Cards/slidingCard.dart';
import '../utils/app_styles.dart';
import '../utils/appointments_classes.dart';
import '../utils/menu.dart';
import 'admin_appointments.dart';
import 'admin_doctors_list.dart';
import 'admin_settings.dart';

class AdminHome extends StatefulWidget {
  final Map<String, dynamic> Data;
  const AdminHome({super.key, required this.Data});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  DioService dioService = DioService();
  late int totalDoctors = 0;
  late int totalPatients = 0;
  late int totalAppointments = 0;



  @override
  void initState() {
    super.initState();
    getCounts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCounts() async {
    try {
      Map<String, dynamic> data = await dioService.count();
      setState(() {
        totalDoctors = data['countDoctor'] ?? 0;
        totalPatients = data['countUsers'] ?? 0;
        totalAppointments = data['countAppointment'] ?? 0;
      });
    } catch (e) {
      print('Error fetching counts: $e');
      setState(() {
      });
    }
  }

  int isMode = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;

    return  Scaffold(
        backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
        body: SizedBox.expand(
          child: Row(
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
                          ElevatedButtonNotPressed(
                            text: "Settings",
                            icon: AppIcons.settings,
                            x: 150,
                            y: 40,
                            targetPage: (BuildContext context) =>
                                SettingsAdmin(Data: widget.Data),
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
                                AdminHome(Data: widget.Data),
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
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                          Container(
                            color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                            width: sw > 85 ? sw * 0.9 : 85,
                            height: sh > 85 ? sh * 0.9: 85,
                            child:  Column(
                                children: [
                                  Container(
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                    height: sh > 150 ? sh * 0.25 : 150,
                                    child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: AnimationConfiguration.toStaggeredList(
                                              duration: const Duration(milliseconds: 2000),
                                              childAnimationBuilder: (widget) =>
                                                  SlideAnimation(
                                                horizontalOffset: 200.0,
                                                child: FadeInAnimation(
                                                  child: widget,
                                                ),
                                              ),
                                              children: [
                                                Appointments_Statistics(
                                                  tital: 'Total Doctors',
                                                  total: totalDoctors,
                                                  icons: 'images/Med_Bottle.png',
                                                  sh: sh,
                                                  sw: sw,
                                                  isMode: isMode,
                                                ),
                                                SizedBox(width: 50),
                                                Appointments_Statistics(
                                                  tital: 'Total Patients',
                                                  total: totalPatients,
                                                  icons: 'images/Med_Bottle2.png',
                                                  sh: sh,
                                                  sw: sw,
                                                  isMode: isMode,
                                                ),
                                                SizedBox(width: 50),
                                                Appointments_Statistics(
                                                  tital: 'Total Appointments',
                                                  total: totalAppointments,
                                                  icons: 'images/Med_Bottle2.png',
                                                  sh: sh,
                                                  sw: sw,
                                                  isMode: isMode,
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: sh > 150 ? sh * 0.6 : 150,
                                          width: 550,
                                          decoration: BoxDecoration(
                                            color:
                                            AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkBlue, isMode),
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
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                                    AdminHome(
                                                                        Data: widget.Data,),),);
                                                      },
                                                      child: Text(
                                                        'Show All',
                                                        style:
                                                            GoogleFonts.labrada(
                                                          fontSize: 22,
                                                          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: sh * 0.55,
                                                child: FutureBuilder<Map<String, dynamic>>(
                                                  future: dioService.showAllAppointments(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Center(child: CircularProgressIndicator());
                                                    } else if (snapshot.hasError) {
                                                      return Center(child: Text('Error: ${snapshot.error}'));
                                                    } else if (snapshot.data == null || snapshot.data!['appointmentsData'] == null) {
                                                      return Center(child: Text('No data available'));
                                                    } else {
                                                      List<dynamic> appointmentsData = snapshot.data!['appointmentsData'];
                                                      return AnimationLimiter(
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          padding: EdgeInsets.all(10),
                                                          itemCount: appointmentsData.length,
                                                          itemBuilder: (context, index) {
                                                            Map<String, dynamic> appointment = appointmentsData[index]['appointment'];
                                                            Map<String, dynamic> userData = appointmentsData[index]['userData']['original']['userData'];
                                                            return AnimationConfiguration.staggeredList(
                                                              position: index,
                                                              duration: const Duration(milliseconds: 2000),
                                                              child: SlideAnimation(
                                                                horizontalOffset: -100.0,
                                                                child: FadeInAnimation(
                                                                  child: SlidingCard(
                                                                    sh: sh,
                                                                    sw: sw,
                                                                    Name: userData['Patient']?['firstname'] ?? 'No data',
                                                                    image: userData['Patient']?['photo'] ?? 'images/person.jpg',
                                                                    date: appointment['date'] ?? 'No data',
                                                                    isConformed: appointment['confirmed'] == 1,
                                                                    isMode: isMode,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Gap(sw * 0.02),
                                        Container(
                                          height: sh > 150 ? sh * 0.6 : 150,
                                          width: sw < 1450 ? 250  : 550,
                                          decoration: BoxDecoration(
                                            color:
                                            AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkBlue, isMode),
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "Doctors List",
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
                                                                    DoctorsList(
                                                                        Data: widget
                                                                            .Data)));
                                                      },
                                                      child: Text(
                                                        'Show All',
                                                        style:
                                                            GoogleFonts.labrada(
                                                          fontSize: 22,
                                                          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: sh > 150
                                                    ? sh * 0.55
                                                    : sh * 0.33,
                                                child: FutureBuilder<
                                                        Map<String, dynamic>>(
                                                    future: dioService
                                                        .showAllDoctors(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Center(
                                                            child: Text(
                                                                'Error: ${snapshot.error}'));
                                                      } else if (snapshot.data ==
                                                              null ||
                                                          snapshot.data![
                                                                  'users'] ==
                                                              null) {
                                                        return Center(
                                                            child: Text(
                                                                'No data available'));
                                                      } else {
                                                        List<Map<String, dynamic>>
                                                            patients = List<
                                                                    Map<String,
                                                                        dynamic>>.from(
                                                                snapshot.data![
                                                                    'users']);
                                                        return ListView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .all(10),
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          children:
                                                              AnimationConfiguration
                                                                  .toStaggeredList(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        2000),
                                                            childAnimationBuilder:
                                                                (widget) =>
                                                                    SlideAnimation(
                                                              verticalOffset:
                                                                  200.0,
                                                              child:
                                                                  FadeInAnimation(
                                                                child: widget,
                                                              ),
                                                            ),
                                                            children: patients
                                                                .map((patient) {
                                                              return DoctorsCard(
                                                                sw: sw,
                                                                sh: sh,
                                                                Name: 'Dr.' +
                                                                    (patient[
                                                                            'firstname'] ??
                                                                        ''),
                                                                photo: patient[
                                                                        'photo'] ??
                                                                    'images/person.jpg',
                                                                Phone_number:
                                                                    patient['phonenumber'] ??
                                                                        'No Data',
                                                                Specialization:
                                                                    patient['specialty'] ??
                                                                        'No Data',
                                                                isAvailable: patient[
                                                                        'isAvailable'] ==
                                                                    1,
                                                                isMode: isMode,
                                                              );
                                                            }).toList(),
                                                          ),
                                                        );
                                                      }
                                                    }),
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
                        ],
                      ),
                ),
            ],
          ),
        ),
    );
  }
}
