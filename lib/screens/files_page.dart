import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:mime/mime.dart";

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  dynamic mimeType;
  PlatformFile? pickedFile;

  Future selectFiles() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        print(result.files.first.name);
        pickedFile = result.files.first;
        mimeType = lookupMimeType(result.files.first.name);
        print(mimeType);
        // image/jpeg image/jpg image/png
      });
      // do something with the selected file path
    } else {
      return;
      // user canceled the picker
    }
  }

  UploadTask? uploadTask;

  Future uploadFiles() async {
    //directory name is files
    final path = 'files/${pickedFile!.name}';
    // creating file object
    final file = File(pickedFile!.path!);

    // FirebaseStorage.instance.ref(). father
    //child then
    final ref = FirebaseStorage.instance.ref().child(path);

    // print(ref);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    // print(result);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download link :  $urlDownload");
    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text("Upload Files"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 10,
                  width: 200,
                  color: Colors.orangeAccent,
                  child: pickedFile != null
                      ? mimeType == "image/jpeg" ||
                              mimeType == "image/jpg" ||
                              mimeType == "image/png"
                          ? Image.file(
                              File(pickedFile!.path!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Text(pickedFile!.name)
                      : Container(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    selectFiles();
                  },
                  child: Text("Select Files",
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                onPressed: () {
                  uploadFiles();
                },
                child: Text(
                  "Upload Files",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              buildProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey,
                      color: Colors.green),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        },
      );
}
