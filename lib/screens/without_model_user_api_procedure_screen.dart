import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithOutModelUserAPIProcedureScreen extends StatefulWidget {
  const WithOutModelUserAPIProcedureScreen({super.key});

  @override
  State<WithOutModelUserAPIProcedureScreen> createState() =>
      _WithOutModelUserAPIProcedureScreenState();
}

class _WithOutModelUserAPIProcedureScreenState
    extends State<WithOutModelUserAPIProcedureScreen> {
  var data;
  Future<void> getAPIWithoutModel() async {
    final url = 'https://jsonplaceholder.typicode.com/users';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          title: const Text(
            'Without Model API Procedure',
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
              future: getAPIWithoutModel(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Card(
                          elevation: 2,
                          color: Colors.lightBlue,
                          shadowColor: Colors.blueGrey,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Please! await data loading',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        strokeWidth: 8,
                        color: Colors.lightBlue,
                      )
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        color: Colors.lightBlue,
                        shadowColor: Colors.blueGrey,
                        // surfaceTintColor: Colors.red,
                        child: Column(
                          children: [
                            ReuseableRowOfData(
                                title: "id",
                                value: data[index]["id"].toString()),
                            ReuseableRowOfData(
                                title: "name",
                                value: data[index]["name"].toString()),
                            ReuseableRowOfData(
                                title: "username",
                                value: data[index]["username"].toString()),
                            ReuseableRowOfData(
                                title: "email",
                                value: data[index]["email"].toString()),
                            ReuseableRowOfData(
                                title: "address by street",
                                value: data[index]["address"]["street"]
                                    .toString()),
                            ReuseableRowOfData(
                                title: "address by suite",
                                value:
                                    data[index]["address"]["suite"].toString()),
                            ReuseableRowOfData(
                                title: "address by city",
                                value:
                                    data[index]["address"]["city"].toString()),
                            ReuseableRowOfData(
                                title: "address by zipcode",
                                value: data[index]["address"]["zipcode"]
                                    .toString()),
                            ReuseableRowOfData(
                                title: "geo by latitude",
                                value: data[index]["address"]["geo"]["lat"]
                                    .toString()),
                            ReuseableRowOfData(
                                title: "geo by longitude",
                                value: data[index]["address"]["geo"]["lng"]
                                    .toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ))
          ],
        ));
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
