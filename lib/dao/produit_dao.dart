import 'package:drift/drift.dart';
import 'package:flutter_app_2024/data/base.dart';

@DriftAccessor(tables: [Produits])
class ProduitDAO extends DatabaseAccessor<ProduitsDatabase> {
  ProduitDAO(super.attachedDatabase);

  /// Insère un nouveau produit dans la base de données.
  Future<void> insertProduit(ProduitsCompanion produit) =>
      into(attachedDatabase.produits).insert(produit);

  /// Récupère tous les produits de la base de données.
  Future<List<Produit>> getAllProduits() =>
      select(attachedDatabase.produits).get();

  /// Fournit un flux de tous les produits de la base de données.
  Stream<List<Produit>> getProduitsStream() =>
      select(attachedDatabase.produits).watch();

  /// Met à jour un produit existant dans la base de données.
  Future<bool> updateProduit(ProduitsCompanion produit) =>
      update(attachedDatabase.produits).replace(produit);

  /// Supprime un produit de la base de données par son identifiant.
  Future<int> deleteProduitBuId(int id) =>
      (delete(attachedDatabase.produits)..where((p) => p.id.equals(id))).go();

  /// Récupère un produit de la base de données par son identifiant.
  Future<Produit> getProduitById(int id) =>
      (select(attachedDatabase.produits)..where((p) => p.id.equals(id)))
          .getSingle();
}
