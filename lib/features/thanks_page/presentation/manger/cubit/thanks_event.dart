sealed class ThanksEvent {}

class InitialThanksEvent extends ThanksEvent {
  final String orderId;
  InitialThanksEvent({required this.orderId});
}
