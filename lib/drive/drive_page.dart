import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:googledrivehandler/googledrivehandler.dart';
import 'package:open_file/open_file.dart';

import '../firebase_options.dart';
import 'drive_handler.dart';

class DrivePage extends StatelessWidget {
  const DrivePage({super.key});

  String get myApiKey {
    if (Platform.isAndroid) {
      return DefaultFirebaseOptions.android.apiKey;
    } else if (Platform.isIOS) {
      return DefaultFirebaseOptions.ios.apiKey;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    GoogleDriveHandler().setAPIKey(
      apiKey: myApiKey,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GoogleDriveHandlerExampleApp",
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                File? myFile = await GoogleDriveHandler()
                    .getFileFromGoogleDrive(context: context);
                if (myFile != null) {
                  /// Do something with the file
                  /// for instance open the file
                  OpenFile.open(myFile.path);
                  print(myFile.path);
                } else {
                  /// Discard...
                  print('discard');
                }
              },
              child: const Text(
                "Get file from google drive",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
