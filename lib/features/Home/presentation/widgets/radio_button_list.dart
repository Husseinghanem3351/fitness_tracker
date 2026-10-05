import 'package:flutter/material.dart';

class RadioButtonList extends StatefulWidget {
  const RadioButtonList({
    super.key,
    required this.items,
    required this.onChanged,
    this.subItems,
    required this.selectedOption,
  });

  final List<String> items;
  final List<String>? subItems;
  final void Function(String?)? onChanged;
  final int selectedOption;

  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  late int currentOption;

  @override
  void initState() {
    super.initState();
    currentOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ...List.generate(
            widget.items.length,
            (index) => buttonItem(
                  widget.items[index],
                  index,
                  subTitle: widget.subItems?[index],
                )),
      ],
    );
  }

  Widget buttonItem(String name, int value, {String? subTitle}) =>
      RadioListTile<int>(
        subtitle: subTitle != null
            ? Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall,
              )
            : null,
        title: Text(name, style: Theme.of(context).textTheme.bodyMedium),
        value: value,
        groupValue: currentOption,
        onChanged: (val) {
          if (val != null) {
            setState(() {
              currentOption = val;
            });
            widget.onChanged?.call(widget.items[val]);
          }
        },
      );
}
