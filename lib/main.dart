import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() {
  //  ➡️  Poore app ke liye ek hi baar style set karo
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // 🔵  Nav-bar ka background (replace with your theme color)
      systemNavigationBarColor: Color(0xFFFFFFFF),

      // ⚫⚪  Icons light ya dark?  Light icons = white, Dark icons = black
      systemNavigationBarIconBrightness: Brightness.dark,

      // (Optional) Status-bar color + icon brightness
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.notoSansTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      // routes: Routes.routes,
      onGenerateRoute: _slideRouteGenerator,
      navigatorKey: NavigationService.instance.navigationKey,

      home: SplashScreen(),
    );
  }
}

Route<dynamic> _slideRouteGenerator(RouteSettings settings) {
  final builder = Routes.routes[settings.name];

  if (builder == null) {
    return MaterialPageRoute(
      builder: (context) =>
      const Scaffold(body: Center(child: Text('Route not found'))),
      settings: settings,
    );
  }

  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 400), // ⏱ forward
    reverseTransitionDuration: const Duration(milliseconds: 400), // ⏱ back
    pageBuilder: (context, animation, secondaryAnimation) =>
        builder(context), // page widget
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // off-screen right
      const end = Offset.zero; // on-screen
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: Curves.easeInOut));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
