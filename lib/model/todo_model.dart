class TodoModel {
  String? id;
  String? todo;
  bool? done;

  TodoModel({
    this.id,
    this.todo,
    this.done,
  });

  TodoModel copyWith({
    String? id,
    String? todo,
    bool? done,
  }) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'done': done,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String?,
      todo: json['todo'] as String?,
      done: json['done'] as bool?,
    );
  }

  @override
  String toString() => "TodoModel(id: $id,todo: $todo,done: $done)";

  @override
  int get hashCode => Object.hash(id, todo, done);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          todo == other.todo &&
          done == other.done;
}
