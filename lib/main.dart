import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viapp/PradhaanApp/screens/login_screen.dart';
import 'package:viapp/PradhaanApp/ui/login_screen.dart';
import 'package:viapp/UserApp/ui/login_screen.dart';


void main() async {
  await init();
  runApp( MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) =>  const BaseApp(),
        '/LoginAsUser': (context) =>   LoginScreen(),
        '/LoginAsPradhaan': (context) =>   LoginPradhaan(),
        // When navigating to the "/second" route, build the SecondScreen widget.
          },
    );
  }
}



class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  double value  = 0;
  bool isLoading = false;
/*  final authController = AuthController();*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Center(child: Text('Login For Village App')),
      ),*/
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/village.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
                child: /*MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
              signIn(emailController.text, passwordController.text);
              },
              child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              )),*/

                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen())
                    );
                    // we had used future delayed to stop loading after
                    // 3 seconds and show text "submit" on the screen.
                    Future.delayed(const Duration(seconds: 3), (){
                      setState(() {
                        isLoading = false;
                      });
                    }
                    );
                  }, child: const Text(
                  "Login As User",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),

                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
                child: /*MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
              signIn(emailController.text, passwordController.text);
              },
              child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              )),*/

                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                 LoginPradhaan())
                    );
                    // we had used future delayed to stop loading after
                    // 3 seconds and show text "submit" on the screen.
                    Future.delayed(const Duration(seconds: 3), (){
                      setState(() {
                        isLoading = false;
                      });
                    }
                    );
                  },
                  child: const Text(
                  "Login As Pradhaan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),

                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}









