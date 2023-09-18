import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TodoController extends GetxController {
  final searchEditingController = TextEditingController().obs;
  var todos = List<Todo>.empty().obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todo');
    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todo', todos.toList());
    });
    super.onInit();
  }

  final results = <Todo>[].obs;
  filterList(String searchText) {
    if (searchText.isEmpty) {
      results.value = todos;
    } else {
      results.value = todos
          .where((item) => item.text!.toLowerCase().contains(
                searchText.toLowerCase(),
              ))
          .toList();
    }
    return searchText;
  }

  varClear() {
    searchEditingController.value.clear();
  }
}
