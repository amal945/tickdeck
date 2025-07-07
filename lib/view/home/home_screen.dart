import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../utils/colors.dart' show AppColors;
import '../../utils/custom_widgets/custom_logout_dialogue_box.dart';
import 'tabs/completed.dart';
import 'tabs/pending.dart';
import '../widgets/home_tab_bar.dart';
import '../widgets/home_fab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          title: const Text(
            "TODO",
            style: TextStyle(color: AppColors.onSurface),
          ),
          actions: [
            IconButton(
              onPressed: () => showLogoutDialog(context),
              icon: const Icon(Icons.logout_sharp, color: Colors.white),
            ),
          ],
          centerTitle: true,
          backgroundColor: AppColors.surface,
          bottom: const HomeTabBar(),
        ),
        body: const TabBarView(children: [Pending(), Completed()]),
        floatingActionButton: const HomeFAB(),
      ),
    );
  }
}
