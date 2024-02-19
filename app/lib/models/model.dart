class Todo {
  late String task;
  late bool compeleted;

  Todo({required this.task, required this.compeleted});

  Todo.fromJson(Map<String, dynamic> json) {
    task=json['task'];
    compeleted=json['compeleted'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['completed'] = compeleted;
    return data;
  }
}
