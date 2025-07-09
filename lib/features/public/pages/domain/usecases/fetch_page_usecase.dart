import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/pages/domain/enities/page_entity.dart';
import 'package:pashboi/features/public/pages/domain/repositories/page_repository.dart';

class PageProps {
  final String pageSlug;
  const PageProps({required this.pageSlug});
}

class PageUseCase extends UseCase<PageEntity, PageProps> {
  final PageRepository pageRepository;

  PageUseCase({required this.pageRepository});

  @override
  ResultFuture<PageEntity> call(PageProps props) {
    return pageRepository.findPageByPageSlug(props);
  }
}
