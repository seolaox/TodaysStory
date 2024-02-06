import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'components/customcheckbox.dart';
import 'model/datehandler.dart';
import 'model/memopad.dart';
import 'model/todolist.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController memoController;
  late TextEditingController memoModifyController;
  late TextEditingController todoController;
  late TextEditingController todoModiftController;
  late TabController _tabController;
  late DatabaseHandler handler;

  // late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    // scrollController = ScrollController();

    memoController = TextEditingController();
    memoModifyController = TextEditingController();
    todoController = TextEditingController();
    todoModiftController = TextEditingController();
    handler = DatabaseHandler();
    handler.initializeMemoPadDB();
    handler.initializeTodoListDB();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // // 탭 변경을 처리하는 함수
  // void _handleTabChange() {
  //   if (_tabController.index == 0) {
  //     // Memo 탭에서 실행되는 동작
  //     insertBottomSheet();
  //   } else if (_tabController.index == 1) {
  //     // ToDoList 탭에서 실행되는 동작
  //     insertToDoBottomSheet();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          bottom: TabBar(controller: _tabController, tabs: const [
            Tab(
              icon: Icon(Icons.my_library_books),
              text: "Memo",
            ),
            Tab(
              icon: Icon(Icons.check_box_outlined),
              // icon: Icon(Icons.format_list_bulleted),
              text: "TodoList",
            ),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(
              child: FutureBuilder(
                future: handler.queryMemoPad(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MemoPad>> snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data!.sort((a, b) {
                      // memoinsertdate를 기준으로 내림차순으로 정렬
                      final aDate = a.memoinsertdate;
                      final bDate = b.memoinsertdate;

                      if (aDate != null && bDate != null) {
                        return bDate.compareTo(aDate);
                      } else {
                        return 0;
                      }
                    });

                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const BehindMotion(), //
                              children: [
                                SlidableAction(
                                  //버튼 눌렀을때 action
                                  backgroundColor:
                                      const Color.fromARGB(255, 190, 201, 244),
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  onPressed: (context) {
                                    updateBottomSheet(snapshot.data![index]);
                                  },
                                )
                              ]),
                          endActionPane: ActionPane(
                              motion: const BehindMotion(), //
                              children: [
                                SlidableAction(
                                  //버튼 눌렀을때 action
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 158, 151),
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (context) async {
                                    await handler.deleteMemoPad(
                                        snapshot.data![index].id!);
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                    setState(() {});
                                  },
                                ),
                              ]),
                          child: GestureDetector(
                            onTap: () {
                              updateBottomSheet(snapshot.data![index]);
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(20, 20))),
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Row(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 2),
                                      child: Text(
                                        snapshot.data![index].memoinsertdate !=
                                                null
                                            ? DateFormat('yyyy-MM-dd').format(
                                                snapshot.data![index]
                                                    .memoinsertdate!)
                                            : 'No Date',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 7),
                                      child: Text(
                                        snapshot.data![index].memo,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        maxLines:
                                            1, // 한 줄을 초과하면 말줄임표(ellipsis)를 표시
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
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              //memopad END
            ),
            Center(
              child: FutureBuilder(
                future: handler.queryTodoList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TodoList>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const BehindMotion(), //
                              children: [
                                SlidableAction(
                                  //버튼 눌렀을때 action
                                  backgroundColor:
                                      const Color.fromARGB(255, 190, 201, 244),
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  onPressed: (context) {
                                    updateTodoBottomSheet(
                                        snapshot.data![index]);
                                  },
                                )
                              ]),
                          endActionPane: ActionPane(
                              motion: const BehindMotion(), //
                              children: [
                                SlidableAction(
                                  //버튼 눌렀을때 action
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 158, 151),
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (context) async {
                                    await handler.deleteTodoList(
                                        snapshot.data![index].id!);
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                    setState(() {});
                                  },
                                ),
                              ]),
                          child: GestureDetector(
                            onTap: () {
                              updateTodoBottomSheet(snapshot.data![index]);
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(20, 20))),
                              child: SizedBox(
                                height: 80,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Text(
                                            snapshot.data![index].todoinsertdate !=
                                                    null
                                                ? DateFormat('yyyy-MM-dd').format(
                                                    snapshot
                                                        .data![index].todoinsertdate!)
                                                : 'No Date',
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 7),
                                          child: Text(
                                                      snapshot.data![index].todo,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                              
                                                      maxLines:
                                                          1, // 한 줄을 초과하면 말줄임표(ellipsis)를 표시
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: CustomCheckbox(
                                            value:
                                                snapshot.data![index].isChecked ==
                                                        1
                                                    ? true
                                                    : false,
                                            onChanged: (value) async {
                                              TodoList updatedTodo = TodoList(
                                                  todo:
                                                      snapshot.data![index].todo,
                                                  isChecked:
                                                      value == true ? 1 : 0,
                                                  id: snapshot.data![index].id);
                                              await handler
                                                  .updateTodoList(updatedTodo);
                                              reloadData();
                                            },
                                          ),
                                        )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator(); // 혹은 다른 로딩 인디케이터를 여기에 추가할 수 있습니다.
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_tabController.index == 0) {
              insertBottomSheet();
            } else if (_tabController.index == 1) {
              insertToDoBottomSheet();
            }
          },
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  //---Function-------------------------------------------------------------------------------

  reloadData() {
    handler.queryMemoPad();
    handler.queryTodoList();
    setState(() {});
  }

  insertBottomSheet() {
    Get.bottomSheet(
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 380,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '- MEMO -',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextField(
                      controller: memoController,
                      decoration: const InputDecoration(
                        hintText: '내용을 입력해 주세요. ',
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
                      maxLines: 8,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(memoController.text.isEmpty){
                        Get.snackbar(
                            "ERROR",
                            "내용을 입력해 주세요.",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                            colorText: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 248, 201, 168),);

                      }else{
                      insertAction()!.then((value) => reloadData());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor: const Color.fromARGB(255, 151, 161, 252),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "입력",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 234, 234, 236),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isScrollControlled: true //오버플로우 방지
        );
    memoController.clear();
  }

  insertAction() async {
    //순서가 필요할때 무조건 async
    String memo = memoController.text;

    var memoInsert = MemoPad(memo: memo, memoinsertdate: DateTime.now());

    await handler.insertMemoPad(memoInsert);
    Get.back();
    Get.back();
  }

  updateBottomSheet(MemoPad memo) {
    memoModifyController.text = memo.memo;
    Get.bottomSheet(
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '- MEMO -',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TextField(
                    controller: memoModifyController,
                    decoration: const InputDecoration(
                      hintText: '내용을 입력해 주세요. ',
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
                    maxLines: 8,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(memoModifyController.text.isEmpty){
                        Get.snackbar(
                            "ERROR",
                            "내용을 입력해 주세요.",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                            colorText: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 248, 201, 168),);

                      }else{
                      updateAction(memo.id!)!.then((value) => reloadData());
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: const Color.fromARGB(255, 151, 161, 252),
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
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true, //오버플로우 방지
    );

    memoController.clear();
  }

  /// vm
  updateAction(int memoId) async {
    //순서가 필요할때 무조건 async
    String memo = memoModifyController.text;
    var memoUpdate =
        MemoPad(id: memoId, memo: memo, memoinsertdate: DateTime.now());
    await handler.updateMemoPad(memoUpdate);
    Get.back();
    Get.back();
  }

  insertToDoBottomSheet() {
    Get.bottomSheet(
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '- TodoList -',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TextField(
                    controller: todoController,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      hintText: '내용을 입력해 주세요. ',
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
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(todoController.text.isEmpty){
                        Get.snackbar(
                            "ERROR",
                            "내용을 입력해 주세요.",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                            colorText: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 248, 201, 168),);

                      }else{
                      insertTodoAction()!.then((value) => reloadData());
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: const Color.fromARGB(255, 151, 161, 252),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "입력",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 236),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true, // 오버플로우 방지
    );
    todoController.clear();
  }

  /// vm
  insertTodoAction() async {
    //순서가 필요할때 무조건 async
    String todo = todoController.text;

    var todoInsert = TodoList(todo: todo, isChecked: 0);

    await handler.insertTodoList(todoInsert);
    // view
    Get.back();
    Get.back();
  }

  /// Widget
  updateTodoBottomSheet(TodoList todo) {
    todoModiftController.text = todo.todo;
    Get.bottomSheet(
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '- TodoList -',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TextField(
                    controller: todoModiftController,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      hintText: '내용을 입력해 주세요. ',
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
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(todoModiftController.text.isEmpty){
                        Get.snackbar(
                            "ERROR",
                            "내용을 입력해 주세요.",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                            colorText: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 248, 201, 168),);

                      }else{
                      updateTodoAction(todo.id!)!.then((value) => reloadData());
                      }
                    
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: const Color.fromARGB(255, 151, 161, 252),
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
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true, //오버플로우 방지
    );

    todoController.clear();
  }

  /// vm5
  updateTodoAction(int todoId) async {
    String todo = todoModiftController.text;
    // bool isChecked = todo.isNotEmpty; // 내용이 비어있지 않으면 true로 설정

    var todoUpdate =
        TodoList(id: todoId, todo: todo, isChecked: todo.isNotEmpty ? 1 : 0);
    await handler.updateTodoList(todoUpdate);
    // view
    Get.back();
    Get.back();
  }
} //END
