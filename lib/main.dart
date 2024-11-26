import 'package:flutter/material.dart';
import 'package:flutter_app_2024/dao/produit_dao.dart';
import 'package:flutter_app_2024/data/base.dart';
import 'package:flutter_app_2024/produits_list.dart';

void main() {
  final database = ProduitsDatabase();
  final produitDAO = ProduitDAO(database);
  runApp(MainApp(
    produitDAO: produitDAO,
  ));
}

class MainApp extends StatelessWidget {
  final ProduitDAO produitDAO;
  const MainApp({super.key, required this.produitDAO});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProduitsList(produitDAO: produitDAO));
  }
}
