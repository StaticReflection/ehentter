import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehentter/core/bloc/base_bloc.dart';
import 'package:ehentter/presentation/common/base/ui_feedback.dart';

/// [B]: Bloc 类型
/// [E]: Effect 副作用类型
abstract class BaseWidget<B extends BaseBloc<dynamic, dynamic, E>, E>
    extends StatelessWidget
    with UiFeedbackMixin {
  const BaseWidget({super.key});

  Widget buildWidget(BuildContext context, B bloc);

  void onEffect(BuildContext context, E effect);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<B>();

    return _EffectHandler<E>(
      stream: bloc.effectStream,
      onEffect: (effect) => onEffect(context, effect),
      child: buildWidget(context, bloc),
    );
  }
}

class _EffectHandler<E> extends StatefulWidget {
  final Stream<E> stream;
  final ValueChanged<E> onEffect;
  final Widget child;

  const _EffectHandler({
    required this.stream,
    required this.onEffect,
    required this.child,
  });

  @override
  State<_EffectHandler<E>> createState() => _EffectHandlerState<E>();
}

class _EffectHandlerState<E> extends State<_EffectHandler<E>> {
  StreamSubscription<E>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen((effect) {
      if (mounted) widget.onEffect(effect);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
