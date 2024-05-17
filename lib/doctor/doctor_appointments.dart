import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hospital_managements/admin/admin_home.dart';
import 'package:hospital_managements/doctor/doctor_home.dart';
import 'package:hospital_managements/doctor/doctor_settings.dart';
import 'package:hospital_managements/utils/menu.dart';
import '../services/dio.dart';
import '../utils/utils_doctors/appointments_card.dart';
import '../utils/app_styles.dart';
import '../utils/text_edit.veiw.dart';

class AppointmentsDoctor extends StatefulWidget {
  final Map<String, dynamic> Data;

  const AppointmentsDoctor({super.key, required this.Data});

  @override
  State<AppointmentsDoctor> createState() => _AppointmentsDoctorState();
}

class _AppointmentsDoctorState extends State<AppointmentsDoctor> {
  DioService dioService = DioService();

  int isMode = 1;
  TextEditingController imagePathController = TextEditingController();
  @override
  void initState() {
    super.initState();
    imagePathController.text = widget.Data['path'] ?? 'images/person.jpg';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
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
              width: 230,
              height: sh > 150 ? sh * 2 : 150,
              color: AppTheme.getModeColor(
                  AppTheme.lightWhite, AppTheme.darkWhite, isMode),
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
                        ElevatedButtonPressed(
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
                              AppointmentsDoctor(Data: widget.Data),
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
                    width: sw < 1450 ? sw * 0.9 : sw * 0.9,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue, AppTheme.darkBlue, isMode),
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
                                Icons.calendar_today,
                                color: AppTheme.getModeColor(
                                    AppTheme.lightWhite,
                                    AppTheme.lightWhite,
                                    isMode),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Appointment",
                                style: TextStyle(
                                    color: AppTheme.getModeColor(
                                        AppTheme.lightWhite,
                                        AppTheme.lightWhite,
                                        isMode),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          TextEditView(
                            width: sh > 85 ? sh * 0.5 : 85,
                            hint: "Appointment",
                            suffixIcon: Icons.search,
                            backgroundColor: AppTheme.getModeColor(
                                AppTheme.lightWhite,
                                AppTheme.darkWhite,
                                isMode),
                            cursorColor: AppTheme.getModeColor(
                                AppTheme.darkWhite,
                                AppTheme.lightWhite,
                                isMode),
                            isMode: isMode,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imagePathController.text.isNotEmpty
                                          ? FileImage(File(imagePathController
                                                  .text as String) as File)
                                              as ImageProvider<Object>
                                          : AssetImage('images/person.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightBlue,
                                          AppTheme.darkBlue,
                                          isMode),
                                      width: 1,
                                    )),
                              ),
                              SizedBox(width: 10),
                              Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    widget.Data['lastname'] ?? 'No Data',
                                    style: TextStyle(
                                      color: AppTheme.getModeColor(
                                          AppTheme.lightWhite,
                                          AppTheme.lightWhite,
                                          isMode),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.getModeColor(
                                AppTheme.lightWhite, AppTheme.darkBlue, isMode)
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.circular(sw * 0.02),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.getModeColor(AppTheme.lightBlue,
                                    AppTheme.darkDark, isMode)
                                .withOpacity(0.4),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: sh > 150 ? sh * 0.85 : 150,
                              width: sw < 1140 ? sw * 0.6 : 1000,
                              child: Column(
                                children: [
                                  RefreshIndicator(
                                    onRefresh: () async {
                                      setState(() {});
                                      await dioService.showAllAppointments();
                                    },
                                    child: Container(
                                      height: sh * 0.85,
                                      child:
                                          FutureBuilder<Map<String, dynamic>>(
                                        future:
                                            dioService.showAppointmentsDoctor(
                                                widget.Data['id'].toString()),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          } else if (snapshot.data == null ||
                                              snapshot.data![
                                                      'appointmentsData'] ==
                                                  null) {
                                            return Center(
                                                child:
                                                    Text('No data available'));
                                          } else {
                                            List<dynamic> appointmentsData =
                                                snapshot
                                                    .data!['appointmentsData'];
                                            return ListView(
                                              scrollDirection: Axis.vertical,
                                              padding:
                                                  EdgeInsetsDirectional.all(10),
                                              clipBehavior: Clip.antiAlias,
                                              children: AnimationConfiguration
                                                  .toStaggeredList(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                childAnimationBuilder:
                                                    (widget) => SlideAnimation(
                                                  verticalOffset: 100.0,
                                                  child: FadeInAnimation(
                                                    child: widget,
                                                  ),
                                                ),
                                                children: appointmentsData
                                                    .map((userData) {
                                                  Map<String, dynamic>
                                                      appointment =
                                                      userData['appointment'];
                                                  Map<String, dynamic>
                                                      userOriginalData =
                                                      userData['userData']
                                                              ['original']
                                                          ['userData'];
                                                  return AppointmentsCard(
                                                    sh: sh,
                                                    sw: sw,
                                                    Name: userOriginalData[
                                                                'Patient']
                                                            ?['firstname'] ??
                                                        'No data',
                                                    image: userOriginalData[
                                                                'Patient']
                                                            ?['photo'] ??
                                                        'images/person.jpg',
                                                    date: appointment['date'] ??
                                                        'No data',
                                                    Content: appointment[
                                                            'content'] ??
                                                        'No data',
                                                    isConformed: appointment[
                                                            'confirmed'] ==
                                                        1,
                                                    isMode: isMode,
                                                    id: appointment['id'],
                                                    onDelete: () {
                                                      dioService
                                                          .deleteAppointment(
                                                              appointment['id']
                                                                  .toString())
                                                          .then((_) {
                                                        setState(() {});
                                                      });
                                                    },
                                                  );
                                                }).toList(), // Convert the map to a list
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
