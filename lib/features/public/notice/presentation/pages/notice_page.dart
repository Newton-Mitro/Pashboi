import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';
import 'package:pashboi/features/public/notice/presentation/bloc/notice_bloc.dart';
import 'package:pashboi/features/public/notice/presentation/pages/notice_details_page.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NoticeBloc>()..add(FetchNoticeEvent()),
      child: PageContainer(
        child: BlocBuilder<NoticeBloc, NoticeState>(
          builder: (context, state) {
            if (state is NoticeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NoticeError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is NoticeSuccess) {
              final List<NoticeEntity> notices = state.notices;

              if (notices.isEmpty) {
                return const Center(child: Text('No notices available.'));
              }

              return ListView.builder(
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  final notice = notices[index];
                  return Card(
                    elevation: 1,
                    shadowColor: const Color.fromARGB(179, 0, 0, 0),
                    color: context.theme.colorScheme.surface,
                    surfaceTintColor: context.theme.colorScheme.surface,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: const Text(
                        '📢', // Or use a proper icon field if available in entity
                        style: TextStyle(fontSize: 28),
                      ),
                      title: Text(
                        notice.title,
                        style: TextStyle(
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      // subtitle: Text(notice.shortDescription),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => NoticeDetailsPage(notice: notice),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink(); // fallback
          },
        ),
      ),
    );
  }
}
