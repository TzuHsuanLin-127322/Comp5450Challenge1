import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../ui/others/dashboard_page.dart';
import '../home_view_model.dart';

class DashboardCard extends StatefulWidget {
  final HomeViewModel vm;
  const DashboardCard({Key? key, required this.vm}) : super(key: key);

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  String selected = 'This Week';
  final List<String> filters = ['Today', 'Yesterday', 'This Week', 'This Month'];

  @override
  Widget build(BuildContext context) {
    // Determine data & labels
    List<double> data;
    List<String> labels;
    double labelInterval;
    double leftLabelInterval = 4.0;
    double periodTotal;

    if (selected == 'Today') {
      final today = DateTime.now();
      data = widget.vm.hourlySales(today);
      labels = widget.vm.hourlyLabels();
      labelInterval = 4.0;
    } else if (selected == 'Yesterday') {
      final yesterday = DateTime.now().subtract(Duration(days: 1));
      data = widget.vm.hourlySales(yesterday);
      labels = widget.vm.hourlyLabels();
      labelInterval = 4.0;
    } else if (selected == 'This Week') {
      data = widget.vm.dailySales();
      labels = widget.vm.dailyLabels();
      labelInterval = 1.0;
    } else {
      final days = selected == 'This Month' ? 30 : 7;
      data = widget.vm.dailySales(days: days);
      labels = widget.vm.dailyLabels(days: days);
      labelInterval = 5.0;
    }

    // Determine max Y value and interval
    final maxY = data.isEmpty ? 0.0
        : data.reduce((a, b) => a > b ? a : b);
    double interval = maxY / 5;
    if (interval <= 0) interval = 1;

    // Sum up the visible data
    periodTotal = data.fold(0.0, (sum, val) => sum + val);

    return Column(
      children: [
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) => Padding(
              padding: EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(f),
                selected: selected == f,
                onSelected: (_) => setState(() => selected = f),
              ),
            )).toList(),
          ),
        ),
        SizedBox(height: 12),

        // Summary Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Total Sales: \$${periodTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Orders: ${data.where((v) => v > 0).length}', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 12),

        // Line Chart
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              // hide top & right axes
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: labelInterval,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i >= 0 && i < labels.length) {
                        return Text(labels[i], style: const TextStyle(fontSize: 10));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: leftLabelInterval,
                    reservedSize: 40,
                  ),
                ),
              ),

              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),

              // ensure zero‐values stay at zero
              lineBarsData: [
                LineChartBarData(
                spots: List.generate(
                  data.length,
                  (i) => FlSpot(i.toDouble(), data[i].clamp(0.0, double.infinity)),
                ),
                isCurved: true,
                preventCurveOverShooting: true,
                dotData: FlDotData(show: true),
                barWidth: 2,
                ),
              ]
            ),


        ),
      ),

        SizedBox(height: 12),

        // View Dashboard Button
        SizedBox(
        width: double.infinity,
        child: TextButton(
        style: TextButton.styleFrom(
        backgroundColor: Colors.grey[300],
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DashboardPage()),
        ),
        child: const Text('View Dashboard', style: TextStyle(color: Colors.black)),
        ),
        ),
    ],
    );
  }
}
