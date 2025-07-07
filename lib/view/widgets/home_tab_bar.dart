
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return TabBar(
      labelColor: Colors.blue,
      indicatorColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      tabs: [
        Obx(() => Tab(text: 'Pending (${controller.pending.value})')),
        Obx(() => Tab(text: 'Completed (${controller.completed.value})')),
      ],
    );
  }
}
