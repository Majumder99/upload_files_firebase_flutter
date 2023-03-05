import "package:flutter/material.dart";
import "package:flutter_upload_files/screens/files_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text("Upload Files"),
      ),
      body: Text("Welcome to my page"),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FilePage()));
              },
              child: Text("File Page"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FilePage()));
              },
              child: Text("Fetch Page"),
            ),
          ]),
        ),
      ),
    );
  }
}
