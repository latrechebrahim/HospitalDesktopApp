import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hospital_managements/helper/Notif_error.dart';

class DioService {
  final Dio _dio;

  // ignore: unused_field
  bool _isLoading = false;

  DioService() : _dio = Dio() {
    //for ios simulator
    // _dio.options.baseUrl = 'http://127.0.0.1:8000/api';
    // for android emulator
    //10.50.0.61
    //192.168.137.1
    _dio.options.baseUrl = 'http://localhost/Backend/public/api';
    //  _dio.options.baseUrl = 'http://127.0.0.1:3306/api/auth';
    _dio.options.connectTimeout = Duration(seconds: 7);
    _dio.options.receiveTimeout = Duration(seconds: 5);
  }

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    _isLoading = true;

    try {
      Response response = await _dio.get(
        '/LoginDoctors?email=' + email + '&password=' + password,
      );
      return response.data;
    } catch (e) {
      return Future.error(e);
    } finally {
      _isLoading = false;
    }
  }

  ///////////////////////////////Admin/////////////////////////////////
  Future<Map<String, dynamic>> showAllPatients() async {
    _isLoading = true;

    try {
      Response response = await _dio.get('/showAllUsers');
      _isLoading =
          false; // Set isLoading to false here since the request is complete
      return response.data;
    } catch (e) {
      _isLoading =
          false; // Ensure isLoading is set to false even in case of errors
      print('Error occurred while fetching patient data: $e');
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> showAllDoctors() async {
    _isLoading = true;

    try {
      Response response = await _dio.get('/showAllDoctors');
      _isLoading =
          false; // Set isLoading to false here since the request is complete
      return response.data;
    } catch (e) {
      _isLoading =
          false; // Ensure isLoading is set to false even in case of errors
      print('Error occurred while fetching Doctors data: $e');
      return Future.error(
          'Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> showinfoDoctor(String Id) async {
    _isLoading = true;

    try {
      Response response = await _dio.get('/showInfoDoctor/' + Id);
      _isLoading =
          false; // Set isLoading to false here since the request is complete
      return response.data;
    } catch (e) {
      _isLoading =
          false; // Ensure isLoading is set to false even in case of errors
      print('Error occurred while fetching patient data: $e');
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> ResetPass(
    String Id,
    String Newpassword,
    String Newconfirmpassword,
    String password,
  ) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'password': Newpassword,
        'Newpassword': Newpassword,
        'Newconfirmpassword': Newconfirmpassword
      });
      var response = await _dio.post(
        '/ResetPass/' + Id,
        data: data,
      );
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching patient data: $e');
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> showAllAppointments() async {
    _isLoading = true;
    try {
      Response response = await _dio.get('/showAllAppointments');
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching patient data: $e');
      return Future.error(
          'Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> deleteDoctor(
    String id,
  ) async {
    _isLoading = true;

    try {
      Response response = await _dio.delete('/deleteDoctor?id=' + id);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> deletePatient(
    String id,
  ) async {
    _isLoading = true;

    try {
      Response response = await _dio.delete('/deletePatient?id=' + id);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }
  Future<Map<String, dynamic>> deleteAppointment(
      String id,
      ) async {
    _isLoading = true;

    try {
      Response response = await _dio.delete('/deleteAppointment?id=' + id);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      return Future.error(
          'Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> count() async {
    _isLoading = true;
    try {
      Response response = await _dio.get('/count');
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = true;
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> showHospital_info(
    String Id,
  ) async {
    _isLoading = true;
    try {
      Response response = await _dio.get('/showHospital_info/' + Id);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching Hospital data: $e');
      return Future.error(
          'Failed to fetch Hospital data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> showAppointmentsDoctor(
    String Id,
  ) async {
    _isLoading = true;
    try {
      Response response =
          await _dio.get('/showAppointments/' + Id + '/Doctor');
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching Appointments data: $e');
      return Future.error(
          'Failed to fetch Appointments data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> countAppointmentsDoctor(
    String DoctorId,
  ) async {
    _isLoading = true;
    try {
      Response response =
          await _dio.get('/countAppointmentsDoctor/' + DoctorId);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = true;
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  void RegisterDoctor(BuildContext context, String email, String password,
      String Admin, String isAvailable) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'email': email,
        'password': password,
        'admin': Admin,
        'isAvailable': isAvailable
      });

      var response = await _dio.post(
        '/RegisterDoctors',
        data: data,
      );
      if (response.statusCode == 200) {
        showDelayedAnimatedDialog(
            context,
            "Successfullyr",
            "Register Successfully! welcome to our platform.",
            Duration(microseconds: 300));
      }
    } catch (error) {
      showDelayedAnimatedDialog(
          context as BuildContext,
          "Error",
          "An error occurred during login: $error",
          Duration(microseconds: 300));
    } finally {
      _isLoading = false;
    }
  }

  void updateinfo(
    BuildContext context,
    String id,
    String firstname,
    String lastname,
    String specialty,
    String imagePath,
    String email,
    String phonenumber,
    String date_birth,
  ) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'firstname': firstname,
        'lastname': lastname,
        'specialty': specialty,
        'path': imagePath,
        'email': email,
        'phonenumber': phonenumber,
        'date_birth': date_birth,
      });

      var response = await _dio.post(
        '/update/Doctor?id=' + id,
        data: data,
      );
      if (response.statusCode == 200) {
        showDelayedAnimatedDialog(context, "Successfullyr",
            "update Successfully!", Duration(microseconds: 300));
      }
    } catch (error) {
      showDelayedAnimatedDialog(
          context as BuildContext,
          "Error",
          "An error occurred during login: $error",
          Duration(microseconds: 300));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> updateAppointments(
    BuildContext context,
    String id,
    String date,
  ) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'confirmed': '1',
        'date': date,
      });

      var response = await _dio.request(
        'http://127.0.0.1:8000/api/updateAppointments?id=' + id,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        showDelayedAnimatedDialog(context, "Successfullyr",
            "update Successfully!", Duration(microseconds: 300));
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      showDelayedAnimatedDialog(
          context as BuildContext,
          "Error",
          "An error occurred during login: $error",
          Duration(microseconds: 300));
    } finally {
      _isLoading = false;
    }
  }

  void updateHospital_info(
    BuildContext context,
    String id,
    String Name,
    String website,
    String imagePath,
    String email,
    String phonenumber,
  ) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'Name': Name,
        'website': website,
        'email': email,
        'path': imagePath,
        'phonenumber': phonenumber,
      });

      var response = await _dio.post(
        '/updateHospital_info?id=' + id,
        data: data,
      );
      if (response.statusCode == 200) {
        showDelayedAnimatedDialog(context, "Successfullyr",
            "update Successfully!", Duration(microseconds: 300));
      }
    } catch (error) {
      showDelayedAnimatedDialog(
          context as BuildContext,
          "Error",
          "An error occurred during login: $error",
          Duration(microseconds: 300));
    } finally {
      _isLoading = false;
    }
  }

  Future<Map<String, dynamic>> Hospital_info(String Id) async {
    _isLoading = true;

    try {
      Response response = await _dio.get('/showHospital_info/' + Id);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching patient data: $e');
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }
}
