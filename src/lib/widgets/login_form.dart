
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class LoginForm extends StatefulWidget {
	@override
	State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return BlocListener<AuthCubit, AuthState>(
			listener: (context, state) {
				if (state is AuthFailure) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(content: Text(state.message)),
					);
				}
			},
			child: Form(
				key: _formKey,
				child: Column(
					children: [
						TextFormField(
							controller: _emailController,
							decoration: InputDecoration(labelText: 'Email'),
							validator: (value) {
								if (value == null || value.isEmpty) {
									return 'Please enter your email';
								}
								return null;
							},
						),
						TextFormField(
							controller: _passwordController,
							decoration: InputDecoration(labelText: 'Password'),
							obscureText: true,
							validator: (value) {
								if (value == null || value.isEmpty) {
									return 'Please enter your password';
								}
								return null;
							},
						),
						ElevatedButton(
							onPressed: () {
								if (_formKey.currentState?.validate() ?? false) {
									final email = _emailController.text;
									final password = _passwordController.text;
									context.read<AuthCubit>().login(email, password);
								}
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
