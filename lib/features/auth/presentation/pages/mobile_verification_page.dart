import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class MobileVerificationPage extends StatefulWidget {
  final String routeName;

  const MobileVerificationPage({super.key, required this.routeName});

  @override
  State<MobileVerificationPage> createState() => _MobileVerificationPageState();
}

class _MobileVerificationPageState extends State<MobileVerificationPage> {
  final String _prefix = '+880-';
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: _prefix);

    _phoneController.addListener(() {
      final text = _phoneController.text;

      // Enforce prefix presence
      if (!text.startsWith(_prefix)) {
        final newText = _prefix;
        _phoneController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (_phoneController.selection.start < _prefix.length) {
        // Keep cursor after prefix
        _phoneController.selection = TextSelection.collapsed(
          offset: _prefix.length,
        );
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final fullNumber = _phoneController.text;
    final rawNumber = fullNumber.replaceFirst(_prefix, '');

    if (rawNumber.isEmpty) {
      _showSnackBar(
        title: 'Info',
        message: 'Please enter your mobile number',
        type: ContentType.failure,
      );
      return;
    }

    context.read<VerifyMobileNumberBloc>().add(
      SubmitMobileNumber(mobileNumber: fullNumber, isRegistered: true),
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
              'otpRegId': state.message,
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
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        FontAwesomeIcons.mobileScreenButton,
                        size: 80,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      Locales.string(context, "mobile_verification_page_title"),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // You can uncomment and use the CountryCodePicker here if you want dynamic country code
                    // const SizedBox(width: 8),
                    Expanded(
                      child: AppTextInput(
                        controller: _phoneController,
                        label: Locales.string(
                          context,
                          "mobile_verification_page_mobile_number_label",
                        ),
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                  ],
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
