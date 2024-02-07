import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storyoftoday/eventupdate.dart';
import 'package:storyoftoday/model/datehandler.dart';
import 'package:storyoftoday/model/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'eventinsert.dart';

class EventPage extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;

  const EventPage({Key? key, required this.onChangeTheme}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late DatabaseHandler handler;
  DateTime? selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  late Map<DateTime, List<MyEvent>> events;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    events = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.querySdiary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return FutureBuilder(
              future: _updateEvents(snapshot.data),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      TableCalendar(
                        daysOfWeekHeight: 20,
                        firstDay: DateTime.utc(2000, 1, 1),
                        lastDay: DateTime.utc(2099, 12, 31),
                        locale: "ko_KR",
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        focusedDay: focusedDay,
                        onDaySelected:
                            (DateTime selectedDay, DateTime focusedDay) {
                          setState(() {
                            this.selectedDay = selectedDay;
                            this.focusedDay = focusedDay;
                            events = {};
                          });
                        },
                        eventLoader: (day) {
                          return events[day] ?? [];
                        },
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            final eventCount = events.length;
                            if (eventCount > 0) {
                              return Positioned(
                                bottom: 0,
                                child: Row(
                                  children: List.generate(
                                    eventCount,
                                    (index) => Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(
                                            255, 172, 148, 242),
                                      ),
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return null;
                            }
                          },
                        ),
                        selectedDayPredicate: (DateTime day) {
                          return isSameDay(
                              selectedDay ?? DateTime.now(), day);
                        },
                      ),
                      SizedBox(height: 15,),
                      if (events[selectedDay] != null)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            // height: MediaQuery.of(context).size.height * 0.178,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -5,
                                  left: 16,
                                  child: Text(
                                    '- 이날의 이야기 -',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 25,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: ListView.builder(
                                    itemCount: events[selectedDay]?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      MyEvent event =
                                          events[selectedDay]![index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 130,
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:  130,
                                                  height: 100,
                                                  // height: MediaQuery.of(context).size.height * 0.001,
                                                  child: (event.image != null)
                                                      ? Image.memory(
                                                          event.image!,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Container(
                                                      width: double.infinity,
                                                      color:(event.image != null) ? Color.fromARGB(255, 222, 228, 246) : Colors.transparent,
                                                      child: (event.image != null)
                                                          ?  Image.memory(event.image!,fit: BoxFit.cover,)
                                                          : Icon(
                                                        Icons.event_busy,
                                                        size: 48,
                                                        color: Color.fromARGB(255, 144, 144, 170),
                                                      )
                                                    )
                                                ),
                                                const SizedBox(width: 20),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            event.title,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          IconButton(
                                                            onPressed: () {},
                                                            iconSize: 16,
                                                            icon: getIconWidget(
                                                                event.weathericon ??
                                                                    ''),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        event.eventdate,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openEventInsertPage();
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _updateEvents(data) async {
    events = {}; // 초기화

    for (var diary in data!) {
      int year = int.parse(diary.eventdate!.substring(0, 4));
      int month = int.parse(diary.eventdate!.substring(5, 7));
      int day = int.parse(diary.eventdate!.substring(8, 10));

      DateTime eventDateTime = DateTime.utc(year, month, day);
      MyEvent event = MyEvent(
          diary.title, diary.image, diary.eventdate!, diary.weathericon!);

      events[eventDateTime] ??= [];
      events[eventDateTime]?.add(event);
    }
  }

  void _openEventInsertPage() {
    Get.to(() =>
        EventInsert(selectedDay: selectedDay, onChangeTheme: _changeThemeMode));
  }

  void _changeThemeMode(ThemeMode themeMode) {
    widget.onChangeTheme(themeMode);
  }

  // 문자열 iconString을 입력으로 받아 해당하는 아이콘을 생성하는 Flutter 위젯을 반환
  getIconWidget(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'sunny':
        return Icon(
          Icons.sunny,
          color: Colors.amber[400],
        );
      case 'waterdrop':
        return Icon(Icons.water_drop, color: Colors.blue[300]);
      case 'cloud':
        return Icon(
          Icons.cloud,
          color: Colors.grey[400],
        );
      case 'air':
        return Icon(
          Icons.air,
          color: Colors.blueGrey[200],
        );
      case 'acunit':
        return Icon(
          Icons.ac_unit,
          color: Colors.blue[100],
        );
      default:
        return const Icon(Icons.error);
    }
  }
}
