import 'package:doc_saver_app/screens/document_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:doc_saver_app/models/file_card_model.dart';
import 'package:provider/provider.dart';

import '../provider/document_provider.dart';

class FileCard extends StatelessWidget {
  final FileCardModel model;

  const FileCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        tileColor: colorScheme.secondaryContainer,
        leading: model.fileType == "pdf"
            ? Image.asset(
                "assets/icon_pdf_type.png",
                width: 50,
              )
            : Image.asset(
                "assets/icon_image_type.png",
                width: 50,
              ),
        title: Text(model.title, style: Theme.of(context).textTheme.headline4),
        subtitle: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.subTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              Text("Date Added: ${model.dateAdded.substring(0, 10)}",
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: colorScheme.errorContainer,
                        title: const Text(
                            "Are you sure to delete the following document?"),
                        content: Text(model.title),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                print("${model.id} in FileCard");
                                Provider.of<DocumentProvider>(context,
                                        listen: false)
                                    .deleteDocumentData(
                                        model.id, model.fileName, context)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text("Delete"))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(DocumentViewScreen.routeName,
                    arguments: DocumentViewScreenArgs(
                        fileName: model.fileName,
                        fileUrl: model.fileUrl,
                        fileType: model.fileType));
              },
              child: Text("View"),
            ),
          ],
        ),
      ),
    );
  }
}
