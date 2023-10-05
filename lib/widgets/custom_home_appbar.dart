import 'package:doc_saver_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  const CustomHomeAppBar(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Image.asset(
                    "assets/icon_logo.png",
                    height: 50,
                  ),
                ),
                const Text(
                  "DocStash",
                  style: TextStyle(fontSize: 30),
                ),
                InkWell(
                  child: const Icon(Icons.settings),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pushNamed(SettingsScreen.routeName);
                  },
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorScheme.surfaceVariant,
              ),
              child: SearchBar(
                backgroundColor: MaterialStateProperty.all(
                  colorScheme.surfaceVariant,
                ),
                hintText: "Search documents",
                controller: controller,
                elevation: MaterialStateProperty.all(0),
                trailing: [
                  InkWell(
                      onTap: () {
                        onSearch();
                      },
                      child: const Icon(
                        Icons.search,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
