import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class MobileVerificationPage extends StatefulWidget {
  final String routeName;

  const MobileVerificationPage({super.key, required this.routeName});

  @override
  State<MobileVerificationPage> createState() => _MobileVerificationPageState();
}

class _MobileVerificationPageState extends State<MobileVerificationPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (_phoneController.text.isEmpty) {
      _showSnackBar(
        title: 'Info',
        message: 'Please enter your mobile number',
        type: ContentType.failure,
      );
      return;
    }

    context.read<VerifyMobileNumberBloc>().add(
      SubmitMobileNumber(
        mobileNumber: _phoneController.text,
        isRegistered: true, // or false based on context
      ),
    );
  }

  void _showSnackBar({
    required String title,
    required String message,
    required ContentType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyMobileNumberBloc, VerifyMobileNumberState>(
      listener: (context, state) {
        if (state is VerifyMobileNumberFailure) {
          _showSnackBar(
            title: 'Failed',
            message: state.error,
            type: ContentType.failure,
          );
        } else if (state is VerifyMobileNumberSuccess) {
          _showSnackBar(
            title: 'Success',
            message: state.message,
            type: ContentType.success,
          );

          Navigator.pushReplacementNamed(
            context,
            PublicRoutesName.otpVerificationPage,
            arguments: {
              'routeName': widget.routeName,
              'mobileNumber': _phoneController.text,
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Locales.string(context, "mobile_verification_page_title"),
          ),
        ),
        body: AppBackground(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(alignment: Alignment.center, child: AppLogo(width: 150)),
                const SizedBox(height: 40),
                AppTextInput(
                  controller: _phoneController,
                  label: Locales.string(
                    context,
                    "mobile_verification_page_mobile_number_label",
                  ),
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                ),
                const SizedBox(height: 16),
                BlocBuilder<VerifyMobileNumberBloc, VerifyMobileNumberState>(
                  builder: (context, state) {
                    final isLoading = state is VerifyMobileNumberLoading;
                    return AppPrimaryButton(
                      label:
                          isLoading
                              ? 'Sending...'
                              : Locales.string(
                                context,
                                "mobile_verification_page_send_otp_button",
                              ),
                      onPressed: isLoading ? null : _sendOtp,
                      iconBefore: Icon(
                        Icons.send,
                        color: context.theme.colorScheme.onPrimary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
