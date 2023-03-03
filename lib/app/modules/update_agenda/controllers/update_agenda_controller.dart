import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:uuid/uuid.dart';

class UpdateAgendaController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleAgendaController = TextEditingController();
  TextEditingController descAgendaController = TextEditingController();
  TextEditingController dateTimeAgendaController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController photoAgendaController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
    } else {}
    update();
  }

  Future<void> updateAgenda(String agendaID) async {
    String uid = auth.currentUser!.uid;

    if (titleAgendaController.text.isNotEmpty &&
        descAgendaController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        var format = DateFormat.yMd();
        var formatTime = DateFormat.Hms();
        var dateString = format.format(DateTime.now());
        var timeString = formatTime.format(DateTime.now());

        Map<String, dynamic> data = {
          'titleAgenda': titleAgendaController.text,
          'descAgenda': descAgendaController.text,
          'dateTime': dateString,
          'reminderAgenda': timeString,
        };
        String uuid = const Uuid().v4().replaceAll("-", "");

        if (image != null) {
          File file = File(image!.path);
          String extension = image!.path.split(".").last;

          await storage.ref('photo/$uuid/photoAgenda.$extension').putFile(file);
          String urlImage = await storage
              .ref('photo/$uuid/photoAgenda.$extension')
              .getDownloadURL();

          data.addAll({'photoAgenda': urlImage});
        }

        await firestore
            .collection('users')
            .doc(uid)
            .collection('agenda')
            .doc(agendaID)
            .update(data);

        Get.offNamedUntil(Routes.HOME, (route) => false);
        Get.snackbar(
          'Berhasil',
          'Berhasil update agenda.',
          backgroundColor: AppThemes.green,
          colorText: AppThemes.white,
        );
      } catch (e) {
        Get.snackbar(
          'Gagal',
          'Tidak dapat update agenda.',
          backgroundColor: AppThemes.red,
          colorText: AppThemes.white,
        );
      }
    } else {
      Get.snackbar(
        'Gagal',
        'Pastikan semua field sudah terisi.',
        backgroundColor: AppThemes.red,
        colorText: AppThemes.white,
      );
    }
  }
}
