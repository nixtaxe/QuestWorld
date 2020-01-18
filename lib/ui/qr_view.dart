//import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quest_world/blocs/date_bloc.dart';
import 'package:quest_world/blocs/tasks_bloc.dart';
import 'package:quest_world/models/question_model.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/ui/camera_screen.dart';
import 'package:toast/toast.dart';

class QrView extends StatefulWidget {
  final task;

  QrView({this.task});

  @override
  State<StatefulWidget> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  List<Question> questions;
  String qrCode = "";

  TaskItem get task => widget.task;

  @override
  void initState() {
    super.initState();
    tasksBloc.getQuestionById(task.question);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          buildQrCodeButton(),
          SizedBox(height: 10.0,),
          buildSaveButton(),
        ],
      ),
    );
  }

  Widget buildQrCodeButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Scan QR-code",
          style: Theme.of(context).textTheme.button,
        ),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () => scan(),
    );
  }

  scan() async {
    try {
      final status = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
      if (!(status == PermissionStatus.granted)) {
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      }
      String barCode = await BarcodeScanner.scan();//Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
      setState(() {
        qrCode = barCode ?? "";
      });
    } catch (e) {
      Toast.show(e.toString(), context);
    }
  }

  Widget buildSaveButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Send answer",
          style: Theme.of(context).textTheme.button,
        ),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () => saveAnswers(),
    );
  }

  saveAnswers() async {
    bool success = qrCode == task.qRCode;
    if (success) {
      Toast.show(qrCode ?? "", context);
      Future.delayed(Duration(milliseconds: 300))
          .then((value) => Navigator.pop(context));
    } else {
      String message = "Wrong. ";
      message += "Try again.";
      Toast.show(message, context, duration: Toast.LENGTH_LONG);
    }
  }
}
