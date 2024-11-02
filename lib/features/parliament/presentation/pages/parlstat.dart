import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ParliamentVotingStatisticsPage extends StatelessWidget {
  const ParliamentVotingStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'مجلس النواب',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Page Introduction Card
            _buildIntroCard(context),
            const SizedBox(height: 10),
            // Total Votes Card
            _buildTotalVotesCard(
                'إجمالي عدد الأصوات', 'منذ 01-10-2024', '1234'),
            const SizedBox(height: 10),
            // Total Votes Card
            _buildTotalVotesCard(
                'إجمالي المشاريع المرفوعة للتصويت', 'منذ 01-10-2024', '32'),
            const SizedBox(height: 10),
            _buildGenderComparisonCard(context),
            const SizedBox(height: 10),
            // Regional Breakdown Section
            _buildRegionalBreakdownCard(context),
            const SizedBox(height: 10),
            _buildProjectComparisonCard(context),
            const SizedBox(height: 10),
            buildAgeRangeStatsCard(context),
          ],
        ),
      ),
    );
  }

  // Page Introduction Card
  Widget _buildIntroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.query_stats_sharp,
                color: Theme.of(context).colorScheme.secondary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'الإحصائيات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'تُقدِّم هذه الصفحة إحصائيات مفصلة حول تصويت مجلس النواب. توفر الصفحة رؤية شاملة للإحصائيات المتعلقة بالتصويت، بما في ذلك توزيع الأصوات حسب المحافظات والفئات العمرية والجنس. تهدف هذه المعلومات إلى تمكين المستخدمين من فهم أنماط التصويت والمشاركة بشكل أعمق، استنادًا إلى البيانات المتنوعة المعروضة.',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalVotesCard(String title, String date, String number) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B2D42),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  date, // Use actual date here
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 134, 134, 134)),
                ),
              ],
            ),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD90429), // Red background
              ),
              child: Center(
                child: Text(
                  number, // Replace with the actual total votes
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderComparisonCard(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مقارنة بين الناخبين الذكور والإناث',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2D42),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'تعرض هذه البطاقة الفرق بين نسبة الناخبين الذكور والإناث بناءً على عدد الأصوات المسجلة.',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 134, 134, 134),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Male Voters Circle
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Red for male
                      ),
                      child: const Center(
                        child: Text(
                          '55%', // Example male percentage
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('الذكور',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B2D42))),
                  ],
                ),

                // Female Voters Circle
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary, // Red for female
                      ),
                      child: const Center(
                        child: Text(
                          '45%', // Example female percentage
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('الإناث',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B2D42))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectComparisonCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مقارنة بين المشاريع',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'يقارن هذا القسم بين دعم المشاريع المختلفة بناءً على نسبة الأصوات المؤيدة. يساعد على '
              'تحديد أكثر المشاريع شعبية بين الجمهور.',
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 134, 134, 134)),
            ),
            const SizedBox(height: 16),
            _buildProjectComparison('تعديل قانون التعليم العام', 80, context),
            _buildProjectComparison(
                'قانون دعم رواد الأعمال والشركات الناشئة', 70, context),
            _buildProjectComparison(
                'مشروع قانون تنظيم التجارة الإلكترونية', 60, context),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectComparison(
      String projectName, int supportPercentage, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(projectName,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2B2D42),
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: supportPercentage / 100.0,
                backgroundColor: Theme.of(context).colorScheme.surface,
                color: Theme.of(context).colorScheme.primary,
                minHeight: 5,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$supportPercentage%',
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 134, 134, 134),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.category, this.value);
  final String category;
  final double value;
}

