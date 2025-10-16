import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class StreamOrderUseCase {
  final OrderDetailsRepo _repository;

  StreamOrderUseCase(this._repository);

  Stream<Map<String, dynamic>?> call(String orderId) {
    return _repository.streamOrder(orderId);
  }
}
