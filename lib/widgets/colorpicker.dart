import 'package:flutter/material.dart';

import '../FB/procolor.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.themeData,
  });

  final Colorchange themeData;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4),
        itemCount: widget.themeData.listofcolors.length,
        itemBuilder: (context, index) {
          bool isSelected = index == widget.themeData.selectdIndex;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  final selIndex = index;
                  widget.themeData.setIndex(selIndex);
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent),
                  borderRadius: BorderRadius.circular(150),
                  color: widget.themeData.listofcolors[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
