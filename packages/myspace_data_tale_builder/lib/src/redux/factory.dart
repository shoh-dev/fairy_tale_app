import 'package:flutter/material.dart';
import 'package:myspace_data/src/redux.dart';

abstract class BaseFactory<T extends Widget?, Model extends Vm> extends VmFactory<AppState, T, Model> {
  BaseFactory(super._connector);
}
