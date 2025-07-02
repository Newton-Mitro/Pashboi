import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';
import 'package:pashboi/features/public/notice/domain/repositories/notice_repository.dart';

class NoticeUseCase extends UseCase<List<NoticeEntity>, NoParams> {
  final NoticeRepository noticeRepository;

  NoticeUseCase({required this.noticeRepository});

  @override
  ResultFuture<List<NoticeEntity>> call(NoParams params) {
    return noticeRepository.findNotice();
  }
}
