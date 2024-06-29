import 'package:flutter/material.dart';
import 'package:pathfinder/widgets/home_screen/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeScreenViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Set valid Api base URL in order to continue"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Icon(Icons.compare_arrows),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(child: TextField(controller: model.uriTextController,)),
                  ],
                ),
              ),
            ],
          ),
          const _ErrorMessageWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => model.startProcess(context),
              child: const Text("Start counting process"),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((HomeScreenViewModel m) => m.errorMessage);
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(fontSize: 17, color: Colors.red),
      ),
    );
  }
}
