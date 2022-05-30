import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget{
  CreatePage({Key? key}) : super(key: key);
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oluşturma Sayfası')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controllerAge,
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: addUser,
              child: const Text('Oluştur')
          ),
        ],
      ),
    );
  }

  void addUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> newData = {
      'name': controllerName.text,
      'age': controllerAge.text,
    };
    try {
      await users.add(newData)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      controllerAge.clear();
      controllerName.clear();
    } catch (e) {
          print(e);
    }
  }
}

