import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'eventinsert.dart';


class EventPage extends StatefulWidget {
    final Function(ThemeMode) onChangeTheme;
  const EventPage({super.key, required this.onChangeTheme});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DateTime? selectedDay;
    DateTime focusedDay = DateTime.now();

    _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20,),
          TableCalendar(
            daysOfWeekHeight: 45,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2099, 12, 31),
            locale: "ko_KR",
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: focusedDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신.
              setState((){
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줌.
              return isSameDay(selectedDay ?? DateTime.now(), day);
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openEventInsertPage();
        },
        child: const Icon(Icons.add),
        ),
        
    );
  }
  //---FUNCTIONS---

  void _openEventInsertPage() {
    // _openEventInsertPage 메서드에서 selectedDay를 직접 사용
    Get.to(() => EventInsert(selectedDay: selectedDay, onChangeTheme: _changeThemeMode));
  }
}