import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hospital_managements/utils/menu.dart';
import '../Connection/connection.dart';
import '../services/dio.dart';
import '../utils/Cards/DoctorsCardDetail.dart';
import '../utils/Cards/PatientsCardDetail.dart';
import '../utils/utils_doctors/appointments_card.dart';
import '../utils/app_styles.dart';
import '../utils/text_edit.veiw.dart';
import 'admin_appointments.dart';
import 'admin_doctors_list.dart';
import 'admin_home.dart';
import 'admin_settings.dart';

class PatientsList extends StatefulWidget {
  final Map<String, dynamic> Data;
  const PatientsList({super.key, required this.Data});

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  DioService dioService = DioService();

  int isMode = 1;

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
              width: 230,
              height: sh > 150 ? sh * 2 : 150,
              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
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
                      ElevatedButtonPressed(
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
                        targetPage: (BuildContext context) => SettingsAdmin(Data: widget.Data),
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
                    width: sw > 85 ? sw * 0.9 : 85,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
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
                                Icons.person,
                                color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                size: 40,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Patients",
                                style: TextStyle(
                                    color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextEditView(
                              width: sh > 85 ? sh * 0.5 : 85,
                              hint: "Patients..",
                              suffixIcon: Icons.search,
                              backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                              cursorColor: AppTheme.getModeColor(AppTheme.darkWhite, AppTheme.lightWhite, isMode),
                              isMode: isMode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    color:  AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                    child: Column(
                      children: [
                        Container(
                          height: sh > 150 ? sh * 0.9 : 150,
                          width: sw < 1140 ? sw * 0.7 : 900,
                          color:  AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                          child: Column(
                            children: [
                              RefreshIndicator(
                              onRefresh: () async {
                                    setState(() {});
                                         await dioService.showAllPatients();
                                   },
                                child: Container(
                                  height: sh * 0.8,
                                  child: FutureBuilder<Map<String, dynamic>>(
                                    future: dioService.showAllPatients(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      } else if (snapshot.data == null || snapshot.data!['users'] == null) {
                                        return Center(child: Text('No data available'));
                                      } else {
                                        List<Map<String, dynamic>> patients = List<Map<String, dynamic>>.from(snapshot.data!['users']);
                                        return ListView(
                                          scrollDirection: Axis.vertical,
                                          padding: EdgeInsetsDirectional.all(10),
                                          clipBehavior: Clip.antiAlias,
                                          children: AnimationConfiguration.toStaggeredList(
                                            duration: const Duration(milliseconds: 2000),
                                            childAnimationBuilder: (widget) => SlideAnimation(
                                              horizontalOffset: 100.0,
                                              child: FadeInAnimation(
                                                child: widget,
                                              ),
                                            ),
                                            children: patients.map((patient) {
                                              return PatientsCardDetail(
                                                id: patient['id'].toString() ?? 'No Data',
                                                email: patient['email'] ?? 'No Data',
                                                Phone_number: patient['phonenumber'] ?? 'No Data',
                                                photo: patient['path'] ?? 'images/person.jpg',
                                                Name: (patient['firstname'] ?? '') + ' ' + (patient['lastname'] ?? ''),
                                                onDelete: () {
                                                  dioService.deleteDoctor(patient['id'].toString()).then((_) {
                                                    setState(() {});
                                                  });
                                                },// Concatenate with empty strings to handle null
                                                sh: sh,
                                                sw: sw,
                                                isMode: isMode,
                                              );

                                            }).toList(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
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
