import 'package:flutter/material.dart';
import 'package:flutter_app_2024/add_produit.dart';
import 'package:flutter_app_2024/produit_box.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  // Suppression d'un produit

  final List liste = [
    ["1 Produit", false],
    ["2 Produit", true],
    ["3 Produit", false],
    ["4 Produit", false],
    ["5 Produit", false],
  ];

  void delProduit(int index) {
    setState(() {
      liste.removeAt(index);
    });
  }

  // Décalaration du contrpoleur de texte
  final nomController = TextEditingController();

  void onChanged(bool? value, int index) {
    setState(() {
      liste[index][1] = value;
    });
  }

  void saveProduit() {
    setState(() {
      liste.add([nomController.text, false]);
      nomController.clear(); // Efface le contenu du champ de texte
      Navigator.of(context).pop(); //Ferme la boîte de dialogue
    });
  }

  void addProduit() {
    showDialog(
        context: context,
        builder: (context) {
          return AddProduit(
            nomController: nomController,
            onAdd: saveProduit,
            onCancel: () {
              Navigator.pop(context);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produits"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduit,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: (context, index) {
            return ProduitBox(
              nomProduit: liste[index][0],
              selProduit: liste[index][1],
              onChanged: (value) => onChanged(value, index),
              delProduit: (context) => delProduit(index),
            );
          }),
    );
  }
}
