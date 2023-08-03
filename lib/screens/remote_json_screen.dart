import 'dart:convert';
import 'package:city_json/model/photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RemoteJSONScreen extends StatefulWidget {
  const RemoteJSONScreen({super.key});

  @override
  State<RemoteJSONScreen> createState() => _RemoteJSONScreenState();
}

class _RemoteJSONScreenState extends State<RemoteJSONScreen> {
  List<Photos>? listOfPhotos;

  Future<void> readJson() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    final data = jsonDecode(response.body);

    debugPrint('$data');
    List<Photos> allPhotos =
        List<Photos>.from(data.map((x) => Photos.fromJson(x)));

    setState(() {
      listOfPhotos = allPhotos;
    });

  }

  @override
  void initState() {
    super.initState();

    /// reading JSON from the remote json
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
                leading: CircleAvatar(
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
