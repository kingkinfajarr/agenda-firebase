import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:testdeptech/app/widgets/custom_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemes.scaffoldColor,
        elevation: 0.5,
        title: Text(
          'HOME PAGE',
          style: AppThemes.headline1,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(
              Icons.person,
              color: AppThemes.black,
            ),
          ),
        ],
      ),
      backgroundColor: AppThemes.scaffoldColor,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamAgenda(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Tidak Ada Agenda!',
                style: AppThemes.headline3,
              ),
            );
          }

          List<QueryDocumentSnapshot<Map<String, dynamic>>> agenda =
              snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return CustomCard(
                titleAgenda: agenda[index]['titleAgenda'],
                descAgenda: agenda[index]['descAgenda'],
                arguments: agenda[index],
                onConfirm: () async {
                  await controller.deleteAgenda(
                    agenda[index]['id'],
                  );
                  Get.back();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_AGENDA);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
