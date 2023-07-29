import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:muda_facil/src/modules/search/domain/entities/result_search.dart';
import 'package:muda_facil/src/modules/search/domain/errors/errors.dart';
import 'package:muda_facil/src/modules/search/domain/repositories/search_repository.dart';
import 'package:muda_facil/src/modules/search/domain/usecases/search_by_text.dart';

import 'search_by_text_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchRepositoryTest>()])
class SearchRepositoryTest implements SearchRepository {
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    return const Right(<ResultSearch>[]);
  }
}

void main() {
  late MockSearchRepositoryTest repository;
  late SearchByTextImpl usecase;

  setUpAll(() {
    repository = MockSearchRepositoryTest();
    usecase = SearchByTextImpl(repository);

    when(repository.search('test'))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));
  });

  test('Should return a list of ResultSearch', () async {
    final result = await usecase('test');
    expect(result.isRight(), true);
  });

  test('Should return an InvalidTextError when the search text is empty',
      () async {
    final result = await usecase('');
    expect(result.isLeft(), true);
    expect(result.fold(id, (_) => null), isA<InvalidTextError>());
  });
}
