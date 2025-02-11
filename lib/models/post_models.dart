import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostModels {
  int userId;
  int id;
  String title;
  String body;
  PostModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModels.fromJson(Map<String, dynamic> fromeJson) {
    return PostModels(
      userId: fromeJson['userId'],
      id: fromeJson['id'],
      title: fromeJson['title'],
      body: fromeJson['body'],
    );
  }
}

class CustomMyApp extends StatefulWidget {
  const CustomMyApp({super.key});

  @override
  State<CustomMyApp> createState() => _CustomMyAppState();
}

class _CustomMyAppState extends State<CustomMyApp> {
  List<PostModels> listOfPostApi = []; // Empty list
  Future<List<PostModels>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        var content = PostModels.fromJson(i);
        listOfPostApi.add(content);
      }
      return listOfPostApi;
    } else {
      return listOfPostApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Expanded(
          child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.deepPurpleAccent, size: 50),
                );
              } else {
                return ListView.builder(
                  itemCount: listOfPostApi.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.outer,
                                color: Colors.black,
                              ),
                            ]),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                  'Id : ${listOfPostApi[index].id.toString()}'),
                              Text(
                                  'User Id : ${listOfPostApi[index].userId.toString()}'),
                              Text(
                                  'Title : ${listOfPostApi[index].title.toString()}'),
                              Text(
                                  'Body : ${listOfPostApi[index].body.toString()}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
