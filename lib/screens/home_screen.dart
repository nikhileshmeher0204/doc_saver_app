import 'dart:async';

import 'package:animations/animations.dart';
import 'package:doc_saver_app/models/file_card_model.dart';
import 'package:doc_saver_app/widgets/custom_home_appbar.dart';
import 'package:doc_saver_app/widgets/file_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'add_document_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static String routeName = "/homeScreen";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  StreamController<DatabaseEvent> streamController = StreamController();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  setStream() {
    FirebaseDatabase.instance
        .ref()
        .child("files_info/$userId")
        .orderByChild("title")
        .startAt(searchController.text)
        .endAt("${searchController.text}" "\uf8ff")
        .onValue
        .listen((event) {
      streamController.add(event);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomHomeAppBar(
        controller: searchController,
        onSearch: () {
          setStream();
        },
      ),
      body: StreamBuilder<DatabaseEvent>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              List<FileCardModel> _list = [];
              print(snapshot.data!.snapshot.value);
              (snapshot.data!.snapshot.value as Map<dynamic, dynamic>)
                  .forEach((key, value) {
                print(key);
                _list.add(FileCardModel.fromJson(value, key));
              });
              return ListView(
                children: _list.map((e) {
                  print("Creating FileCard with id: ${e.id}");
                  return FileCard(
                    model: FileCardModel(
                      title: e.title,
                      dateAdded: e.dateAdded,
                      fileType: e.fileType,
                      subTitle: e.subTitle,
                      fileUrl: e.fileUrl,
                      fileName: e.fileName,
                      id: e.id,
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    "assets/icon_no_file.png",
                    height: 100,
                  )),
                  const Text(
                    "Please upload files to see them here!",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              );
            }
          }),
      floatingActionButton: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (context, openContainer) {
          FocusScope.of(context).unfocus();
          return const AddDocumentScreen();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        closedColor: colorScheme.surface,
        openColor: colorScheme.surface,
        closedBuilder: (context, openContainer) {
          return FloatingActionButton.extended(
            backgroundColor: colorScheme.tertiary,
            onPressed: openContainer,
            icon: Icon(
              Icons.add,
              color: colorScheme.onTertiary,
            ),
            label: Text(
              "Add file",
              style: TextStyle(color: colorScheme.onTertiary),
            ),
          );
        },
      ),
    );
  }
}
