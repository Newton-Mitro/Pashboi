import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/bloc/forgot_password_page_bloc/forgot_password_page_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgotPasswordPageBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),
        body: BlocConsumer<ForgotPasswordPageBloc, ForgotPasswordPageState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('OTP Sent!')));
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  state is ForgotPasswordLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                          context.read<ForgotPasswordPageBloc>().add(
                            SendForgotPasswordOtpEvent(_controller.text),
                          );
                        },
                        child: const Text('Send OTP'),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
