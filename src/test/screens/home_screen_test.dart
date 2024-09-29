
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should contain a LogoutButton', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider(
						create: (_) => MockAuthCubit(),
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.byType(LogoutButton), findsOneWidget);
		});

		testWidgets('should display "Home Screen" text', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider(
						create: (_) => MockAuthCubit(),
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Home Screen'), findsOneWidget);
		});
	});

	group('LogoutButton Widget Tests', () {
		blocTest<MockAuthCubit, void>(
			'should call logout when tapped',
			build: () => MockAuthCubit(),
			act: (cubit) async {
				await tester.pumpWidget(
					MaterialApp(
						home: BlocProvider(
							create: (_) => cubit,
							child: Scaffold(
								body: LogoutButton(),
							),
						),
					),
				);
				await tester.tap(find.byType(LogoutButton));
			},
			verify: (cubit) {
				verify(() => cubit.logout()).called(1);
			},
		);
	});
}
