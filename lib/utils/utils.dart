
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

//deklarasi kelas
class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
//membuat static untuk menampilkan pesan
  static String getWelcomeMessage() {
    final hour = DateTime.now().hour;
    String msg;

//pengkondisian jam dan pesan yang akan ditampilkan
    if (hour < 12) {
      msg = 'Selamat Pagi';
    } else if (hour < 15) {
      msg = 'Selamat Siang';
    } else if (hour < 18) {
      msg = 'Selamat Sore';
    } else {
      msg = 'Selamat Malam';
    }

    return msg;
  }
}
