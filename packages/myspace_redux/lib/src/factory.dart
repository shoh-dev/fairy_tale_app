import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:myspace_redux/src/state.dart';

abstract class BaseFactory<T extends Widget?, Model extends Vm> extends VmFactory<AppState, T, Model> {
  BaseFactory(super._connector);
}
