import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OLLAlgorithmBody extends ConsumerWidget {
  const OLLAlgorithmBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Oll Algorithm Body');
    return  Container(
      color: Colors.transparent,
      child: const Center(
          child: Text('OLL Algorithm BodyContent'),
      ),
    );
  }
}