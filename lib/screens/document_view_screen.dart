import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:http/http.dart';

class DocumentViewScreen extends StatelessWidget {
  static String routeName = "/documentViewScreen";
  const DocumentViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DocumentViewScreenArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.fileName),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return args.fileType == "pdf"
                ? PdfView(path: snapshot.data!)
                //path refers to the path of a file stored locally on the device
                : Image.file(File(snapshot.data!));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: getDocumentData(args),
      ),
    );
  }
}

Future<String> getDocumentData(
    DocumentViewScreenArgs documentViewScreenArgs) async {
  final directory = await getApplicationSupportDirectory();
  print(directory.path);
  File file = File("${directory.path}/${documentViewScreenArgs.fileName}");
  print(file.path);
  if (await file.exists()) {
    print("File exists");
    return file.path;
  } else {
    print("File downloading");
    final responce = await get(Uri.parse(documentViewScreenArgs.fileUrl));
    await file.writeAsBytes(responce.bodyBytes);
    return file.path;
  }
}

class DocumentViewScreenArgs {
  final String fileUrl;
  final String fileName;
  final String fileType;

  DocumentViewScreenArgs({
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
  });
}
