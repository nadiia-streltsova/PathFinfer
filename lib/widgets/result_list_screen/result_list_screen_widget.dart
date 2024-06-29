import 'package:flutter/material.dart';
import 'package:pathfinder/widgets/result_list_screen/result_list_screen_view_model.dart';
import 'package:provider/provider.dart';

class ResultListScreenWidget extends StatelessWidget {
  const ResultListScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ResultListScreenViewModel>();
    final solutionsList = model.solutionsList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result list screen"),
      ),
      body: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: solutionsList.length,
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
              onPressed: () => {model.showResult(context, index)},
              child: Text(
                "${solutionsList[index].steps}",
              ));
        }, separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
