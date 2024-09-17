import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = Provider<String>((ref){
  return "Hi this is Shakib"; 
});

final nameProvider2 = Provider<String>((ref){
   return "Welcome to bdCalling"; 
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
        body: homePage(),
      ),
    );
  }
}
 
class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
               width: size.width*0.45,
               height: size.height*0.25,
               decoration: BoxDecoration(
               color: Colors.amber, 
               borderRadius: BorderRadius.circular(20)
               ),
            child: Center(
              child: Consumer(
                builder: (context, ref, child){
                  final name = ref.watch(nameProvider); 
                  return Text(name, style: TextStyle(fontWeight: FontWeight.bold),); 
                }
                ),
            ),   
            ), 
            
            SizedBox(width: size.width*0.05,), 

            Container(
               width: size.width*0.45,
               height: size.height*0.25,
               decoration: BoxDecoration(
                color: Colors.green,
               borderRadius: BorderRadius.circular(20)
               ),
            child: Center(
              child: Consumer(
                builder: (context, ref, child){
                  final second_name = ref.watch(nameProvider2); 
                  return Text(second_name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),); 
                }
                ),
            ),   
            ),

          ],
        ),
      ),
    );
  }
}
