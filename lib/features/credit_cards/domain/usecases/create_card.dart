import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../entities/credit_card.dart';
import '../repositories/credit_card_repository.dart';

/// Creates a credit card with a client-generated UUID.
class CreateCard {
  const CreateCard(this._repository, {Uuid uuid = const Uuid()}) : _uuid = uuid;

  final CreditCardRepository _repository;
  final Uuid _uuid;

  Future<CreditCard> call({
    required String name,
    required CardBrand brand,
    required Money creditLimit,
    required int closingDay,
    required int dueDay,
    String? linkedAccountId,
  }) {
    return _repository.createCard(
      CreditCard(
        id: _uuid.v4(),
        name: name,
        brand: brand,
        creditLimit: creditLimit,
        availableLimit: creditLimit,
        currency: creditLimit.currency,
        closingDay: closingDay,
        dueDay: dueDay,
        linkedAccountId: linkedAccountId,
        createdAt: DateTime.now().toUtc(),
        isActive: true,
      ),
    );
  }
}
