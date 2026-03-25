import 'package:flutter_test/flutter_test.dart';
import 'package:water_quality_app/main.dart';

void main() {

  testWidgets('App loads correctly', (WidgetTester tester) async {

    await tester.pumpWidget(const WaterQualityApp());

    expect(find.text('Water Quality Assessment'), findsOneWidget);

  });

}