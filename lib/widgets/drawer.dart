import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torment/dialogs/about_dialog.dart';
import 'package:torment/resources/app_strings.dart';
import 'package:torment/services/auth.dart';
import 'package:torment/services/sharedPreferences.dart';
import 'package:torment/simple_widgets/snackbar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  String getCircleAvatarUrl() {
    AuthService authService = Get.find();

    if (authService.getUser == null) {
      return "https://t3.ftcdn.net/jpg/02/59/39/46/240_F_259394679_GGA8JJAEkukYJL9XXFH2JoC3nMguBPNH.jpg";
    } else {
      return authService.getUser!.photoURL ??
          "https://t3.ftcdn.net/jpg/02/59/39/46/240_F_259394679_GGA8JJAEkukYJL9XXFH2JoC3nMguBPNH.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.find();
    return SafeArea(
        child: Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orangeAccent.shade700,
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  authService.getUser?.displayName ?? "Untitled",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(getCircleAvatarUrl()),
                ),
              ),
            ),
          ),
          const _themeToggle(),
          ListTile(
            onTap: () async {
              showDailog_about();
            },
            leading: const Icon(Icons.info),
            title: const Text("About"),
          ),
          ListTile(
            onTap: () async {
              showLicensePage(context: context);
            },
            leading: const Icon(Icons.document_scanner),
            title: const Text("Licanses"),
          ),
          ListTile(
            onTap: () async {
              if (authService.isSignIn) {
                await authService.signOut();
                showSnackbar(
                  "You have been signed out",
                );
              }

              Get.back();
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sign out"),
          ),
        ],
      ),
    ));
  }
}

class _themeToggle extends StatefulWidget {
  const _themeToggle({
    Key? key,
  }) : super(key: key);

  @override
  State<_themeToggle> createState() => _themeToggleState();
}

class _themeToggleState extends State<_themeToggle> {
  bool _isDark = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: const Text("Dark Mode"),
        value: _isDark,
        secondary: const Icon(Icons.brightness_3),
        onChanged: (value) {
          AppSharedPreferences.saveBool(AppStrings.getTheme_KEY, value);
          Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
          _isDark = value;
          setState(() {});
        });
  }
}
