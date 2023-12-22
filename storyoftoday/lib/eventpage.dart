import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storyoftoday/eventdetail.dart';
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
      body: SingleChildScrollView(
        child: FutureBuilder(
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
                          daysOfWeekHeight: 50,
                          firstDay: DateTime.utc(2000, 1, 1),
                          lastDay: DateTime.utc(2099, 12, 31),
                          locale: "ko_KR",
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          focusedDay: focusedDay,
                          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
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
                                          color: Color.fromARGB(255, 172, 148, 242),
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
                            return isSameDay(selectedDay ?? DateTime.now(), day);
                          },
                        ),
                        const SizedBox(height: 10),
                        // if (events.isEmpty ||
                        //     (events[selectedDay] != null &&
                        //         events[selectedDay]!.isEmpty))
                        //   Container(
                        //     padding: const EdgeInsets.only(top: 30),
                        //     height: 500,
                        //     decoration: BoxDecoration(
                        //       borderRadius: const BorderRadius.only(
                        //         topLeft: Radius.circular(50),
                        //         topRight: Radius.circular(50),
                        //       ),
                        //       color: Theme.of(context).colorScheme.secondaryContainer,
                        //     ),
                        //     child: Stack(
                        //       children: [
                        //         Positioned(
                        //           top: 0,
                        //           left: 16,
                        //           child: Text(
                        //             'Event가 없습니다.',
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //               color: Theme.of(context).colorScheme.secondary,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   )
                        if (events[selectedDay] != null)
                        Container(
                            padding: const EdgeInsets.only(top: 30),
                            height: 500,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: Theme.of(context).colorScheme.secondaryContainer,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 16,
                                  child: Text(
                                    '- Today Event -',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: ListView.builder(
                                    itemCount: events[selectedDay]?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      MyEvent event = events[selectedDay]![index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 250,
                                                    height: 195,
                                                    child: Image.memory(
                                                      event.image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                      event.eventdate,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      maxLines: 7,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      ],
                    );
                  }
                },
              );
            }
          },
        ),
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
    MyEvent event = MyEvent(diary.title, diary.image, diary.eventdate!);

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
}
