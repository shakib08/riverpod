import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final increament = StateProvider<int>((ref)=>0); 

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: homePage(),
      ),
    );
  }
}
 

class homePage extends ConsumerStatefulWidget {
  const homePage({super.key});

  @override
  ConsumerState<homePage> createState() => _homePageState();
}

class _homePageState extends ConsumerState<homePage> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(increament);  
    return Scaffold(
      body: Center(
        child: Text(count.toString(), style: TextStyle(fontSize: 30),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(increament.notifier).state++; 
        }, 
        child: Icon(Icons.add),
        ),
    );
  }
}
