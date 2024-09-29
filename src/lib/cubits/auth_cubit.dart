
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
	final AuthRepository _authRepository;

	AuthCubit(this._authRepository) : super(AuthInitial());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());
			final user = await _authRepository.login(email, password);
			emit(Authenticated(user));
		} catch (e) {
			emit(AuthError(e.toString()));
		}
	}

	void logout() {
		emit(Unauthenticated());
	}
}

abstract class AuthRepository {
	Future<User> login(String email, String password);
}
