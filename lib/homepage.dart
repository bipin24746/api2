import 'dart:convert';
import 'package:api2/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> userDetails = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserDetails>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userDetails = snapshot.data!;
          return ListView.builder(
            itemCount: userDetails.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id: ${userDetails[index].id}'),
                        Text('Name: ${userDetails[index].name}'),
                        Text('UserName: ${userDetails[index].username}'),
                        Text('Email: ${userDetails[index].email}'),
                        Text('Phone: ${userDetails[index].phone}'),
                        Text('Website: ${userDetails[index].website}'),
                        Text(
                            'Company Name: ${userDetails[index].company.name}'),
                        Text(
                          'Address: ${userDetails[index].address.street}, '
                          '${userDetails[index].address.suite}, '
                          '${userDetails[index].address.city}, '
                          '${userDetails[index].address.zipcode},'
                          '${userDetails[index].address.geo.lat}, '
                          '${userDetails[index].address.geo.lng}',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<UserDetails>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body) as List;
      return data.map((json) => UserDetails.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
