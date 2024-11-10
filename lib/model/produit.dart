class Produit {
  String? id;
  String? libelle;
  String? description;
  double? prix;
  String? photo;
  Produit({
    this.id,
    this.libelle,
    this.description,
    this.prix,
    this.photo,
  });
  Produit.empty()
      : id = '',
        libelle = '',
        description = '',
        prix = 0,
        photo = '';
}
