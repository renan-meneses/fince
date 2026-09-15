import 'package:fince/app.dart';
import 'package:fince/core/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app shell renders the home route', (WidgetTester tester) async {
    await tester.pumpWidget(FinceApp(router: AppRouter().router));

    expect(find.text('Fince'), findsOneWidget);
    expect(find.text('Dashboard em breve'), findsOneWidget);
  });
}
