import 'package:flutter/material.dart';
import 'package:pathfinder/finder/cell_item.dart';
import 'package:pathfinder/widgets/preview_screen/preview_screen_view_model.dart';
import 'package:provider/provider.dart';

class PreviewScreenWidget extends StatelessWidget {
  const PreviewScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<PreviewScreenViewModel>();
    final field = model.solutionData.field;
    final pathString = model.solutionData.pathString;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Result list screen"),
        ),
        body: Column(
          children: [
            ...field.map((e) => Row(
                  children: [...e.map((e2) => drawElement(e2))],
                )),
            Text(pathString, style: const TextStyle(fontSize: 20),),
          ],
        ));
  }

  Widget drawElement(CellItem item) {
    Color color;
    switch (item.type) {
      case CellType.start:
        color = const Color(0xff64FFDA);
      case CellType.end:
        color = const Color(0xff009688);
      case CellType.onPath:
        color = const Color(0xff4CAF50);
      case CellType.blocked:
        color = const Color(0xff000000);
      case CellType.empty:
        color = const Color(0xffffffff);
    }

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: color,
          ),
          child: Text(
            "(${item.position.x}, ${item.position.y})",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
