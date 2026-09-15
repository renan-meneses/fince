import '../entities/credit_card.dart';
import '../repositories/credit_card_repository.dart';

class WatchCards {
  const WatchCards(this._repository);

  final CreditCardRepository _repository;

  Stream<List<CreditCard>> call() => _repository.watchCards();
}
