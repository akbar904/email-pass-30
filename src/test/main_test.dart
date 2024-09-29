
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('displays LoginScreen when unauthenticated', (WidgetTester tester) async {
			when(() => mockAuthCubit.state).thenReturn(Unauthenticated());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);

			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('displays HomeScreen when authenticated', (WidgetTester tester) async {
			when(() => mockAuthCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});
}
