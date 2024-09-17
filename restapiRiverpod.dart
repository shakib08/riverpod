//Model.dart
class restApi {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Data>? data;
  Support? support;

  restApi(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  restApi.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    support = json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}




//*********************************************************************//
// data_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';  // Import the model

final dataProvider = FutureProvider<restApi>((ref) async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return restApi.fromJson(jsonData);
  } else {
    throw Exception('Failed to load data');
  }
});






//*********************************************************************//
//main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futureprovider/data_provider.dart';
import 'package:futureprovider/details_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final dataAsyncValue= ref.watch(dataProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Rest API Using riverpod", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
       body: dataAsyncValue.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.data!.length,
            itemBuilder: (context, index){
              final user = data.data![index]; 
              return Card(
                child: ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsPage(user: user))); 
                  },
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar??''),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text("${user.email}"),
                ),
              ); 
            }
            );
        }, 
        error: (err, stack) => Center(child: Text('Error: $err')), 
        loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}









//************************************************************************************************************
// details_page.dart
import 'package:flutter/material.dart';
import 'model.dart'; // Import the model

class DetailsPage extends StatelessWidget {
  final Data user;

  const DetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatar ?? ''),
            ),
            SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}


