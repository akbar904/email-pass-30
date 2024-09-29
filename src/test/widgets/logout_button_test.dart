
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_cubit_app/widgets/logout_button.dart';

// Mock Cubit for testing purposes
class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('should display Logout text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout on button press', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
