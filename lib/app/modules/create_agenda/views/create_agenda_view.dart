import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:testdeptech/app/widgets/custom_button.dart';
import 'package:testdeptech/app/widgets/custom_text_field.dart';

import '../controllers/create_agenda_controller.dart';

class CreateAgendaView extends GetView<CreateAgendaController> {
  const CreateAgendaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.black,
        ),
        backgroundColor: AppThemes.scaffoldColor,
        elevation: 0.5,
        title: Text(
          'CREATE AGENDA',
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
          const SizedBox(height: 10),
          CustomTextField(
            textEditingController: controller.descAgendaController,
            label: 'Desc Agenda',
          ),
          const SizedBox(height: 10),
          CustomTextField(
            enabled: false,
            textEditingController: controller.dateTimeAgendaController,
            label: 'Date Time',
          ),
          const SizedBox(height: 10),
          CustomTextField(
            enabled: false,
            textEditingController: controller.reminderController,
            label: 'Reminder',
          ),
          const SizedBox(height: 10),
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
                GetBuilder<CreateAgendaController>(
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
                      return const Text('No Image');
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
          const SizedBox(height: 60),
          Obx(
            () => CustomButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.addAgenda();
                }
              },
              textButton:
                  controller.isLoading.isFalse ? 'CREATE AGENDA' : 'LOADING...',
            ),
          )
        ],
      ),
    );
  }
}
