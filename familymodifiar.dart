import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyProvider = Provider.family<String, String>(
  (ref, name){
 return "Hi this is $name"; 
});

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
        appBar: AppBar(
          title: Text("Family Modifier", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        body: shakib(),
      ),
      );
  }
}

class shakib extends ConsumerStatefulWidget {
  const shakib({super.key});

  @override
  ConsumerState<shakib> createState() => _shakibState();
}

class _shakibState extends ConsumerState<shakib> {
  @override
  Widget build(BuildContext context) {
    final name = ref.watch(familyProvider("Farhan")); 
    return Center(
      child: Text(name),
    );
  }
}
