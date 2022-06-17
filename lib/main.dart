import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/main_vm.dart';
import 'package:shimmer/shimmer/shimmer.dart';
import 'package:shimmer/shimmer/shimmer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MainVm>(
        create: (context) => MainVm(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<MainVm>(
          builder: (context, model, _) {
            return ShimmerWidget(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.green,
                    child: Text(
                      'You have pushed the button this many times:',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.green,
                    child: Text(
                      'You have pushed the button this many times:',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.green,
                    child: Text(
                      'You have pushed the button this many times:',
                    ),
                  )
                ],
              ),
              isLoading: model.mainState == MainState.loading,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MainVm>(context, listen: false).loadData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
