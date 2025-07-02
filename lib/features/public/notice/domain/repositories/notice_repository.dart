import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';

abstract class NoticeRepository {
  ResultFuture<List<NoticeEntity>> findNotice();
}
