
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_state.dart';

void main() {
	group('AuthState', () {
		test('AuthState can be instantiated', () {
			expect(AuthState(), isNotNull);
		});
	});
}
