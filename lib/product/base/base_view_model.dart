import 'package:flutter/material.dart';

mixin class BaseViewModel {
  late BuildContext viewModelContext;

  void setContext(BuildContext context) {
    throw UnimplementedError();
  }

  void init() {
    throw UnimplementedError();
  }
}
