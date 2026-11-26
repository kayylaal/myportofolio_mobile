import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

ApiClient _testApiClient() => ApiClient(
  client: MockClient((_) async => http.Response('{"token":"test-token"}', 200)),
);

void main() {
  testWidgets('home displays profile and portfolio actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: _testApiClient()));

    expect(find.text('2506603854'), findsOneWidget);
    expect(find.text('Kayla Ali'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
  });

  testWidgets('adding a project asks the user to log in first', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: _testApiClient()));

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
