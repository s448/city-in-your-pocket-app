import 'package:flutter/material.dart';

class ReusableStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const ReusableStreamBuilder({
    super.key,
    required this.stream,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: builder,
    );
  }
}
