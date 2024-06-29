import 'package:flutter/material.dart';
import 'package:pathfinder/widgets/process_screen/process_screen_view_model.dart';
import 'package:provider/provider.dart';

class ProcessScreenWidget extends StatefulWidget {
  const ProcessScreenWidget({Key? key}) : super(key: key);

  @override
  State<ProcessScreenWidget> createState() => _ProcessScreenWidgetState();
}

class _ProcessScreenWidgetState extends State<ProcessScreenWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProcessScreenViewModel>().startProcess(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProcessScreenViewModel>();
    int statusPercent = context.select((ProcessScreenViewModel model) => model.progressValue);
    bool isCompleted = context.select((ProcessScreenViewModel model) => model.isCompleted);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Process screen"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 70,
                  child: isCompleted
                      ? const Text(
                          "All calculations has finished, you can send your results to server",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox.shrink(),
                ),
                Text("$statusPercent%", style: const TextStyle(fontSize: 24)),
                Container(color: Colors.grey, width: double.infinity, height: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: !isCompleted
                        ? const CircularProgressIndicator(color: Colors.lightBlue)
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => isCompleted ? {model.sendResultsToServer(context)} : {},
              child: isCompleted ? const Text("Send results to server") : const Text("In progress, please wait..."),
            ),
          ),
        ],
      ),
    );
  }
}
