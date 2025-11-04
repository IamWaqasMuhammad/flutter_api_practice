import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_practice/models/comments_model.dart';
import 'package:http/http.dart' as http;

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});

  List<CommentsModel> commentsList = [];

  Future<List<CommentsModel>> getComments() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        commentsList.add(CommentsModel.fromJson(i));
      }
      return commentsList;
    } else {
      return commentsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments Screen'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getComments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.amberAccent),
                  );
                } else {
                  return ListView.builder(
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text('Title: ${commentsList[index].name}'),
                            Text('Description: ${commentsList[index].body}'),
                          ],
                        ),
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
