import 'package:flutter/material.dart';
import 'package:flutter_app_2024/add_produit_form.dart';
import 'package:flutter_app_2024/model/produit.dart';
import 'package:flutter_app_2024/produit_box.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  // Suppression d'un produit

  final List liste = [];

  void delProduit(int index) {
    setState(() {
      liste.removeAt(index);
    });
  }

  void saveProduit(Produit produit) {
    setState(() {
      liste.add([produit, false]);
    });
  }

  // Décalaration du contrpoleur de texte
  final nomController = TextEditingController();

  void onChanged(bool? value, int index) {
    setState(() {
      liste[index][1] = value;
    });
  }

  // Liste manuelle des fichiers (à ajuster selon vos images)
  final List<String> imagePaths = [
    'assets/images/adidas1.png',
    'assets/images/birkenstock1.png',
    'assets/images/convers1.png',
    'assets/images/nike1.png',
    'assets/images/new_balance1.png',
    // Ajoutez d'autres fichiers ici si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Produits"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduitForm(
                onSubmit: saveProduit,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: (context, index) {
            return ProduitBox(
              produit: liste[index][0],
              selProduit: liste[index][1],
              onChanged: (value) => onChanged(value, index),
              delProduit: (context) => delProduit(index),
            );
          }),
    );
  }
}
