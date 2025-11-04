import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_practice/models/user_model.dart';
import 'package:flutter_api_practice/screens/comments_screen.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  List<UserModel> userList = [];

  Future<List<UserModel>> getUser() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => CommentsScreen())),
              );
            },
            child: Icon(Icons.forward, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  );
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Center(
                            child: Text(
                              userList[index].id.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          userList[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(userList[index].website.toString()),
                        subtitle: Text(userList[index].email),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
