import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'service.dart';
import 'tutorial.dart';

class Setting extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const Setting({super.key, required this.onChangeTheme});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool iconTheme = false;
  String themeName = '다크 모드';

  @override
  void initState() {
    super.initState();
    loadIconTheme(); // 저장된 값 로드
  }

  // 앱 시작 시에 호출하여 저장된 아이콘 테마 로드
  loadIconTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    setState(() {
      iconTheme = prefs.getBool('iconTheme') ?? false; //sharedPreferences를 사용하여 'iconTheme' 키에 저장된 값을 가져오고, 만약 값이 없으면 기본값으로 false를 사용
      themeName = prefs.getString('themeName') ?? '다크 모드';
    }); //setState 함수를 사용하여 상태를 업데이트하고, iconTheme 변수에 로드된 값을 할당
  }

  // 사용자가 테마를 변경할 때 호출하여 새로운 테마를 저장
  Future<void> saveIconTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('iconTheme', value); // prefs.setBool('iconTheme', value)를 사용하여 'iconTheme' 키에 전달된 value 값을 저장;
  }

  Future<void> saveNameTheme(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeName', value); // prefs.setBool('iconTheme', value)를 사용하여 'iconTheme' 키에 전달된 value 값을 저장;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '버전',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, ),),
                      Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        'ver 1.2',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const TermsOfService());
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  height: 60,
                  width:  double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '서비스 이용 약관',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,)),
                        Spacer(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
            GestureDetector(
              onTap: () => Get.to(() => const Tutorial()),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  height: 60,
                  width:  double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Tutorial',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,)),
                        Spacer(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                height: 60,
                width:  double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20,),
                    Text(themeName,
                        style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const Spacer(), //항상 오른쪽 끝에 위치, 남는 공간을 채움
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (iconTheme == true) {
                              iconTheme = false;
                              themeName = '다크 모드';
                              widget.onChangeTheme(ThemeMode.light);
                            } else {
                              iconTheme = true;
                              themeName = '라이트 모드';
                              widget.onChangeTheme(ThemeMode.dark);
                            }
                            saveIconTheme(iconTheme); // 변경된 값 저장
                            saveNameTheme(themeName);
                          });
                        },
                        icon: iconTheme == true
                            ? Icon(
                                Icons.sunny,
                                color: Colors.amber[300],
                                size: 28,
                              )
                            : Icon(
                                Icons.dark_mode,
                                color: Colors.amber[300],
                                size: 28,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
          ],
        ),
      ),
    );
  }
}
