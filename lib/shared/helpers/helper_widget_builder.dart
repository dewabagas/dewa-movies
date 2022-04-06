import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:flutter/material.dart';

class HelperWidgetBuilder extends StatelessWidget {
  final ViewState state;
  final Widget onLoadingBuilder;
  final Widget onSuccessBuilder;
  final Widget onErrorBuilder;

  const HelperWidgetBuilder({
    required this.state,
    required this.onLoadingBuilder,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.busy:
        return onLoadingBuilder;

      case ViewState.error:
        return onErrorBuilder;

      case ViewState.retrived:
        break;

      default:
        break;
    }
    return onSuccessBuilder;
  }
}
