import 'package:craftd_flutter_test/data_source.dart';
import 'package:craftd_widget/data/model/base/simple_properties.dart';
import 'package:craftd_widget/presentation/builder/craftd_builder_manager.dart';
import 'package:craftd_widget/presentation/ui/craftd_dynamic.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SimpleProperties> simplePropertiesList = [];
  final LocalDataSource localDataSource = LocalDataSource();
  final craftDBuilderManager = CraftDBuilderManager();

  @override
  void initState() {
    super.initState();

    loadProperties();
  }

  void loadProperties() async {
    List<SimpleProperties> properties =
        await localDataSource.loadProperties(context);

    setState(() {
      simplePropertiesList = properties;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          height: double.maxFinite,
          child: CraftDynamic(
            simplePropertiesList: simplePropertiesList,
            craftDBuilderManager: craftDBuilderManager,
            onAction: (actionProperties) {
              debugPrint(
                  "categoria ${actionProperties.analyticsProperties?.category} "
                  "label ${actionProperties.analyticsProperties?.label} - "
                  "track ${actionProperties.analyticsProperties?.track}");
            },
          ),
        ),
      ),
    );
  }
}
