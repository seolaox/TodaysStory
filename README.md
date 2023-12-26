# 오늘의 이야기
하루를 간편하게 기록하기 위해 만든 어플리케이션입니다. <br>
날씨,내용,이미지를 첨부하여 상세하게 기록할 수 있습니다.


2023-11-22 ~ 2023-11-30                      
<img src = https://github.com/seolaox/TodaysStory/blob/main/story%20of%20today%20main%20screen.png> </img>

------
### 1. 오늘의 이야기 홈 화면

<div style="display: flex; justify-content: space-between;">
    <img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/vacuum.png" width="30%">
    <img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventpage.png" width="30%">
</div>



- 앱 실행 시 첫 화면 입니다.
- 두 번째 탭 바로 이동하여 floatbutton을 눌러 내용을 입력할 수 있습니다.

<br><br>

### 2. 입력 화면

<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventinsert.png" width="30%">

<br><br>

- 날씨, 제목, 내용, 이미지를 첨부하여 기록할 수 있습니다.

### 3. 내용 입력 후 홈 화면
<div style="display: flex; justify-content: space-between;">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/homeview.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventupdate.png" width="30%">
</div>
<div style="display: flex; justify-content: space-between;">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventdelete.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventsearch.png" width="30%">
</div>

<br><br>

- 기록물을 왼쪽으로 밀거나, 탭하여 수정할 수 있습니다.
- 기록물을 오른쪽으로 밀어 삭제할 수 있습니다.
- 기록물의 내용을 기반으로 검색할 수 있습니다.

### 4. 내용 디테일 화면

<div style="display: flex; justify-content: space-between;">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventdetail.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/eventpagedetail.png" width="30%">
</div>

<br><br>

- 기록물을 탭하여 자세히 볼 수 있습니다.
- 달력에 기록한 날짜에 이벤트로 표시되어 기록물에 대한 간략한 내용을 볼 수 있습니다.


### 5. 메모 / 투두리스트
<div style="display: flex; justify-content: space-between;">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/memoinsert.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/memoupdate.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/memodelete.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/todolist.png" width="30%">
</div>

<br><br>

- 메모, 체크리스트를 slidable을 사용하여 수정, 삭제 할 수 있습니다.


### 5. 설정
<div style="display: flex; justify-content: space-between;">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/setting.png" width="30%">
<img alt="color_screen" src="https://github.com/seolaox/TodaysStory/blob/main/storyoftoday/images/tutorial.png" width="30%">
</div>

<br><br>

- 서비스 이용 약관 항목에서 약관을 확인 할 수 있습니다.
- 사용자의 UX를 고려하여 앱사용설명서를 만들었습니다.


# Packages

```yaml
  # 달력 사용
  table_calendar: ^3.0.9

  # 달력 날짜 설정위해
  flutter_localizations:
    sdk: flutter

  # DB 사용 
  sqflite: ^2.3.0

  # sqlite 위치파악
  path: ^1.8.3

  # 앨범 사용
  image_picker: ^1.0.4

  # 상태 관리
  get: ^4.6.6

  # 카드 수정, 삭제
  flutter_slidable: ^3.0.1

  # 탭바 사용
  motion_tab_bar_v2: ^0.3.0

  # 테마값 저장
  shared_preferences: ^2.2.2

  #splash 실행화면
  flutter_native_splash: ^2.3.6

  #intl 
  intl: ^0.18.1

  # 폰트 사용
  fonts: 강원교육모두 Bold
```

 


# Database
    SQLITE  


# 시연 영상
<a href="https://drive.google.com/file/d/1F7v24omyGk1MSMJKgkiosoN3rd3CIcGN/view?usp=sharing" title="시연영상으로 이동">
  <img src="https://github.com/seolaox/TodaysStory/blob/main/main%20screen.jpeg" alt="image" ,height="30%", width="30%">
</a>

