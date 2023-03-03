import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    Key? key,
    required this.titleAgenda,
    required this.descAgenda,
    required this.arguments,
    required this.onConfirm,
  }) : super(key: key);

  String titleAgenda;
  String descAgenda;
  dynamic arguments;
  void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppThemes.orange,
            offset: Offset(0.2, 0.2),
            blurRadius: 1,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Judul Agenda : $titleAgenda",
                  style: AppThemes.headline2,
                ),
                const SizedBox(height: 5),
                Text(
                  "Deskripsi : $descAgenda",
                  style: AppThemes.text1,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.UPDATE_AGENDA,
                    arguments: arguments,
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    titlePadding: const EdgeInsets.symmetric(vertical: 20),
                    contentPadding: const EdgeInsets.only(bottom: 20),
                    title: 'Hapus Agenda',
                    titleStyle: AppThemes.headline2,
                    middleText: 'Anda yakin ingin menghapus agenda?',
                    middleTextStyle: AppThemes.text1,
                    onCancel: () => Get.back(),
                    onConfirm: onConfirm,
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
