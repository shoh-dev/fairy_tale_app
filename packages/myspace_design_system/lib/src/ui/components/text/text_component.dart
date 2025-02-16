import 'package:flutter/material.dart';

import 'types/hardcoded.dart';
import 'types/any.dart';
import 'types/currency.dart';
import 'types/number.dart';

abstract class TextComponent extends StatelessWidget {
  const TextComponent({super.key});

  factory TextComponent.hardCoded(String text, {bool ignoreLog}) =
      HardCodedTextComponent;

  const factory TextComponent.number(num number) = NumberTextComponent;

  const factory TextComponent.any(dynamic value) = AnyTextComponent;

  const factory TextComponent.currency(num number) = CurrencyTextComponent;
}
