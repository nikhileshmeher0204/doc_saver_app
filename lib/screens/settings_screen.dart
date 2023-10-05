import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/provider/user_info_provider.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/settings_card.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settingsScreen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    final provider = Provider.of<UserInfoProvider>(context, listen: false);
    provider.getUserName();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(children: [
        Consumer<UserInfoProvider>(builder: (context, provider, _) {
          return SettingsCard(
            title: provider.username,
            leadingIcon: Icons.drive_file_rename_outline_rounded,
            trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: usernameController,
                            hintText: "Enter new username",
                              labelText: "User Name",
                            prefixIconData: Icons.person,
                            validator: (value) {
                              return null;
                            },),
                          CustomButton(onPressed: (){
                            provider.updateUserName(usernameController.text, context);
                          }, title: "Update")
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit)),
          );
        }),
        SettingsCard(
          title: provider.user!.email!  ,
          leadingIcon: Icons.email,
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logOut(context);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colorScheme.error)),
          child: Text(
            "Log out",
            style: TextStyle(color: colorScheme.onError),
          ),
        )
      ]),
    );
  }
}
