// import 'dart:io';

// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';

// ScreenshotController screenshotController = ScreenshotController();

// void shareScore() async {
//   final image = await screenshotController.capture();
//   if (image != null) {
//     final path = '/storage/emulated/0/Download/basketball_score.png'; // مثال للـ path
//     await File(path).writeAsBytes(image);
//     await Share.shareFiles([path], text: 'Basketball Match Score');
//   }
// }
