class Todo // start class name with capital letter
{
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone=false,
  });
  static List<Todo> todoList(){
    return[
      Todo(id:'01',todoText: 'Morning Exercise',isDone: true),
      Todo(id:'02',todoText: 'Doing Breakfast',isDone: true),
      Todo(id:'03',todoText: 'Studying',),
      Todo(id:'04',todoText: 'Doing Lunch'),
      Todo(id:'05',todoText: 'Playing ',),
      Todo(id:'06',todoText: 'Studying',),
      Todo(id:'07',todoText: 'Doing Homework',),
      Todo(id:'08',todoText: 'having Dinner',),
      Todo(id:'07',todoText: 'Sleeping',),

    ];
  }




}