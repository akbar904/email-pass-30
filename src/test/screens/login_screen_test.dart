
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/screens/login_screen.dart';

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display the LoginScreen with a form', (WidgetTester tester) async {
			// Build the LoginScreen widget
			await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

			// Verify if the email and password fields are present
			expect(find.byType(TextField), findsNWidgets(2));

			// Verify if the login button is present
			expect(find.text('Login'), findsOneWidget);
		});
	});
}
