import 'package:flowery_tracking_app/core/errors/firebase_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/to_firebase/to_firebase_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveOrderUseCase {
  final HomeTabRepo _repo;

  SaveOrderUseCase(this._repo);

  Future<FirebaseResult<void>> invoke(ToFirebaseEntity model) =>
      _repo.saveOrder(model);
}
