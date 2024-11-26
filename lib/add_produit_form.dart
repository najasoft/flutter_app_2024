import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_2024/dao/produit_dao.dart';
import 'package:flutter_app_2024/data/base.dart';
import 'package:image_picker/image_picker.dart';

class AddProduitForm extends StatefulWidget {
  final ProduitDAO produitDAO;
  const AddProduitForm({super.key, required this.produitDAO});

  @override
  State<AddProduitForm> createState() => _AddProduitFormState();
}

class _AddProduitFormState extends State<AddProduitForm> {
  final _formKey = GlobalKey<FormState>();
  double? _prix;
  String? _libelle;
  String? _description;

  String? _pickedImagePath;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _pickedImagePath = pickedFile.path;
    });
  }

  void _saveProduit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final photo = _pickedImagePath;

      widget.produitDAO.insertProduit(ProduitsCompanion.insert(
          libelle: _libelle!,
          description: _description!,
          prix: _prix!,
          photo: photo!));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Ajouter un produit')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Libellé:'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir le libellé';
                    }
                    return null;
                  },
                  onSaved: (value) => _libelle = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir la description';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Prix'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Veuillez saisir le prix';
                    }
                    return null;
                  },
                  onSaved: (value) => _prix = double.parse(value!),
                ),
                GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        color: Theme.of(context).primaryColorLight,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _pickedImagePath != null
                              ? FileImage(File(_pickedImagePath!))
                                  as ImageProvider<Object>
                              : const AssetImage(
                                  'assets/images/placeholder.jpg'),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            _formKey.currentState!.reset();
                            setState(() {
                              _pickedImagePath = null;
                            });
                          },
                          icon: const Icon(Icons.restore_from_trash_rounded),
                          label: const Text('Réinitialiser')),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveProduit();
                          }
                        },
                        child: const Text('Enregistrer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
