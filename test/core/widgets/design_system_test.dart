import 'package:fince/core/domain/money.dart';
import 'package:fince/core/widgets/balance_card.dart';
import 'package:fince/core/widgets/budget_progress_card.dart';
import 'package:fince/core/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('BalanceCard renders label and formatted amount', (tester) async {
    await tester.pumpWidget(
      _wrap(
        BalanceCard(label: 'Saldo total', amount: Money(1234567, 'BRL')),
      ),
    );

    expect(find.text('Saldo total'), findsOneWidget);
    expect(find.textContaining('12.345,67'), findsOneWidget);
  });

  testWidgets('TransactionTile signs income and expense amounts', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Column(
          children: [
            TransactionTile(
              title: 'Salário',
              subtitle: '01/09',
              amount: Money(500000, 'BRL'),
              kind: TransactionKind.income,
            ),
            TransactionTile(
              title: 'Aluguel',
              subtitle: '05/09',
              amount: Money(120000, 'BRL'),
              kind: TransactionKind.expense,
            ),
          ],
        ),
      ),
    );

    expect(find.textContaining('+'), findsOneWidget);
    expect(find.textContaining('-'), findsOneWidget);
    expect(find.text('Salário'), findsOneWidget);
    expect(find.text('Aluguel'), findsOneWidget);
  });

  testWidgets('BudgetProgressCard shows remaining amount', (tester) async {
    await tester.pumpWidget(
      _wrap(
        BudgetProgressCard(
          name: 'Alimentação',
          spent: Money(70000, 'BRL'),
          limit: Money(100000, 'BRL'),
        ),
      ),
    );

    expect(find.text('Alimentação'), findsOneWidget);
    expect(find.text('70%'), findsOneWidget);
    expect(find.textContaining('Restam'), findsOneWidget);
  });
}
