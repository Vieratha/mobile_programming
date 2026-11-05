import 'package:flutter_test/flutter_test.dart';
import 'package:tugaspertemuan11_musicplayer/main.dart';

void main() {
  testWidgets('Ivylodia can be displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const IvylodiaApp());

    expect(find.text('Ivylodia'), findsOneWidget);
  });
}
