import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'EditPage.dart';

class ReadPage extends StatefulWidget {
   ReadPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReadPage();
}

class _ReadPage extends State<ReadPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yazdırma/Okuma Sayfası')),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Map<String, dynamic> _data = {"id": document.id, ...data};
                return ListTile(
                  leading: IconButton(
                    onPressed: () async {Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(name: _data['name'] , age:_data['age'].toString() , id: _data['id'])));},
                    icon: const Icon(Icons.edit),
                  ),
                  title: Text(_data['name']),
                  subtitle: Text(_data['age'].toString()),
                  trailing: IconButton(
                    onPressed: () async {
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      try {
                        await users
                            .doc(_data['id'])
                            .delete()
                            .then((value) => print("User Deleted"))
                            .catchError((error) =>
                                print("Failed to delete user: $error"));
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
