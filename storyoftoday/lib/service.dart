import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {

    TableRow _buildColoredTableRow(List<String> cells, Color color) {
    return TableRow(
      children: cells
          .map((cell) => Container( //각 문자열 cell에 대해 주어진 함수를 실행
                color: color,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  cell,
                  // style: const TextStyle(
                  //   color: Colors.black, 
                  // ),
                ),
              ))
          .toList(), // Iterable을 리스트로 변환하는 메서드
    );
  }

      TableRow _buildColoredTableOneRow(List<String> cells) {
    return TableRow(
      children: cells
          .map((cell) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  cell,
                  // style: const TextStyle(
                  //   color: Colors.black, 
                  // ),
                ),
              ))
          .toList(),
    );
  }
      TableRow _buildColoredTableTwoRow(List<String> cells) {
    return TableRow(
      children: cells
          .map((cell) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  cell,
                  // style: const TextStyle(
                  //   color: Colors.black, 
                  // ),
                ),
              ))
          .toList(),
    );
  }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        title: const Text(
          '서비스 이용 약관',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '[개인정보 처리방침]',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    '❮오늘의 이야기❯는 다이어리 서비스를 제공함에 있어 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보 보호법」 제 30조에 따라 정보주체에게 개인정보 처에 관한 절차 및 기준을 안내하고, 이용자의 개인정보를 보호하고 이를 관리하기 위해 다음과 같은 처리방침을 둡니다'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '개인정보의 처리목적',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                    ' ❮오늘의 이야기❯는 다음의 목적을 위여 개인정보를 처리합니다. \n 처리하고 있는 개인정보는 다음의 목적 이외의 용동에는 이용되지 않으며, 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.'),
                const Text('     • 서비스 제공'),
                const Text('        콘텐츠, 맞춤서비스 제공의 목적으로 개인정보를 처리합니다.'),
                const Text('     • 고충처리 목적'),
                const Text('        각종 고지∙통지, 고충처리 목적으로 개인정보를 처리합니다. '),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '개인정보 처리 및 보유 기간',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                    ' ❮오늘의 이야기❯는 법령에 따른 개인정보 보유•이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유•이용기간 내에서 개인정보를 처리•보유합니다.'),
                const Text('     개인정보 처리 및 보유 기간은 다음과 같습니다.'),
                const Text('      • 기록 서비스 제공'),
                const Text('        • 이용자가 작성한 글, 사진 : 이용자가 삭제 요청 시까지'),
                const Text('        • <예외 사유>시에는 <보유기간>까지'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '처리하는 개인정보의 항목',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                    '  ❮오늘의 이야기❯는 다음의 개인정보 항목을 처리하고 있습니다.'),

                    const SizedBox(height: 5,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(60.0), // 첫 세 열의 너비를 50으로 설정
                        1: FixedColumnWidth(85.0),
                        2: FixedColumnWidth(70.0),
                        3: FixedColumnWidth(145.0), // 네 번째 열의 너비를 100으로 설정
                      },
                      children: <TableRow>[
                        _buildColoredTableRow(['서비스', '수집 목적', '수집 항목', '보유 및 이용시간'], Theme.of(context).colorScheme.surfaceVariant),
                        _buildColoredTableOneRow(['글 작성', '서비스 제공', '이용자 사진', '이용자의 삭제 요청 시까지']),
                        _buildColoredTableTwoRow(['회원 관리', '고충처리 목적', '이메일 주소', '서비스 공급 완료 시까지']),
                      ],
                    ),
                  ),

                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '개인정보의 파기 절차 및 방법에 관한 사항',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text('   ❮오늘의 이야기❯는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다. 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터 베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.'),
                
                const Text(' 개인정보 파기의 절차 및 방법은 다음과 같습니다.'),
                const Text(' 1. 파기절차'),
                const Text(' ❮오늘의 이야기❯는 파기 사유가 발생한 개인정보를 선정하고, ❮오늘의 이야기❯의 개인 정보 보호책임자의 승인을 받아 개인정보를 파기합니다.'),
                const Text(' 2. 파기방법'),
                const Text(' ❮오늘의 이야기❯는 전자적 파일 형태로 기록•저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록•저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다'),
  

                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '정보주체와 법정대리인의 권리•의무 및 행사방법',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text('① 정보주체는 ❮오늘의 이야기❯에 대해 언제든지 개인정보 열람•정정·삭제•처리정지 요구 등의 권리를 행사할 수 있습니다.'),
                const Text('※ 만 14세 미만 아동에 관한 개인정보의 열람등 요구는 법정대리인이 직접 해야 하며, 만 14세 이상의 미성년자인 정보주체는 정보주체의 개인정보에 관하여 미성년자 본인이 권리를 행사하거나 법정대리인을 통하여 권리를 행사할 수도 있습니다.'),
                const Text('② 권리 행사는 ❮오늘의 이야기❯에 대해 「개인정보 보호법」 시행령 제41조 제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며, ❮오늘의 이야기❯는 이에 대해 지체없이 조치하겠습니다.'),
                const Text('③ 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수도 있습니다.'),
                const Text('이 경우 "개인정보 처리 방법에 관한 고시(제2020-7호)" 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.'),
                const Text('④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.'),
                const Text('⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.'),
                const Text('이 경우 "개인정보 처리 방법에 관한 고시(제2020-7호)" 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.'),
                const Text(' ❮오늘의 이야기❯는 정보주체 권리에 따른 열람의 요구, 정정•삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.'),

                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '개인정보의 안전성 확보조치',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(' ❮오늘의 이야기❯는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.'),
                const Text('1. 관리적 조치 : 내부관리계획 수립• 시행'),
                const Text('2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 보안프로그램 설치 및 갱신'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '개인정보 자동 수집 장치의 설치 운영 및 거부에 관한 사항',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(' ❮오늘의 이야기❯는 모바일 앱에서 온라인 맞춤형 광고를 위하여 광고식별자를 수집•이용 합니다. 정보주체는 모바일 단말기의 설정 변경을 통해 앱의 맞춤형 광고를 차단·허용할 수 있습니다.'),
                const Text('(1) (안드로이드) ① 설정 - ② 개인정보보호- ③ 광고 - ③ 광고 ID 재설정 또는 광고ID 삭제'),
                const Text('(2) (아이폰) ① 설정 - ② 개인정보보호- ③ 추적 - ④ 앱이 추적을 요청하도록 허용 끔'),
                const Text('※ 모바일 OS 버전에 따라 메뉴 및 방법이 다소 상이할 수 있습니다.'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '개인정보 보호책임자',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text('① ❮오늘의 이야기❯는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.'),
                const Text('• 개인정보 보호책임자'),
                const Text('    성명: 박설아'),
                const Text('    연락처: seolaox89@gmail.com'),
                const Text('② 정보주체는 ❮오늘의 이야기❯의 서비스를 이용하시면서 발생한 모든 개인정보보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의할 수 있습니다. ❮오늘의 이야기❯는 정보주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다.'),
                const SizedBox(
                  height: 30,
                ),
                  const Text(
                  '개인정보 처리방침의 변경',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text('1. 본 개인정보처리방침의 내용 추가, 삭제 및 수정이 있을 경우 혹은 수집하는 개인정보의 항목, 이용목적의 변경 등과 같이 이용자 권리의 중대한 변경이 발생한 경우 필요 시 이용자 동의를 다시 받을 수도 있습니다.'),
                const Text('2. 본 개인정보 처리방침은 2023년 12월 18일부터 시행됩니다.'),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
