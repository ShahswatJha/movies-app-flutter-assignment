import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app_assignment_1828194/Pages/loginPage.dart';
import 'Pages/HomePage.dart';
import 'models/movieModel.dart';



//Future main() async{
  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MoviesAdapter());
  await Hive.openBox<Movies>('movies');
  // Loads all the data-- key value pairs from the local storage

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.yellow,
      // ),
      //darkTheme: ThemeData.dark(),
       theme: ThemeData(
            //primarySwatch: Color(0xFFE0F7FA),
            // visualDensity: VisualDensity(horizontal: 2.0, vertical: 2.0),
            // primaryColorLight: Color(0xff03203C),
            // primaryColorDark: Color(0xff242B2E),
            
            // Icon Theme
            iconTheme:
                IconThemeData(color: Colors.black, opacity: 10),
            accentColor: Colors.indigo[900],
            accentColorBrightness: Brightness.light),
      
      home: LoginPage(),
    );
  }
}

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       appBar: AppBar(
//         backgroundColor: Colors.indigo[900],
//         title: Text("Movies"),
//         centerTitle: true
//       ),
  //     floatingActionButton: ElevatedButton(

  //         style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
  //         ),
  //         onPressed: () {
  //           Navigator.push(context,MaterialPageRoute(
  //             builder: (context) => HomePage()
  //           ),
  // );
  //         },
  //         child: const Text('Show Movies'),
  //       ),
  //   );
//   }
// }
