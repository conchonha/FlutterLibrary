import 'package:regexpattern/regexpattern.dart';

class ValidateUtil {
  /// [isEmail] check invalid email
  static bool isEmail(String? em) {
    if (em == null) return false;
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  /// [isNumber] check invalid number
  static bool isNumber(String value) {
    RegExp regExp = RegExp(r'^[0-9]*$');
    return regExp.hasMatch(value);
  }

  /// [isPasswordSecure] check invalid password
  static bool isPasswordSecure(String value) {
    if (value.isEmpty) {
      return false;
    }
    //(?<!\d)\d{4,}(?!\d)
    //r'^(?=.*[a-zA-Z]{3,})(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,20})(?!\d{4,})(?!\[!@#\$%\^&]{4,})',
    RegExp regExp = RegExp(
      //r'^\S*(?=\S{8,20})(?=((?!S*[\d]{4,}).)(?=\S*[a-zA-Z]){3,})(?=\S*[\d])(?=\S*[\W])\S*$',
      r'^(?=.*[a-zA-Z]{3,})(?=.*[0-9])(?=.*[\(\)\\|!@#\/$%\^&\*+\+\-\=\_\?\>\<\.\,\]\[\{\}\~\`])(?!.*(.)\1{3,})(?!.*(1234|2345|3456|4567|5678|6789|9876|8765|7654|6543|5432|4321)).{8,20}$',
      caseSensitive: false,
      multiLine: false,
    );

    if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  /// [isPhoneUser] check invalid Phone
  static bool isPhoneUser(String? phone) => RegVal.hasMatch(phone, RegexPattern.phone);

  /// [isNameUser] check invalid user Name
  static bool isNameUser(String? value) => RegVal.hasMatch(value, RegexPattern.username);

  /// [isUrl] check invalid Url
  static bool isUrl(String? value) => RegVal.hasMatch(value, RegexPattern.url);

  /// [isHexadecimal] check invalid hexadecimal
  static bool isHexadecimal(String? value) => RegVal.hasMatch(value, RegexPattern.hexadecimal);

  /// [isVector] check invalid Vector
  static bool isVector(String? value) => RegVal.hasMatch(value, RegexPattern.vector);

  /// [isImage] check invalid Image
  static bool isImage(String? value) => RegVal.hasMatch(value, RegexPattern.image);

  /// [isAudio] check invalid Audio
  static bool isAudio(String? value) => RegVal.hasMatch(value, RegexPattern.audio);

  /// [isVideo] check invalid Audio
  static bool isVideo(String? value) => RegVal.hasMatch(value, RegexPattern.video);

  static bool isPasswordAndConfirmPasswordMatch(
      String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    }
    return false;
  }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static bool doesGreatEqualThan14Years(DateTime dateSelected) {
    // check >14 year old
    if (calculateAge(dateSelected) >= 14) {
      return true;
    }
    return false;
  }
}