// Example simple chart for the last card
Widget buildAgeRangeStatsCard(BuildContext context) {
  List<_ChartData> data = [
    _ChartData('18-25', 30),
    _ChartData('26-35', 40),
    _ChartData('36-45', 20),
    _ChartData('45<', 10),
  ];

  final barColor = Theme.of(context).colorScheme.primary;

  return Card(
    color: Theme.of(context).colorScheme.surfaceContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الفئات العمرية للمصوتين",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "تعرض هذه البطاقة نسبة المصوتين من كل فئة عمرية من إجمالي المصوتين في التطبيق، مما يساعد على معرفة الفئات العمرية الأكثر مشاركة في عملية التصويت.",
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 134, 134, 134),
            ),
          ),
          const SizedBox(height: 16),
          SfCartesianChart(
            primaryXAxis: const CategoryAxis(
              title: AxisTitle(text: 'الفئات العمرية'), // X-axis label
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'نسبة المصوتين (%)'), // Y-axis label
              interval: 10, // Set the interval for y-axis
            ),
            series: [
              ColumnSeries<_ChartData, String>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.category,
                yValueMapper: (_ChartData data, _) => data.value,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    fontSize: 14, // Control the size of the data labels
                  ),
                ),
                dataLabelMapper: (data, _) => '${data.value}%',
                color: barColor,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Method to build an individual age range item with icons
Widget buildIconPercentageRow(
    BuildContext context, String ageRange, int percentage, Color color) {
  int filledIcons =
      (percentage / 10).round(); // Number of filled icons (each represents 10%)
  int emptyIcons = 10 - filledIcons; // Remaining icons to keep layout balanced

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        ageRange,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      const SizedBox(height: 8),

      // Row of filled and unfilled icons to represent percentage
      Row(
        children: [
          // Filled icons
          for (int i = 0; i < filledIcons; i++)
            Icon(Icons.circle, size: 16, color: color),

          // Unfilled icons
          for (int i = 0; i < emptyIcons; i++)
            Icon(Icons.circle_outlined,
                size: 16,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
        ],
      ),

      const SizedBox(height: 4),

      // Display percentage as text
      Text(
        "$percentage%",
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ],
  );
}

class _PieData {
  _PieData(this.region, this.percentage, this.color);
  final String region;
  final double percentage;
  final Color color;
}

Widget _buildRegionalBreakdownCard(BuildContext context) {
  List<_PieData> data = [
    _PieData('العاصمة', 45, Theme.of(context).colorScheme.secondary),
    _PieData('إربد', 35, Theme.of(context).colorScheme.secondary.withBlue(120)),
    _PieData(
        'الزرقاء', 20, Theme.of(context).colorScheme.secondary.withBlue(160)),
  ];

  return Card(
    color: Theme.of(context).colorScheme.surfaceContainer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'توزيع المحافظات حسب التصويت',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'تعرض هذه البطاقة رسمًا بيانيًا دائريًا يوضح توزيع الأصوات حسب المحافظات المختلفة، مما يسمح للمستخدمين برؤية أي المحافظات تحتوي على أعلى نسبة من المصوتين. كل محافظة ممثلة بجزء من الدائرة، وحجم الجزء يعكس نسبة التصويت من تلك المحافظة.',
            style: TextStyle(
              color: Color.fromARGB(255, 134, 134, 134),
              fontSize: 14,
            ),
          ),
          SfCircularChart(
            legend: Legend(
              isVisible: true,
              textStyle: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .secondary, // Customize legend color
                fontSize: 12, // Customize legend text size
                fontWeight: FontWeight.bold, // Customize legend font weight
              ),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <PieSeries<_PieData, String>>[
              PieSeries<_PieData, String>(
                dataSource: data,
                xValueMapper: (_PieData data, _) => data.region,
                yValueMapper: (_PieData data, _) => data.percentage,
                pointColorMapper: (_PieData data, _) => data.color,
                dataLabelMapper: (data, _) =>
                    '${data.region}\n${data.percentage}%', // Append % symbol
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    fontSize: 10, // Customize label font size
                    fontWeight: FontWeight.bold, // Customize label font weight
                    color: Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ), // Customize label color
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
