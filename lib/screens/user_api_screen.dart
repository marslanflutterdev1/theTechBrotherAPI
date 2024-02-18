import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:the_tech_brother_api/api_model/user_api_model.dart';

class UserAPIScreen extends StatefulWidget {
  const UserAPIScreen({super.key});

  @override
  State<UserAPIScreen> createState() => _UserAPIScreenState();
}

class _UserAPIScreenState extends State<UserAPIScreen> {
  final url = 'https://jsonplaceholder.typicode.com/users';

  List<UserApiModel> userAPIList = [];
  Future<List<UserApiModel>> getUserAPI() async {
    final response = await https.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userAPIList.add(UserApiModel.fromJson(i));
      }

      return userAPIList;
    } else {
      return userAPIList;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(userAPIList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text(
          'User API',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserAPI(),
              builder: (context, AsyncSnapshot<List<UserApiModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Please! await data loading',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: userAPIList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                                color: Colors.redAccent,
                              ),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReuseableRowOfData(
                                    title: 'ID :',
                                    value: '${userAPIList[index].id}'),
                                ReuseableRowOfData(
                                    title: 'UserName ',
                                    value: '${userAPIList[index].username}'),
                                ReuseableRowOfData(
                                    title: 'Name :',
                                    value: '${userAPIList[index].name}'),
                                ReuseableRowOfData(
                                    title: 'Email :',
                                    value: '${userAPIList[index].email}'),
                                ReuseableRowOfData(
                                    title: 'Phone :',
                                    value: '${userAPIList[index].phone}'),
                                ReuseableRowOfData(
                                    title: 'Website :',
                                    value: '${userAPIList[index].website}'),
                                ReuseableRowOfData(
                                    title: 'Address By City :',
                                    value:
                                        '${userAPIList[index].address!.city}'),
                                ReuseableRowOfData(
                                    title: 'Address By Street :',
                                    value:
                                        '${userAPIList[index].address!.street}'),
                                ReuseableRowOfData(
                                    title: 'Address By Suite :',
                                    value:
                                        '${userAPIList[index].address!.suite}'),
                                ReuseableRowOfData(
                                    title: 'Zipcode Of Address :',
                                    value:
                                        '${userAPIList[index].address!.zipcode}'),
                                ReuseableRowOfData(
                                    title: 'Geo Of Lat :',
                                    value:
                                        '${userAPIList[index].address!.geo!.lat}'),
                                ReuseableRowOfData(
                                    title: 'Geo Of Lng :',
                                    value:
                                        '${userAPIList[index].address!.geo!.lng}'),
                              ],
                            ),
                          ),
                        ],
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

class ReuseableRowOfData extends StatelessWidget {
  ReuseableRowOfData({
    super.key,
    required this.title,
    required this.value,
  });

  String title;
  String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
