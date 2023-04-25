import 'package:btc_chart/controller/ohlc_controller.dart';
import 'package:btc_chart/model/line_chart_bar_data.dart';
import 'package:btc_chart/model/line_chart_data.dart';
import 'package:btc_chart/model/spot.dart';
import 'package:btc_chart/view/chart_const.dart';
import 'package:btc_chart/view/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartView extends ConsumerWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ohlcs = ref.watch(ohlcProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 12, 144, 124), //change your color here
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        title: const Text(
          'Produksi Realtime Energi (Watt)-Tuban',
          style: TextStyle(color: Color.fromARGB(255, 12, 144, 124)),
        ),
      ),
      
      body: ohlcs.when(
        data: (_ohlcs) => Column(
          children: [
            Row(children: [
              Card(
              shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Harian',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Bulanan',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Tahunan',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
            ],),
            
            Row(children: [
              const Expanded(child: Icon(Icons.show_chart)),
              Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("PLTB"),
                      ],
                    ),
                  ),
              const Expanded(child: Icon(Icons.insights)),
              Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("PLTS"),
                      ],
                    ),
                  ),
              const Expanded(child: Icon(Icons.stacked_line_chart)),
              Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("PLTD"),
                      ],
                    ),
                  ),
              const Expanded(child: Icon(Icons.speed)),
              Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("Wind Speed"),
                      ],
                    ),
                  ),
              const Expanded(child: Icon(Icons.sunny)),
              Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("Solar Rad"),
                      ],
                    ),
                  ),
              const Expanded(child: Icon(Icons.gas_meter)),
              Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("BBM"),
                      ],
                    ),
                  ),
            ],),
            
            
            Expanded(
              child: LineChart(
                data: LineChartData([
                  LineChartBarData(
                    spots: _ohlcs
                        .map(
                          (ohlc) => Spot(
                            ohlc.closeTime,
                            ohlc.closePrice,
                          ),
                        )
                        .toList(),
                    color: Colors.blue,
                    
                  ),
                ]),
                horizontalAxisInterval: horizontalAxisInterval,
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: bitcoinColor,
          ),
        ),
        error: (error, _) => Text(error.toString()),
      ),
    );
  }
}
