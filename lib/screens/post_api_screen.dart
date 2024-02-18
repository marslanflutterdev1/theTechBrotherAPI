import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:the_tech_brother_api/api_model/post_api_model.dart';

class PostAPIScreen extends StatefulWidget {
  const PostAPIScreen({super.key});

  @override
  State<PostAPIScreen> createState() => _PostAPIScreenState();
}

class _PostAPIScreenState extends State<PostAPIScreen> {
  final url = 'https://jsonplaceholder.typicode.com/posts';

  List<PostApiModel> myAPIList = [];

  Future<List<PostApiModel>> PostAPI() async {
    final response = await https.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        myAPIList.add(PostApiModel.fromJson(i));
      }
      return myAPIList;
    } else {
      return myAPIList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Post API',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: PostAPI(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                    strokeWidth: 4,
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: myAPIList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            '${myAPIList[index].id}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${myAPIList[index].title}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        subtitle:  Container(
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${myAPIList[index].body}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                              softWrap: true,
                             // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlue,


                            child: Text(
                              '${myAPIList[index].userId}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
