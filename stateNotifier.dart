//CounterDemo.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterDemo extends StateNotifier<int>{
  CounterDemo(): super(0); 

  void increament(){
    state++;
  }
  void decreament(){
    state--; 
  }
}




//***************************************************************//


//main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodu/counterDemo.dart';

final value = StateNotifierProvider<CounterDemo, int>((ref)=>CounterDemo()); 

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
    final count = ref.watch(value);  
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(count.toString()), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: (){
                    ref.read(value.notifier).decreament(); 
                  }, 
                  child: Icon(Icons.remove),
                  ), 
                
                FloatingActionButton(
                  onPressed: (){
                    ref.read(value.notifier).increament(); 
                  }, 
                  child: Icon(Icons.add),
                  ),

              ],
            )
          ],
        )
      ),
    );
  }
}
