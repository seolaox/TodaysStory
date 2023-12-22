import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

void main() async {
  // main 함수 비동기 처리 위해서 꼭 적어야 함.
  WidgetsFlutterBinding.ensureInitialized();
  // landscpae 막기
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  String theme = await _loadTheme();
  runApp(MyApp(theme:theme));
}

class MyApp extends StatefulWidget {
  final String theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String theme;
  late ThemeMode _themeMode; //사용자의 시스템에 따라 다크모드,라이트모드 설정되도록 하겠다.

  // static const seedColor = Color.fromARGB(255, 142, 94, 255);
  static const seedColor = Color.fromARGB(255, 134, 136, 241);

  @override
  void initState() {
    super.initState();
    _themeMode = widget.theme == '다크 모드' ? ThemeMode.light : ThemeMode.dark;
  }

  _changeThemeMode(ThemeMode themeMode){
    _themeMode = themeMode;
    setState(() {
      
    }); //setState로 화면 바뀌도록 설정하는것 , 다른 클래스에서는 thememode만 적용시키면 됨! 
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
          // ******* 
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: _themeMode,
      darkTheme: ThemeData(
        fontFamily: '강원교육모두 Bold',
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: seedColor,
      ),
      theme: ThemeData(
        fontFamily: '강원교육모두 Bold',
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: seedColor,
      ),
      home: Home(onChangeTheme: _changeThemeMode),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<String> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('themeName') != null){
      return prefs.getString('themeName')!;
    }
    return prefs.getString('themeName') ?? '다크 모드';
}
