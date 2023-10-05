import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {

  final String title;
  final Widget? trailing;
  final IconData leadingIcon;
  const SettingsCard({super.key, required this.title, this.trailing, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                  color: colorScheme.outline,
                  blurRadius: 2,
                  spreadRadius: 2
              )
            ]),
        child: ListTile(
          title: Text(title),
          leading: Icon(leadingIcon),
          trailing: trailing,
        ),
      ),
    );
  }
}
