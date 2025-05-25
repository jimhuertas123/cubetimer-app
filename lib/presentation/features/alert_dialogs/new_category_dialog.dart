import 'package:cube_timer_2/presentation/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/models/models.dart';
import '../../../database/repositories/repositories.dart';
import '../../providers/providers.dart';

class AndroidNewCategoryAlertDialog extends ConsumerStatefulWidget {
  const AndroidNewCategoryAlertDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AndroidNewCategoryAlertDialogState();
}

class _AndroidNewCategoryAlertDialogState
    extends ConsumerState<AndroidNewCategoryAlertDialog> {
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
    return CustomAlertDialog(
      enableHeight: false,
      tittleContent: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text("Enter category name",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      fontTittleSize: 24.0,
      context: context,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      contentPadding:
          const EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
      content: <Widget>[
        SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _textController,
                    cursorColor: Colors.green,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter category name',
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: "Arial",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 10),
            Text(
              _actualLength.toString(),
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '/32',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 23),
          ],
        )
      ],
      actions: [
        TextButton(
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

            if(mounted) {
              Navigator.of(context).pop();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
