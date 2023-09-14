import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_controller.dart';
import 'package:todo_list/screen/edit_todo.dart';
import 'package:todo_list/screen/todo_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/Home_screen';
  // final TodoController todoController = Get.put(TodoController());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TodoController(),
      initState: (state) {
        state.controller?.update();
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          centerTitle: true,
        ),
        floatingActionButton:
            controller.searchEditingController.value.text.isEmpty
                ? FloatingActionButton(
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.toNamed(TodoScreen.id);
                      controller.varClear();
                    },
                  )
                : null,
        body: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.7,
                  color: Colors.grey.withOpacity(0.7),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TextField(
                controller: controller.searchEditingController.value,
                onChanged: (value) {
                  controller.filterList(value);
                  controller.update();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 20.0,
                    minWidth: 25.0,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
            ),
            Expanded(
              child: controller.searchEditingController.value.text.isEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.deepOrange,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (_) {
                          controller.todos.removeAt(index);
                          Get.snackbar(
                              'Removed', " Task was succesfully deleted!",
                              snackPosition: SnackPosition.TOP);
                        },
                        child: ListTile(
                          title: Text(
                            controller.todos[index].text!,
                            style: controller.todos[index].done
                                ? const TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  )
                                : const TextStyle(
                                    color: Colors.black,
                                  ),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.todos.removeAt(index);
                                  Get.snackbar("Removed!",
                                      "Task was succesfully deleted!",
                                      snackPosition: SnackPosition.TOP);
                                  controller.update();
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    Get.to(() => TodoEdit(index: index)),
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                          leading: Checkbox(
                            value: controller.todos[index].done,
                            onChanged: (neWvalue) {
                              var todo = controller.todos[index];
                              todo.done = neWvalue!;
                              controller.todos[index] = todo;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      itemCount: controller.todos.length,
                    )
                  : controller.results.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) => Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.deepOrange,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              controller.todos.removeAt(index);
                              Get.snackbar(
                                  'Removed!', "Task was succesfully deleted!",
                                  snackPosition: SnackPosition.TOP);
                            },
                            child: ListTile(
                              title: Text(
                                controller.results[index].text!,
                                style: controller.results[index].done
                                    ? const TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : const TextStyle(
                                        color: Colors.black,
                                      ),
                              ),
                              trailing: IconButton(
                                onPressed: () =>
                                    Get.to(() => TodoEdit(index: index)),
                                icon: const Icon(Icons.edit),
                              ),
                              leading: Checkbox(
                                value: controller.results[index].done,
                                onChanged: (neWvalue) {
                                  var todo = controller.results[index];
                                  todo.done = neWvalue!;
                                  controller.results[index] = todo;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                          itemCount: controller.results.length,
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: context.width / 3,
                              width: context.height / 3,
                              child: const Image(
                                image: AssetImage("assets/cross.png"),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                'No Results Found!',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                height: context.height * 0.06,
                                width: context.width,
                                child: CupertinoButton(
                                  color: Colors.deepPurple,
                                  onPressed: () {
                                    Get.toNamed(TodoScreen.id);
                                  },
                                  child: const Text('Creaet New One'),
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
