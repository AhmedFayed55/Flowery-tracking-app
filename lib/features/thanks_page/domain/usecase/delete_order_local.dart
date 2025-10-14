import 'package:flowery_tracking_app/features/thanks_page/domain/repo/thanks_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteOrderLocal {
  final ThanksRepo _thanksRepo;
  DeleteOrderLocal(this._thanksRepo);

  Future<void> invoke() => _thanksRepo.deleteOrderLocal();
}