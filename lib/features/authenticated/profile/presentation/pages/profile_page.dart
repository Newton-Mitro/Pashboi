import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/profile/presentation/pages/bloc/profile_bloc.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileEvent());
  }

  void _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      context.read<ProfileBloc>().add(
        UpdateProfileImageEvent(imageData: base64Encode(bytes)),
      );
    }
  }

  Widget buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.theme.colorScheme.primary.withOpacity(0.8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(FetchProfileEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(child: Text(state.error));
            }

            if (state is ProfileSuccess) {
              final person = state.personEntity;

              return PageContainer(
                child: Container(
                  color: context.theme.colorScheme.primary.withOpacity(0.1),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.theme.colorScheme.surface,
                                  border: Border.all(
                                    color: context.theme.colorScheme.secondary,
                                    width: 5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.memory(
                                    person.photo.isNotEmpty
                                        ? base64Decode(person.photo)
                                        : Uint8List(0),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () => _pickImage(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.colorScheme.primary,
                                      border: Border.all(
                                        color:
                                            context.theme.colorScheme.secondary,
                                        width: 3,
                                      ),
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.camera,
                                      size: 18,
                                      color:
                                          context.theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          person.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          person.email,
                          style: TextStyle(
                            fontSize: 14,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Are you available for blood donation?",
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     Checkbox(
                        //       value: person.isBloodDonor,
                        //       onChanged: null, // make interactive if needed
                        //     ),
                        //   ],
                        // ),
                        // Text(
                        //   "Join our community of life-savers. If you're eligible and willing, you can now register as a blood donor and help someone in need—because saving lives is priceless.",
                        //   style: const TextStyle(fontSize: 12),
                        // ),
                        // const SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            buildInfoRow(
                              FontAwesomeIcons.baby,
                              "Date Of Birth",
                              MyDateUtils.formatDate(person.dateOfBirth),
                            ),
                            buildInfoRow(
                              FontAwesomeIcons.droplet,
                              "Blood Group",
                              person.bloodGroup,
                            ),
                            buildInfoRow(
                              FontAwesomeIcons.idCard,
                              "NID",
                              person.nid,
                            ),
                            buildInfoRow(
                              FontAwesomeIcons.phoneVolume,
                              "Mobile Number",
                              person.mobileNumber,
                            ),
                            buildInfoRow(
                              FontAwesomeIcons.locationPin,
                              "Present Address",
                              person.presentAddress,
                            ),
                            buildInfoRow(
                              FontAwesomeIcons.locationPinLock,
                              "Permanent Address",
                              person.permanentAddress,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
