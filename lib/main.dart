import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'features/receipe/presentation/providers/recipe_provider.dart';


import 'features/receipe/presentation/screens/login_view.dart';
import 'features/receipe/presentation/screens/recipe_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<bool>('favorites'); // Open favorites box
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider()..fetchRecipes(),
      child: MaterialApp(
        title: 'My Recipe App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (_) => LoginScreen(),
          '/recipeList': (_) => RecipeListScreen(),
        },
      ),
    );
  }
}
