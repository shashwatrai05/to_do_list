import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../screens/todoscreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ToDoController todoController = Get.put(ToDoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(ToDoScreen());
        },
      ),
      body: Obx(() => ListView.separated(
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            var removed = todoController.todos[index];
            todoController.todos.removeAt(index);
            Get.snackbar('Task removed',
                'The task "${removed.text}" was successfully removed.',
                mainButton: TextButton(
                  child: const Text('Undo'),
                  onPressed: () {
                    if (removed.isNull) {
                      return;
                    }
                    todoController.todos.insert(index, removed);
                    if (Get.isSnackbarOpen) {
                      Get.back();
                    }
                  },
                ));
          },
          child: ListTile(
            title: Text(
              todoController.todos[index].text,
              style: (todoController.todos[index].done)
                  ? const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    )
                  : TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
            ),
            onTap: () {
              Get.to(ToDoScreen(
                index: index,
              ));
            },
            leading: Checkbox(
              value: todoController.todos[index].done,
              onChanged: (v) {
                var changed = todoController.todos[index];
                changed.done = v!;
                todoController.todos[index] = changed;
              },
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        separatorBuilder: (_, __) => const Divider(height: 5,),
        itemCount: todoController.todos.length,
      )),
    );
  }
}
