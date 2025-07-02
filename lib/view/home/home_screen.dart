import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../utils/colors.dart' show AppColors;
import '../../utils/constants.dart';
import '../../utils/custom_widgets/custom_logout_dialogue_box.dart';
import '../add_edit_todo/add_edit_todo.dart';
import 'widgets/completed.dart';
import 'widgets/pending.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          title: const Text(
            "TODO",
            style: TextStyle(color: AppColors.onSurface),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showLogoutDialog(context);
              },
              icon: Icon(Icons.logout_sharp,color: Colors.white,),
            ),
          ],
          centerTitle: true,
          backgroundColor: AppColors.surface,
          bottom: TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Obx(() => Tab(text: 'Pending (${controller.pending.value})')),
              Obx(() => Tab(text: 'Completed (${controller.completed.value})')),
            ],
          ),
        ),
        body: TabBarView(children: [Pending(), Completed()]),

        floatingActionButton: ElevatedButton(
          onPressed: () {
            Get.to(() => AddEditTodoScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Create", style: TextStyle(color: AppColors.onSurface)),
              AppSpacing.width(0.02),
              Icon(Icons.add, color: AppColors.onSurface),
            ],
          ),
        ),
      ),
    );
  }
}
