import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/pages/domain/enities/page_entity.dart';
import 'package:pashboi/features/public/pages/domain/usecases/fetch_page_usecase.dart';

abstract class PageRepository {
  ResultFuture<PageEntity> findPageByPageSlug(PageProps props);
}
