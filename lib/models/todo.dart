class ToDo{
  String text;
  bool done;
  ToDo({required this.text, this.done=false});


  factory ToDo.fromJson(Map<String, dynamic> json) =>
      ToDo(text: json['text'], done: json['done']);

  Map<String, dynamic> toJson() => {'text': text, 'done': done};
}
