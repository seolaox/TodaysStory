
class TodoList {
  final int? id;
  final String todo;
  final int isChecked;
  final DateTime? todoinsertdate; 

  TodoList({
    this.id,
    required this.todo,
    required this.isChecked,
    this.todoinsertdate,
  });

    // copyWith 메서드
  TodoList copyWith({
    int? id,
    String? todo,
    int? isChecked,
    DateTime? todoinsertdate,
  }) {
    return TodoList(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      isChecked: isChecked ?? this.isChecked,
      todoinsertdate: todoinsertdate ?? this.todoinsertdate,
    );
  }


  TodoList.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        todo = res['todo'],
        isChecked = res['isChecked'],
        todoinsertdate = res['todoinsertdate'] != null ? DateTime.parse(res['todoinsertdate']) : null;

}