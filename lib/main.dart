import 'package:flutter/material.dart';
import 'package:todo_list/screen/home_screen.dart';
import 'package:todo_list/screen/todo_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(context),
      child: GetMaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.id,
        getPages: [
          GetPage(
            name: TodoScreen.id,
            page: () => TodoScreen(),
          ),
          GetPage(
            name: HomeScreen.id,
            page: () => const HomeScreen(),
          ),
        ],
      ),
    );
  }

  // unfocus function
  void unFocus(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
