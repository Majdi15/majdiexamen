// lib/widgets/item_card.dart
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/database_service.dart';
import '../screens/add_edit_item_screen.dart';


class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item, required void Function() onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEditItemScreen(item: item)),
                );
              },
            ),
   
IconButton(
  icon: const Icon(Icons.delete),
  onPressed: () async {
    await DatabaseService().deleteItem(item.id!);
    // Refresh the screen after deletion
    setState(() {}); // This will trigger a rebuild of the widget tree
  },
),


          ],
        ),
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}
