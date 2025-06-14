import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/features/auth/presentation/bloc/otp_verification_bloc/otp_verification_bloc.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/usecases/open_deposit_account_usecase.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class OtpVerificationSection extends StatefulWidget {
  final String routeName;
  final OpenDepositAccountUseCaseParams requestObject;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final bool? isFirstStep;
  final bool? isLastStep;

  const OtpVerificationSection({
    super.key,
    required this.routeName,
    required this.requestObject,
    this.onNext,
    this.onPrevious,
    this.isFirstStep,
    this.isLastStep,
  });

  @override
  State<OtpVerificationSection> createState() => _OtpVerificationSectionState();
}

class _OtpVerificationSectionState extends State<OtpVerificationSection> {
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;
  bool _isWaiting = true;
  final int _otpDuration = 60;
  late final CountDownController _countDownController;
  late String _otpRegId;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    _countDownController = CountDownController();

    _otpRegId = widget.requestObject.otpRegId;
    _countDownController.start();

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _otpControllers[i].clear();
        }
      });
    }
  }

  @override
  void dispose() {
    try {
      _countDownController.pause();
    } catch (_) {}
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _resendOTP() {
    setState(() => _isWaiting = true);
    try {
      _countDownController.restart(duration: _otpDuration);
    } catch (_) {}

    context.read<VerifyMobileNumberBloc>().add(
      SubmitMobileNumber(
        mobileNumber: widget.requestObject.mobileNumber,
        isRegistered: true,
      ),
    );
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _clearOtpFields() {
    for (var c in _otpControllers) {
      c.clear();
    }
    for (var f in _focusNodes) {
      f.unfocus();
    }
    setState(() => _isWaiting = false);
  }

  String getEnteredOtp() {
    return _otpControllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpVerificationBloc, OtpVerificationState>(
          listener: (context, state) {
            if (state is OtpVerificationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Error',
                    message: state.error,
                    contentType: ContentType.failure,
                  ),
                ),
              );
            } else if (state is OtpVerificationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Success',
                    message: state.message,
                    contentType: ContentType.success,
                  ),
                ),
              );
              Navigator.pushReplacementNamed(context, widget.routeName);
            }
          },
        ),
        BlocListener<VerifyMobileNumberBloc, VerifyMobileNumberState>(
          listener: (context, state) {
            if (state is VerifyMobileNumberSuccess) {
              setState(() {
                _otpRegId = state.message;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Success',
                    message: state.message,
                    contentType: ContentType.success,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surface,
              border: Border.all(color: context.theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Locales.string(context, "otp_verification_page_title"),
                      style: TextStyle(
                        color: context.theme.colorScheme.onPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        Locales.string(
                          context,
                          "otp_verification_page_instruction",
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              autofocus: index == 0,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                filled: true,
                                counterText: '',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: context.theme.colorScheme.secondary,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: context.theme.colorScheme.secondary,
                                    width: 1.0,
                                  ),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 10,
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _otpControllers[index].text = value[0];
                                  _otpControllers[index].selection =
                                      const TextSelection.collapsed(offset: 1);
                                }
                                _onOtpChanged(value, index);
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      if (_isWaiting)
                        Column(
                          children: [
                            CircularCountDownTimer(
                              duration: _otpDuration,
                              initialDuration: 0,
                              controller: _countDownController,
                              width: 60,
                              height: 60,
                              ringColor: Colors.grey.shade300,
                              fillColor: context.theme.colorScheme.secondary,
                              backgroundColor: Colors.transparent,
                              strokeWidth: 6.0,
                              strokeCap: StrokeCap.round,
                              isTimerTextShown: true,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.theme.colorScheme.onSurface,
                              ),
                              isReverse: true,
                              autoStart: true,
                              onComplete: () {
                                if (mounted) {
                                  setState(() => _isWaiting = false);
                                }
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              Locales.string(
                                context,
                                "otp_verification_page_otp_expired_in_text",
                              ),
                              style: TextStyle(
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        )
                      else
                        TextButton(
                          onPressed: () {
                            _clearOtpFields();
                            _resendOTP();
                          },
                          child: Text(
                            Locales.string(
                              context,
                              "otp_verification_page_reseend_otp_button",
                            ),
                            style: TextStyle(
                              color: context.theme.colorScheme.onSurface,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.isFirstStep == true
                  ? const SizedBox(width: 100)
                  : AppPrimaryButton(
                    horizontalPadding: 10,
                    iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                    label: "Previous",
                    onPressed: widget.onPrevious,
                  ),
              widget.isLastStep == true
                  ? const SizedBox(width: 100)
                  : AppPrimaryButton(
                    horizontalPadding: 10,
                    iconAfter: const Icon(FontAwesomeIcons.angleRight),
                    label: "Next",
                    onPressed: widget.onNext,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
