
import 'package:flutter/material.dart';



class Validations{
  Map<String, dynamic> validatefirstname(String input) {
    if (input.isEmpty) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText':Text('Please enter a First Name'),
         'validation' : false,
      };
    }
    if (input.length < 3) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text("The First Name is too short, minimum 3 characters"),
        'validation' : false
      };
    }
    if (input.length > 16) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text("The First Name is too Long ,  maximum 16 characters"),
        'validation' : false

      };
    }
    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true

    };
  }

 //////////////////////////////////////////
  Map<String, dynamic> validatelastname(String input) {
    if (input.isEmpty) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText':Text('Please enter a Last Name'),
        'validation' : false,
      };
    }
    if (input.length < 3) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text("The Last Name is too short, minimum 3 characters"),
        'validation' : false,
      };
    }
    if (input.length > 16) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text("The Last Name is too Long ,  maximum 16 characters"),
        'validation' : false,
      };
    }
    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true,
    };
  }

 /////////////////////////////////////////
  Map<String, dynamic> validatepassword(String input) {
    if (input.isEmpty) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText':Text('Please enter a password'),
        'validation' : false,
      };
    }
    if (!RegExp(r'[a-zA-Z]').hasMatch(input) || !RegExp(r'\d').hasMatch(input)) {
       return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text('Password must contain both letters and numbers'),
         'validation' : false,
      };
    }
    if (input.length < 8) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text("The password is too short, minimum 8 characters"),
        'validation' : false,
      };
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input)) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text('Password must contain special character'),
        'validation' : false,
      };
    }
    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true,
    };
  }

 /////////////////////////////////////////
  Map<String, dynamic> validateconfirmpassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText':Text('not the same password'),
        'validation' : false,
      };
    }
    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true,
    };
  }

 /////////////////////////////////////////
  Map<String, dynamic> validateEmail(String email) {
    if (email.isEmpty) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText':Text('Please enter a your email'),
        'validation' : false,
      };
    }
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (!emailRegex.hasMatch(email)) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text('Invalid email format'),
        'validation' : false,
      };
    }
    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true,
    };
  }

 /////////////////////////////////////////
  Map<String, dynamic> validatephonenumber(String input) {
    if (input.isEmpty) {
      return {
        'icon': Icon(Icons.error,color: Colors.red),
        'errorText': Text('Please enter a phone number'),
        'validation' : false,
      };
    }

    // Assuming a basic pattern for a valid phone number (adjust as needed)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(input)) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text('Invalid phone number format'),
        'validation' : false,
      };
    }

    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true,
    };
  }

  ///////////////////////////////////////////////////
  Map<String, dynamic> validateWebsite(String website) {
    if (website.isEmpty) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text('Please enter a website URL'),
        'validation': false,
      };
    }

    final websiteRegex = RegExp(
      r'^([^\W_]+\.)?[^\W_][^\W_-]*\.[a-z]{2,7}(\.[a-z]{2,7})?$',
      caseSensitive: false,
    );

    if (!websiteRegex.hasMatch(website)) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText': Text('Invalid website URL format'),
        'validation': false,
      };
    }

    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation': true,
    };
  }

///////////////////////////////////////////////////////
  Map<String, dynamic> validateName(String input) {
    if (input.isEmpty) {
      return {
        'icon': Icon(Icons.error, color: Colors.red),
        'errorText':Text('Please enter a Name'),
        'validation' : false,
      };
    }
    return {
      'icon': Icon(Icons.check, color: Colors.green),
      'errorText': null,
      'validation' : true

    };
  }
}






