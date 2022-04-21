import 'package:flutter/material.dart';

class Font {
  static const String primaryFont = 'Quicksand';
}

class ImagesPath {
  static const String backgroundImage = 'assets/img/background.png';
  static const String maleAvatar = 'assets/img/male-avatar.png';
  static const String logoPath = 'assets/img/logo.png';
}

class Dimensions {
  getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

class Messages {
  static const String httpError = 'Something went wrong';
}
