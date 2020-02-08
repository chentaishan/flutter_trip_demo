import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool loading;

  Widget child;

  LoadingContainer({Key key, this.loading, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          child,
          isLoading(),
        ],
      ),
    );
  }

  Widget isLoading() {
    return loading ? CircularProgressIndicator() : Container();
  }
}
