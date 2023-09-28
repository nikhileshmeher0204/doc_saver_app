import 'dart:io';
import 'package:doc_saver_app/helper/snackbar_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../screens/home_screen.dart';

class DocumentProvider extends ChangeNotifier {
  String _selectedFileName = "";
  String get selectedFileName => _selectedFileName;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? _file;

  setSelectedFileName(String value) {
    _selectedFileName = value;
    notifyListeners();
  }

  pickDocument(BuildContext context) async {
    await FilePicker.platform
        .pickFiles(
      allowMultiple: false,
      allowedExtensions: ["pdf", "png", "jpeg", "jpg"],
      type: FileType.custom,
    )
        .then((result) {
      if (result != null) {
        PlatformFile selectedFile = result!.files.first;
        setSelectedFileName(selectedFile.name);
        _file = File(selectedFile.path!);
        SnackBarHelper.showErrorSnackBar(context, "File selected");
      } else {
        SnackBarHelper.showErrorSnackBar(context, "File not selected");
      }
    });
  }

  bool _isFileUploading = false;
  bool get isFileUploading => _isFileUploading;
  setIsFileUploading(bool value){
    _isFileUploading = value;
    notifyListeners();
  }

  sendDocumentData(
      {required String title,
      required String note,
      required BuildContext context}) async {
    try {
      setIsFileUploading(true);
      UploadTask uploadTask = _firebaseStorage
          .ref()
          .child("files")
          .child(_selectedFileName)
          .putFile(_file!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
      await _firebaseDatabase.ref().child("files_info").push().set({
        "title": title,
        "note": note,
        "dateAdded": DateTime.now().toString(),
        "fileUrl": uploadedFileUrl,
        "fileName": _selectedFileName,
        "fileType": _selectedFileName.split(".").last,
      });
      setIsFileUploading(false);
      Navigator.of(context).pushNamed(MyHomePage.routeName);
    } on FirebaseException catch (firebaseError) {
      setIsFileUploading(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsFileUploading(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }
}
