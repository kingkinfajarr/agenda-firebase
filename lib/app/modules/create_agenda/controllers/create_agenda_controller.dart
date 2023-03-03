import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CreateAgendaController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleAgendaController = TextEditingController();
  TextEditingController descAgendaController = TextEditingController();
  TextEditingController dateTimeAgendaController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController photoAgendaController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<void> addAgenda() async {
    String uid = auth.currentUser!.uid;
    isLoading.value = true;
    if (titleAgendaController.text.isNotEmpty &&
        descAgendaController.text.isNotEmpty) {
      try {
        CollectionReference<Map<String, dynamic>> colAgenda =
            firestore.collection('users').doc(uid).collection('agenda');

        String uuid = const Uuid().v4().replaceAll("-", "");

        var format = DateFormat.yMd();
        var formatTime = DateFormat.Hms();
        var dateString = format.format(DateTime.now());
        var timeString = formatTime.format(DateTime.now());

        Map<String, dynamic> data = ({
          'titleAgenda': titleAgendaController.text,
          'descAgenda': descAgendaController.text,
          'dateTime': dateString,
          'reminderAgenda': timeString,
          'id': uuid,
        });

        if (image != null) {
          File file = File(image!.path);
          String extension = image!.path.split(".").last;

          await storage.ref('photo/$uuid/photoAgenda.$extension').putFile(file);
          String urlImage = await storage
              .ref('photo/$uuid/photoAgenda.$extension')
              .getDownloadURL();

          data.addAll({'photoAgenda': urlImage});
        }

        await colAgenda.doc(uuid).set(data);

        Get.offAllNamed(Routes.HOME);
        Get.snackbar(
          'Berhasil',
          'Berhasil menambahkan agenda',
          backgroundColor: AppThemes.green,
          colorText: AppThemes.white,
        );
      } catch (e) {
        Get.snackbar(
          'Gagal',
          'Gagal menambahkan agenda',
          backgroundColor: AppThemes.red,
          colorText: AppThemes.white,
        );
      }
    } else {
      Get.snackbar(
        'Gagal',
        'Pastikan field sudah terisi.',
        backgroundColor: AppThemes.red,
        colorText: AppThemes.white,
      );
      isLoading.value = false;
    }
  }
}
