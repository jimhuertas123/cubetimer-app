import 'package:cube_timer_2/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/models/models.dart';

class CategorySelection extends ConsumerWidget {
  
  final List<CategoryModel> categories;

  const CategorySelection({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: categories.map((category) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          overlayColor: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
              color: Colors.transparent,
              width: 0.1,
            ),
          ),
        ),
        onPressed: () { 
          ref.read(categoryProvider.notifier).setActualCategory(category.id!);
          Navigator.of(context).pop();
        },
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20),
            const Icon(Icons.label_outlined, size: 25, color: Colors.black38,),
            const SizedBox(width: 20),
            Text(
              overflow: TextOverflow.ellipsis,
              categories.isNotEmpty
                  ? category.name.length > 22
                    ? '${category.name.substring(0, 22)}...'
                    : category.name
                  : 'No categories available (This must be a error loading categories)',
              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ],
        )
      )).toList(),
    );
  }
}
