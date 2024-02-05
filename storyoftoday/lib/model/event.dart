import 'dart:typed_data';

class MyEvent {
  //밑에 이벤트로 보여줄 내용들만 담는 곳
  final String title;
  final Uint8List? image;
  final String eventdate;
  final String? weathericon;

MyEvent(this.eventdate, this.image, this.title, this.weathericon);
}