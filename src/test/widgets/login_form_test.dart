
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_cubit_app/widgets/login_form.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('should display email and password TextFields and a login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: authCubit,
						child: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});

		testWidgets('should display error message when AuthCubit emits AuthFailure state', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream.fromIterable([AuthFailure('Login failed')]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: authCubit,
						child: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			await tester.pump(); // Rebuild the widget to reflect state change

			expect(find.text('Login failed'), findsOneWidget);
		});

		testWidgets('should call login method when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: authCubit,
						child: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
			await tester.enterText(find.byType(TextFormField).at(1), 'password');
			await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
			await tester.pump();

			verify(() => authCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
