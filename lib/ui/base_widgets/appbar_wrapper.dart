import 'package:flutter/material.dart';

class AppBarWrapper extends StatelessWidget implements PreferredSizeWidget {
  final actionButtons;
  final title;
  AppBarWrapper({this.actionButtons, this.title});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actionButtons ?? [],
      title: Text(title ?? ""),
      iconTheme: new IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
