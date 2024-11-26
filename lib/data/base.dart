// La table produits
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'base.g.dart';

@DataClassName("Produit")
class Produits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get libelle => text().withLength(min: 2, max: 120)();
  TextColumn get description => text()();
  // Prix doit être un double
  RealColumn get prix => real()();
  TextColumn get photo => text()();
}

@DriftDatabase(tables: [Produits])
class ProduitsDatabase extends _$ProduitsDatabase {
  ProduitsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'produits.db'));
    return NativeDatabase.createInBackground(file);
  });
}
