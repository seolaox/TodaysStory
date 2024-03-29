import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'components/appbarwidget.dart';
import 'home.dart';
import 'model/datehandler.dart';
import 'model/sdiary.dart';

class EventUpdate extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const EventUpdate({super.key, required this.onChangeTheme});

  @override
  State<EventUpdate> createState() => _EventUpdateState();
}

enum IconType {
  Sunny,
  WaterDrop,
  Cloud,
  Air,
  AcUnit,
}

class _EventUpdateState extends State<EventUpdate> {
  late IconType selectedIcon;
  late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int id;
  late String name;
  late Image image;
  XFile? imageFile; //image picker를 정의한 타입 안드로이드 ios 둘 다 다루기 위해 정의한 타입이 xfile
  final ImagePicker picker = ImagePicker();
  var value = Get.arguments ?? "_";
  late bool checkGallery;
  late DateTime presentdate;
  late DateTime date;
  late DateTime eventUpdateDate;
  late DateTime selectedDate; //날짜변경 버튼 누를 시 선택된 날짜
  late String formattedDate; //전 페이지에서 선택한 날짜

  _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
  }

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    titleController = TextEditingController();
    contentController = TextEditingController();
    id = value[0];
    titleController.text = value[1];
    contentController.text = value[2];
    selectedIcon = getIconTypeFromString(value[3]);
    presentdate =
        value[5] != null ? DateTime.parse(value[5].toString()) : DateTime.now();
    eventUpdateDate = DateTime.parse(value[6]);
    checkGallery = false;
    date = DateTime.now();
    selectedDate = eventUpdateDate;
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
          child: AppbarTitle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surfaceTint,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.event_available_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          disDatePicker();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(70, 30),
                          backgroundColor:
                              const Color.fromARGB(255, 154, 172, 243),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "날짜 변경",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 234, 234, 236),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIcon = IconType.Sunny;
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: selectedIcon == IconType.Sunny
                            ? const Color.fromARGB(255, 109, 147, 243)
                            : Colors.white,
                      ),
                      icon:
                          Icon(Icons.sunny, color: Colors.amber[400], size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIcon = IconType.WaterDrop;
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: selectedIcon == IconType.WaterDrop
                            ? const Color.fromARGB(255, 109, 147, 243)
                            : Colors.white,
                      ),
                      icon: Icon(Icons.water_drop,
                          color: Colors.blue[300], size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIcon = IconType.Cloud;
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: selectedIcon == IconType.Cloud
                            ? const Color.fromARGB(255, 109, 147, 243)
                            : Colors.white,
                      ),
                      icon:
                          Icon(Icons.cloud, color: Colors.grey[400], size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIcon = IconType.Air;
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: selectedIcon == IconType.Air
                            ? const Color.fromARGB(255, 109, 147, 243)
                            : Colors.white,
                      ),
                      icon: Icon(Icons.air,
                          color: Colors.blueGrey[200], size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIcon = IconType.AcUnit;
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: selectedIcon == IconType.AcUnit
                            ? const Color.fromARGB(255, 109, 147, 243)
                            : Colors.white,
                      ),
                      icon: Icon(Icons.ac_unit,
                          color: Colors.blue[100], size: 30),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title ',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: 'Content ',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  '수정을 원하시면 사진을 클릭해 주세요.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 0, width: double.infinity),
                _buildImagePicker(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    updateAction();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: const Color.fromARGB(255, 159, 168, 249),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "수정",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 236),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//---FUNCTIONS---

  getImage(ImageSource imageSource) async {
    //이미지 불러올때까지 기다려야 해서 async
    checkGallery = true;
    final XFile? pickedFile = await picker.pickImage(
        source: imageSource); //카메라에서 찍고, 갤러리에서 선택된게 pickedFile로 들어감
    if (pickedFile == null) {
      //취소할 경우 처리
      return;
    } else {
      imageFile =
          XFile(pickedFile.path); //imageFile에는 경로를 넣어놨는데 xfile의 경로를 알려주는거
      setState(() {});
    }
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: '사진 등록',
          middleText: '사진을 등록할 방법을 선택해 주세요',
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
                getImage(ImageSource.gallery);
              },
              style: ElevatedButton.styleFrom(
                    minimumSize: const Size(70, 40),
                    // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                    backgroundColor:Color.fromARGB(255, 183, 177, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
            child: Text('갤러리', style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 236),))),
            ElevatedButton(
              onPressed: () {
                Get.back();
                getImage(ImageSource.camera);
              },
              style: ElevatedButton.styleFrom(
                    minimumSize: const Size(70, 40),
                    // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                    backgroundColor: Color.fromARGB(255, 183, 177, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
            child: Text('카메라', style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 236),))),
          ]
          );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: (imageFile == null)
            ? Container(
                width: double.infinity,
                height: 270,
                color:(value[4] == null) ? Color.fromARGB(255, 212, 221, 247) : Colors.transparent,
                child: (value[4] != null)
                    ? Image.memory(value[4],fit: BoxFit.cover,)
                    : Icon(
                  Icons.add_a_photo,
                  size: 48,
                  color: Colors.grey,
                )
              )
            : Container(
                width: double.infinity,
                height: 270,
                child: Image.file(File(imageFile!.path),fit: BoxFit.cover,),
              ),
      ),
    );
  }


  // updateAction 함수에서 eventDate를 DateTime으로 변환하여 설정
  updateAction() async {
    //순서가 필요할때 무조건 async
    String title = titleController.text;
    String content = contentController.text;
    DateTime eventDate = selectedDate; // 선택된 날짜를 DateTime으로 변환

    //file type을 byte type으로 변환하기
    if (checkGallery == true && imageFile != null) {
      File imageFile1 = File(imageFile!.path); // imageFile경로를 file로 만들어 넣기
      Uint8List getImage =
          await imageFile1.readAsBytes(); //file type을 8type으로 변환

      var sdiaryUpdate = Sdiary(
        id: id,
        title: title,
        content: content,
        weathericon: getIconString(selectedIcon),
        image: getImage,
        actiondate: value[5],
        eventdate:
            DateFormat('yyyy-MM-dd').format(eventDate), // DateTime을 String으로 변환
      );

      await handler.updateSdiaryAll(sdiaryUpdate);
      _showDialog();
    } else {
      var sdiaryUpdate = Sdiary(
        id: id,
        title: title,
        content: content,
        weathericon: getIconString(selectedIcon),
        image: value[4],
        actiondate: value[5],
        eventdate:
            DateFormat('yyyy-MM-dd').format(eventDate), // DateTime을 String으로 변환
      );
      await handler.updateSdiary(sdiaryUpdate);
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
        title: '수정결과',
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
        middleText: '수정이 완료되었습니다.',
        middleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
        barrierDismissible: false,
        backgroundColor: const Color.fromARGB(255, 217, 203, 252),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(() => Home(onChangeTheme: _changeThemeMode),
                  arguments: 0);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          )
        ]);
  }

  // IconType을 문자열로 변환하기 위한 도우미 함수
  String getIconString(IconType icon) {
    switch (icon) {
      case IconType.Sunny:
        return 'Sunny';
      case IconType.WaterDrop:
        return 'WaterDrop';
      case IconType.Cloud:
        return 'Cloud';
      case IconType.Air:
        return 'Air';
      case IconType.AcUnit:
        return 'AcUnit';
    }
  }

  IconType getIconTypeFromString(String iconString) {
    switch (iconString) {
      case 'Sunny':
        return IconType.Sunny;
      case 'WaterDrop':
        return IconType.WaterDrop;
      case 'Cloud':
        return IconType.Cloud;
      case 'Air':
        return IconType.Air;
      case 'AcUnit':
        return IconType.AcUnit;
      default:
        return IconType.Sunny;
    }
  }

  // 날짜 변경 시 호출되는 함수
  void updateFormattedDate() {
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    setState(() {});
  }

  disDatePicker() async {
    //캘린더 날짜 범위 설정하기
    int firstYear = date.year - 1; //전년도 까지만 보기
    int lastYear = firstYear + 5; //5년뒤 까지 보기
    final selectedDate = await showDatePicker(
        //showDatePicker 화면을 구성하고 사용자가 selectedDate선택해서 값 받아올때까지 await 기다려
        //selectedDate는 showDatePicker에서 가져온 데이터라 String이 아님
        context: context,
        initialDate: date,
        firstDate: DateTime(firstYear),
        lastDate: DateTime(lastYear),
        initialEntryMode: DatePickerEntryMode.calendarOnly, //캘린더로 설정하기
        locale: const Locale('ko', 'KR') //한국시간으로 바꿔서 보여주기
        );
    if (selectedDate != null) {
      // 날짜 선택 시 selectedDate 업데이트
      this.selectedDate = selectedDate;
      // formattedDate 업데이트 함수 호출
      updateFormattedDate();
    }
  }
} //END
