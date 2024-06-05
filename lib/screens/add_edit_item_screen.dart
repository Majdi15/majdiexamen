import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/database_service.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;
  const AddEditItemScreen({Key? key, this.item}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddEditItemScreenState createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item == null ? 'Ajouter un élément' : 'Modifier l\'élément')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.item?.name ?? '',
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: widget.item?.description ?? '',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.item == null) {
                      DatabaseService().insertItem(Item(name: _name, description: _description));
                    } else {
                      DatabaseService().updateItem(Item(id: widget.item!.id, name: _name, description: _description));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.item == null ? 'Ajouter' : 'Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
