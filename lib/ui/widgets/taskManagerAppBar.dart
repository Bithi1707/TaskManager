import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controller/auth_controller.dart';

class TaskManagerAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({super.key});

  @override
  State<TaskManagerAppBar> createState() => _TaskManagerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TaskManagerAppBarState extends State<TaskManagerAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _onTapProfile,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AuthController.userModel?.photo == null
                  ? null
                  : MemoryImage(
                base64Decode(AuthController.userModel!.photo!),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel!.fullName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    AuthController.userModel!.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _onTapLogoutButton,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapLogoutButton() async {
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (predicate) => false);
  }

  void _onTapProfile() async {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != '/update_profile_Screen') {
      final updated = await Navigator.pushNamed(context, '/update_profile_Screen');
      if (updated == true) {
        setState(() {});
      }
    }
  }
}
