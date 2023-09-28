import 'package:flutter/material.dart';
import 'package:doc_saver_app/models/file_card_model.dart';

class FileCard extends StatelessWidget {
  final FileCardModel model;

  const FileCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(3),
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
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
            InkWell(
              onTap: () {},
              child: Text("View"),
            ),
          ],
        ),
      ),
    );
  }
}
