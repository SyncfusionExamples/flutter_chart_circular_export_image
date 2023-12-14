/// Dart import
import 'dart:typed_data';
import 'dart:ui' as ui;

///Package imports
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExportCircular(),
    );
  }
}

///Renders default circular chart sample
class ExportCircular extends StatefulWidget {
  ///Renders default circular chart sample
  const ExportCircular({Key? key}) : super(key: key);

  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<ExportCircular> {
  _ExportState();
  late GlobalKey<SfCircularChartState> _circularChartKey;
  late List<ChartSampleData> _chartData;

  @override
  void initState() {
    _circularChartKey = GlobalKey();
    _chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 12),
      ChartSampleData(x: 'Feb', y: 28),
      ChartSampleData(x: 'Mar', y: 35),
      ChartSampleData(x: 'Apr', y: 47),
      ChartSampleData(x: 'May', y: 56),
      ChartSampleData(x: 'Jun', y: 70),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SfCircularChart(
                key: _circularChartKey,
                series: <CircularSeries<ChartSampleData, String>>[
                  PieSeries<ChartSampleData, String>(
                    dataSource: _chartData,
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                  )
                ]),
            TextButton(
              child: const Text('Export as image'),
              onPressed: () {
                _renderCircularImage();
              },
            )
          ]),
    );
  }

  Future<void> _renderCircularImage() async {
    final ui.Image? data =
        await _circularChartKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await data!.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return Scaffold(body: Image.memory(imageBytes));
        },
      ),
    );
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData({this.x, this.y});

  /// Holds x value of the datapoint
  final String? x;

  /// Holds y value of the datapoint
  final num? y;
}
