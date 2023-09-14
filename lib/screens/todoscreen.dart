import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';
import 'package:get/get.dart';
import '../models/todo.dart';

class ToDoScreen extends StatelessWidget {
  final ToDoController todoController = Get.find();
  final int? index;

  ToDoScreen({this.index});


  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!index.isNull) {
      text = todoController.todos[index!].text;
    }
    TextEditingController textEditingController;

    if (text.isEmpty) {
      textEditingController = TextEditingController();
    } else {
      textEditingController = TextEditingController(text: text);
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'What do you want to accomplish?',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 25.0,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                ElevatedButton(
                  child: Text((index.isNull) ? 'Add' : 'Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (index.isNull) {
                      todoController.todos.add(ToDo(text: textEditingController.text));
                    } else {
                     
                      var editing = todoController.todos[index!];
                      editing.text = textEditingController.text;
                      todoController.todos[index!] = editing;
                    }
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
