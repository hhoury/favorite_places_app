import 'dart:io';

import 'package:favorite_places_app/providers/user_places.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const LocationInput(),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add Place'),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
