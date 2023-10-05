import 'package:doc_saver_app/provider/document_provider.dart';
import 'package:doc_saver_app/screens/home_screen.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AddDocumentScreen extends StatefulWidget {
  static String routeName = "/addDocumentScreen";

  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<DocumentProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Document"),
      ),
      floatingActionButton:
          Consumer<DocumentProvider>(builder: (context, provider, _) {
            return provider.isFileUploading
            ? const CircularProgressIndicator()
            : FloatingActionButton(
                backgroundColor: colorScheme.tertiary,
                child: Icon(
                  Icons.done,
                  color: colorScheme.onTertiary,
                ),
                onPressed: () {
                  _provider.sendDocumentData(
                      title: titleController.text,
                      note: noteController.text,
                      context: context);
                },
              );
      }),
      body: ListView(
        children: [
          CustomTextField(
            controller: titleController,
            hintText: "Add a title",
            labelText: "Title",
            prefixIconData: Icons.title,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: noteController,
            hintText: "Enter a note",
            labelText: "Note",
            prefixIconData: Icons.note,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a note';
              }
              return null;
            },
          ),
          InkWell(
            onTap: () {
              //provider.pickDocument(context);  provider not available
              //Provider.of<DocumentProvider>(context).pickDocument(context); This will call notifyListener() and again rebuild the UI
              //Provider.of<DocumentProvider>(context, listen: false).pickDocument(context); Create a final variable instead
              FocusScope.of(context).unfocus();
              _provider.pickDocument(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined),
                    Text(
                      "Select from device",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<DocumentProvider>(builder: (context, provider, _) {
            return Text(
              textAlign: TextAlign.center,
              provider.selectedFileName,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: colorScheme.onSurface,
              ),
            );
          }),
        ],
      ),
    );
  }
}
