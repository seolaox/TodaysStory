import 'dart:typed_data';

class Sdiary {
  final int? id;
  final String title;
  final String content;
  final String? weathericon; //해당 속성들이 nullable(값이 null이 될 수 있는)한 경우를 나타내기 위해서 ? 사용
  final Uint8List? image;
  final DateTime? actiondate;
  final String? eventdate; 

  Sdiary({
    this.id,
    required this.title,
    required this.content,
    this.weathericon,
    this.image,
    this.actiondate,
    this.eventdate,
  });

  Sdiary.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        content = res['content'],
        weathericon = res['weathericon'],
        image = res['image'],
        actiondate = res['actiondate'] != null ? DateTime.parse(res['actiondate']) : null,
        eventdate = res['eventdate']; 
}


