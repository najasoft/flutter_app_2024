import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_2024/dao/produit_dao.dart';
import 'package:flutter_app_2024/data/base.dart';
import 'package:flutter_app_2024/produit_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProduitBox extends StatelessWidget {
  final Produit produit;
  final ProduitDAO produitDAO;

  const ProduitBox({
    super.key,
    required this.produit,
    required this.produitDAO,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => produitDAO.deleteProduitBuId(produit.id),
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
                const SizedBox(width: 10),
                Center(
                  child:
                      Image.file(width: 100, height: 100, File(produit.photo)),
                ),
                const SizedBox(width: 10),
                Text(produit.libelle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
