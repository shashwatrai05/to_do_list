import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/todo.dart';

class ToDoController extends GetxController {
  var todos = <ToDo>[].obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');

    if(!storedTodos.isNull){
      todos= RxList(storedTodos!.map((e) => ToDo.fromJson(e)).toList());
    }
  ever(todos, (callback) {
  GetStorage().write('todos',todos.toList());
  });
    super.onInit();
  }

 
}
