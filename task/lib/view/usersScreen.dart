import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task/model/model.dart';
import 'package:http/http.dart';
import 'package:task/view/userdetails.dart';

class usersScreen extends StatefulWidget {
  const usersScreen({super.key});
  @override
  State<usersScreen> createState() => _usersScreenState();
}

class _usersScreenState extends State<usersScreen> {
  List<User> users = [];
  List<User> filtereduser = [];

  @override
  void initstate() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      users = data
          .take(10)
          .map((user) =>
              User(user['id'], user['name'], user['lat'], user['lng']))
          .toList();
      filtereduser = users;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("userapp"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (text) {
              setState(() {
                filtereduser = users
                    .where((user) =>
                        user.name.toLowerCase().contains(text.toLowerCase()))
                    .toList();
              });
            },
            decoration: InputDecoration(hintText: 'Search'),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: filtereduser.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filtereduser[index].name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsScreen(User: filtereduser[index])));
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
