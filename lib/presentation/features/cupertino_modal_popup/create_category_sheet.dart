import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../database/models/models.dart';
import '../../../database/repositories/repositories.dart';
import '../../providers/providers.dart';

void showCustomModal(BuildContext context, String title, Widget content) {
  showCupertinoModalBottomSheet(
      context: context,
      isDismissible: true,
      expand: false,
      bounce: true,
      // backgroundColor: CupertinoColors.destructiveRed,
      animationCurve: Curves.easeInOut,
      builder: (context) {
        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          navigationBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.only(top: 10, start: 20, end: 20),
            middle: Text(title),
            leading: const SizedBox.shrink(),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                CupertinoIcons.clear_circled_solid,
                color: CupertinoColors.activeBlue,
                size: 25,
              ),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 25,
                  ),
                  child: content),
            ),
          ),
        );
      });
}

class IOSNewCategoryContent extends ConsumerStatefulWidget {
  const IOSNewCategoryContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IOSNewCategoryContentState();
}

class _IOSNewCategoryContentState extends ConsumerState<IOSNewCategoryContent> {
  final TextEditingController _textController = TextEditingController();
  int _actualLength = 0;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _actualLength = _textController.text.length;
      });
      if (_textController.text.length > 32) {
        _textController.text = _textController.text.substring(0, 32);
        _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            CupertinoTextField(
              controller: _textController,
              placeholder: 'Enter category name',
              maxLength: 32,
              maxLines: 1,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_textController.text.isNotEmpty)
              Positioned(
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _textController.clear();
                    });
                  },
                  child: const Icon(
                    CupertinoIcons.clear_circled,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: _actualLength / 32,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: CupertinoColors.systemGrey4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        _actualLength != 32
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.systemRed),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$_actualLength/32',
              style: TextStyle(
                color: _actualLength != 32
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.systemRed,
                decoration: TextDecoration.none,
                fontFamily: 'Arial',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: CupertinoButton(
            alignment: Alignment.center,
            color: CupertinoColors.activeBlue,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            onPressed: () async {
              if (_textController.text.isEmpty) {
                return;
              }

              final CubeTypeModel currentCubeType =
                  ref.read(cubeTypeProvider).actualCubeType;
              final dbHelper = CategoryRepository();
              final CategoryModel newCategory = CategoryModel(
                name: _textController.text,
                cubeTypeId: currentCubeType.id,
              );
              await dbHelper.insertCategory(newCategory);
              
              // ignore: unused_result
              ref.refresh(categoryFutureProvider);

              if (mounted){
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Create',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
