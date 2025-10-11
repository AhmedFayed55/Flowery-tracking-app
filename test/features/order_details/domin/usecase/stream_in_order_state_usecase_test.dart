import 'dart:async';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/stream_in_order_state_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';

import 'get_order_details_usecase_test.mocks.dart';

@GenerateMocks([OrderDetailsRepo])
void main() {
  late StreamOrderUseCase useCase;
  late MockOrderDetailsRepo mockRepo;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    useCase = StreamOrderUseCase(mockRepo);
  });

  const orderId = 'order_123';

  final mockStreamData = {
    'id': orderId,
    'state': 'pending',
    'totalPrice': 150,
  };

  test(' should return the same stream from repository', () async {
    // arrange
    final controller = StreamController<Map<String, dynamic>?>();
    when(mockRepo.streamOrder(orderId)).thenAnswer((_) => controller.stream);

    // act
    final stream = useCase(orderId);

    // assert 
    expectLater(stream, emitsInOrder([mockStreamData]));

    
    controller.add(mockStreamData);
    await controller.close();

    verify(mockRepo.streamOrder(orderId)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
