import 'dart:io';
import 'package:flutter/material.dart';
import 'model/produit.dart';
import 'package:image_picker/image_picker.dart';

class AddProduitForm extends StatefulWidget {
  final Function(Produit) onSubmit;

  const AddProduitForm({super.key, required this.onSubmit});

  @override
  State<AddProduitForm> createState() => _AddProduitFormState();
}

class _AddProduitFormState extends State<AddProduitForm> {
  final _formKey = GlobalKey<FormState>();
  final _produit = Produit.empty();
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
      _produit.photo = _pickedImagePath;
      _produit.id = DateTime.now().millisecondsSinceEpoch.toString();
      widget.onSubmit(_produit);
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
                onSaved: (value) => _produit.libelle = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir la description';
                  }
                  return null;
                },
                onSaved: (value) => _produit.description = value,
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
                onSaved: (value) => _produit.prix = double.parse(value!),
              ),
              GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _pickedImagePath != null
                            ? FileImage(File(_pickedImagePath!))
                                as ImageProvider<Object>
                            : const AssetImage('assets/images/placeholder.jpg'),
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
    );
  }
}
