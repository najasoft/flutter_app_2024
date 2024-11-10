import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_2024/model/produit.dart';
import 'package:flutter_app_2024/produit_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProduitBox extends StatelessWidget {
  final Produit produit;
  final bool selProduit;
  final Function(BuildContext context)? delProduit;
  final Function(bool?)? onChanged;

  const ProduitBox(
      {super.key,
      required this.produit,
      required this.selProduit,
      required this.delProduit,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: delProduit,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(45),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProduitDetails(produit: produit)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(45),
            ),
            height: 120,
            child: Row(
              children: [
                Checkbox(
                  value: selProduit,
                  onChanged: onChanged,
                ),
                Center(
                  child:
                      Image.file(width: 50, height: 50, File(produit.photo!)),
                ),
                const SizedBox(width: 10),
                Text(produit.libelle!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
