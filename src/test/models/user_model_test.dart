
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/models/user_model.dart';

void main() {
	group('User Model', () {
		test('User model should be instantiated correctly', () {
			final user = User(id: '1', email: 'test@example.com', name: 'Test User');
			expect(user.id, '1');
			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});

		test('User model should serialize to JSON correctly', () {
			final user = User(id: '1', email: 'test@example.com', name: 'Test User');
			final json = user.toJson();
			expect(json, {
				'id': '1',
				'email': 'test@example.com',
				'name': 'Test User'
			});
		});

		test('User model should deserialize from JSON correctly', () {
			final json = {
				'id': '1',
				'email': 'test@example.com',
				'name': 'Test User'
			};
			final user = User.fromJson(json);
			expect(user.id, '1');
			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});
	});
}
