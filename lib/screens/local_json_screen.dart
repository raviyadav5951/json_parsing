import 'dart:convert';

import 'package:city_json/model/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalJSONScreen extends StatefulWidget {
  const LocalJSONScreen({super.key});

  @override
  State<LocalJSONScreen> createState() => _LocalJSONScreenState();
}

class _LocalJSONScreenState extends State<LocalJSONScreen> {
  List<Photos>? listOfPhotos;
  
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/photos.json');
    final data = jsonDecode(response);

    List<Photos> allPhotos =
        List<Photos>.from(data.map((x) => Photos.fromJson(x)));

    setState(() {
      listOfPhotos = allPhotos;
    });

  }

  @override
  void initState() {
    super.initState();

    /// reading JSON from the local json file 
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('JSON Parsing test'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: listOfPhotos?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading:  CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Image.network('${listOfPhotos?[index].thumbnailUrl}'),
                ),
                title: Text('${listOfPhotos?[index].title}'),
                subtitle: const Text('Item description'),
                trailing: const Icon(Icons.more_vert),
              );
            }),
      ),
    );
  }
}
