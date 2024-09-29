
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_state.dart';

// Mock dependencies if any (for example, a repository)
class MockAuthRepository extends Mock {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;
		late MockAuthRepository mockAuthRepository;

		setUp(() {
			mockAuthRepository = MockAuthRepository();
			authCubit = AuthCubit(mockAuthRepository);
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, equals(AuthInitial()));
		});

		group('login', () {
			blocTest<AuthCubit, AuthState>(
				'emits [AuthLoading, Authenticated] when login is successful',
				build: () {
					when(() => mockAuthRepository.login(any(), any()))
						.thenAnswer((_) async => User(id: '1', email: 'test@test.com', name: 'Test User'));
					return authCubit;
				},
				act: (cubit) => cubit.login('test@test.com', 'password'),
				expect: () => [AuthLoading(), Authenticated(User(id: '1', email: 'test@test.com', name: 'Test User'))],
				verify: (_) {
					verify(() => mockAuthRepository.login('test@test.com', 'password')).called(1);
				},
			);

			blocTest<AuthCubit, AuthState>(
				'emits [AuthLoading, AuthError] when login fails',
				build: () {
					when(() => mockAuthRepository.login(any(), any()))
						.thenThrow(Exception('Login Failed'));
					return authCubit;
				},
				act: (cubit) => cubit.login('test@test.com', 'wrongpassword'),
				expect: () => [AuthLoading(), AuthError('Login Failed')],
				verify: (_) {
					verify(() => mockAuthRepository.login('test@test.com', 'wrongpassword')).called(1);
				},
			);
		});

		group('logout', () {
			blocTest<AuthCubit, AuthState>(
				'emits [Unauthenticated] when logout is called',
				build: () => authCubit,
				act: (cubit) => cubit.logout(),
				expect: () => [Unauthenticated()],
			);
		});
	});
}
