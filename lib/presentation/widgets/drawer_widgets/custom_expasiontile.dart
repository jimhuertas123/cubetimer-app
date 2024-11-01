import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.title,
    required this.children,
    this.leading,
    this.trailing,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final Widget? leading;
  final Widget? trailing;
  final ValueChanged<bool>? onExpansionChanged;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(initiallyExpanded);
        onExpansionChanged?.call(!initiallyExpanded);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 16.0),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (initiallyExpanded) ...children,
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 16.0),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
