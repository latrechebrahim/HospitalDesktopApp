import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/admin/admin_patients_list.dart';
import 'package:hospital_managements/utils/menu.dart';
import '../Connection/connection.dart';
import '../connection/validation.dart';
import '../helper/Notif_error.dart';
import '../services/dio.dart';
import '../utils/Cards/DoctorsCardDetail.dart';
import '../utils/custom_input.dart';
import '../utils/utils_doctors/appointments_card.dart';
import '../utils/app_styles.dart';
import '../utils/text_edit.veiw.dart';
import 'admin_appointments.dart';
import 'admin_home.dart';
import 'admin_settings.dart';

class DoctorsList extends StatefulWidget {
  final Map<String, dynamic> Data;
  const DoctorsList({super.key, required this.Data});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  bool _obscureText = true;
  Validations validation = Validations();
  bool? validationemail = false;
  bool? validationpassword = false;
  bool _isLoading = false;


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController admin = TextEditingController();
  TextEditingController isAvailable = TextEditingController();


  DioService dioService = DioService();

  Text? ErrorText;
  Icon? suffixIcon;

  Text? ErrorTextpassword;
  Color? borderColorvalidationfirstname;
  int isMode = 1;

  @override
  void initState() {
    super.initState();
    admin.text = '0';
    isAvailable.text = '0';
  }

  Map<String, dynamic> _currentData = {};

  Future<void> _refreshData() async {
      try {
        onRefresh: () async {
          setState(() {});
          await dioService.showAllDoctors();
        };
      } catch (error) {
        print('Error occurred while refreshing data: $error');
      }
  }


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
                      ElevatedButtonPressed(
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
                    color: AppTheme.getModeColor(
                        AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                color: AppTheme.getModeColor(
                                    AppTheme.lightWhite,
                                    AppTheme.lightWhite,
                                    isMode),
                                size: 40,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Doctors",
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
                          ElevatedButton(
                            style: ButtonStyle(
                              fixedSize:
                              MaterialStateProperty.all(Size(160, 40)),
                              foregroundColor:
                              MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode)),
                              backgroundColor:
                              MaterialStateProperty.all(AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode)),
                              mouseCursor:
                              MaterialStateMouseCursor.clickable,
                            ),
                            onPressed: () {
                              // Show dialog to edit user information
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),

                                    titlePadding: EdgeInsetsDirectional.all(8),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: AppTheme.getModeColor(
                                                  AppTheme.lightWhite.withOpacity(0.4), AppTheme.darkBlue, isMode),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppTheme.getModeColor(
                                                      AppTheme.lightBlue.withOpacity(.4), AppTheme.darkBlue.withOpacity(.2), isMode),
                                                  blurRadius: 30,
                                                  offset: Offset(0, 10),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add Doctor ',
                                                  style: TextStyle(
                                                    color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(30),
                                          Container(
                                            width: 330,
                                            height: 100,
                                            child: TextField(
                                              style: TextStyle(
                                                color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                              ),
                                              controller: email,
                                              keyboardType: TextInputType
                                                  .emailAddress,
                                              decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.email,
                                                  color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(30)),
                                                labelText: "Email Address",
                                                labelStyle: TextStyle(
                                                  color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                                ),
                                                errorText: ErrorText?.data,
                                                suffix: suffixIcon,
                                              ),
                                            ),
                                          ),
                                          CustomInputPassword(
                                            labelText: 'Password',
                                            controller: password,
                                            icon: Icon(
                                              Icons.security,
                                              color: AppTheme.getModeColor(
                                                  AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                            ),
                                            isMode: isMode,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Cancel',style: TextStyle(
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                        ),),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            dioService.RegisterDoctor(
                                              context,
                                              email.text.toString(),
                                              password.text.toString(),
                                              admin.text.toString(),
                                                isAvailable.text.toString()
                                            );
                                            _refreshData();
                                            Navigator.pop(context);
                                        },
                                        child: _isLoading
                                            ? CircularProgressIndicator(
                                          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.darkBlue1, isMode),
                                        )
                                            : Text('Save',style: TextStyle(
                                            color: AppTheme.getModeColor(
                                                AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                        ),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add,
                                    color: AppTheme.getModeColor(
                                        AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
                                ),
                                Gap(10),
                                Text('Add Doctor',style: TextStyle(
                                    color: AppTheme.getModeColor(
                                        AppTheme.lightBlue1, AppTheme.lightWhite, isMode)
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextEditView(
                              width: sh > 85 ? sh * 0.5 : 85,
                              hint: "Doctors..",
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
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                        child: Column(
                          children: [
                            Container(
                              height: sh > 150 ? sh * 0.9 : 150,
                              width: sw < 1450 ? sw * 0.63 : 900,
                              color: AppTheme.getModeColor(AppTheme.lightWhite, AppTheme.darkWhite, isMode),
                              child: Column(
                                children: [
                                  RefreshIndicator(
                                    onRefresh: () async {
                                      setState(() {});
                                      await dioService.showAllDoctors();
                                    },
                                    child: Container(
                                      height: sh * 0.8,
                                      child: FutureBuilder<Map<String, dynamic>>(
                                        future: dioService.showAllDoctors(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(child: Text('Error: ${snapshot.error}'));
                                          } else if (snapshot.data == null && snapshot.data!['users'] == null) {
                                            return Center(child: Text('No data available'));
                                          } else {
                                            List<Map<String, dynamic>> Doctors = List<Map<String, dynamic>>.from(snapshot.data!['users']);
                                            return  ListView(
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.all(10),
                                              clipBehavior: Clip.antiAlias,
                                              children: AnimationConfiguration.toStaggeredList(
                                                duration: const Duration(milliseconds: 2000),
                                                childAnimationBuilder: (widget) => SlideAnimation(
                                                  verticalOffset: 100.0,
                                                  child: FadeInAnimation(
                                                    child: widget,
                                                  ),
                                                ),
                                                children: Doctors.map((Doctor) {
                                                  final String name = ('Dr. ${Doctor?['lastname'] ?? ''} ${Doctor?['firstname'] ?? ''}').trim();
                                                  final String photo = Doctor?['photo'] ?? 'images/person.jpg';
                                                  final String phoneNumber = Doctor?['phonenumber'] ?? 'No Data';
                                                  final String specialization = Doctor?['specialty'] ?? 'No Data';
                                                  final bool isAvailable = Doctor?['isAvailable'] == 1;
                                                  final String email = Doctor?['email'] ?? 'No Data';
                                                  return DoctorsCardDetail(
                                                    sw: sw,
                                                    sh: sh,
                                                    onDelete: () {
                                                      dioService.deleteDoctor(Doctor['id'].toString()).then((_) {
                                                        setState(() {});
                                                      });
                                                    },
                                                    Name: name,
                                                    photo: photo,
                                                    Phone_number: phoneNumber,
                                                    Specialization: specialization,
                                                    isAvailable: isAvailable,
                                                    Email: email,
                                                    isMode: isMode,
                                                  );
                                                }).toList(),
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
                          ],
                        ),
                      ),

                    ],
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
