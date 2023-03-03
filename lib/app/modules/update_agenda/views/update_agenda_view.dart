import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:testdeptech/app/widgets/custom_button.dart';
import 'package:testdeptech/app/widgets/custom_text_field.dart';

import '../controllers/update_agenda_controller.dart';

class UpdateAgendaView extends GetView<UpdateAgendaController> {
  const UpdateAgendaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QueryDocumentSnapshot data = Get.arguments;

    controller.titleAgendaController.text = data['titleAgenda'];
    controller.descAgendaController.text = data['descAgenda'];
    controller.dateTimeAgendaController.text = data['dateTime'];
    controller.reminderController.text = data['reminderAgenda'];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.black,
        ),
        backgroundColor: AppThemes.scaffoldColor,
        elevation: 0.5,
        title: Text(
          'UPDATE AGENDA',
          style: AppThemes.headline1,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(
            textEditingController: controller.titleAgendaController,
            label: 'Title Agenda',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            textEditingController: controller.descAgendaController,
            label: 'Desc Agenda',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            enabled: false,
            textEditingController: controller.dateTimeAgendaController,
            label: 'Date Time',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            enabled: false,
            textEditingController: controller.reminderController,
            label: 'Reminder',
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Pilih Gambar',
            style: AppThemes.headline3,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppThemes.lightGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<UpdateAgendaController>(
                  builder: (controller) {
                    if (controller.image != null) {
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              File(controller.image!.path),
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    } else {
                      if (data['photoAgenda'] != null &&
                          data['photoAgenda'] != "") {
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                data['photoAgenda'],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        );
                      } else {
                        return const Text('No Image');
                      }
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: Text(
                    'Choose Image',
                    style: AppThemes.text1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Obx(
            () => CustomButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateAgenda(data['id']);
                }
              },
              textButton:
                  controller.isLoading.isFalse ? 'UPDATE' : 'LOADING...',
            ),
          ),
        ],
      ),
    );
  }
}
