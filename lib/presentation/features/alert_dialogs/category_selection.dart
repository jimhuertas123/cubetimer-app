import 'dart:io';

import 'package:cube_timer_2/presentation/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/models/models.dart';

class CategorySelection extends ConsumerWidget {
  final List<CategoryModel> categories;
  final int? selectedCategoryId;

  const CategorySelection({super.key, required this.categories, this.selectedCategoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isIOS = Platform.isIOS;

    return Column(
      children: categories
          .map((category) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isIOS ? CupertinoColors.extraLightBackgroundGray : Colors.transparent,
                shadowColor: Colors.transparent,
                overlayColor: isIOS ? null : Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: isIOS ? BorderRadius.circular(10) : BorderRadius.circular(0),
                  side: BorderSide(
                    color: Colors.transparent,
                    width: 0.1,
                  ),
                ),
              ),
              onPressed: () {
                ref
                    .read(categoryProvider.notifier)
                    .setActualCategory(category.id!);
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 20),
                  Icon(
                    isIOS 
                      ? CupertinoIcons.tag
                      : Icons.label_outline,
                    size: isIOS ? 20 : 25,
                    color: Colors.black38,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      categories.isNotEmpty
                          ? category.name.length > 22
                              ? '${category.name.substring(0, 22)}...'
                              : category.name
                          : 'No categories available (This must be a error loading categories)',
                      style: isIOS ? null : const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  selectedCategoryId == category.id ? Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeBlue,) : const SizedBox.shrink(),
                  SizedBox(width: 15)
                ],
              )))
          .toList(),
    );
  }
}
