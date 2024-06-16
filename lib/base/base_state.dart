import 'package:flutter/material.dart';
import 'package:notepad_app/base/base_controller.dart';
import 'package:notepad_app/base/base_stateful_widget.dart';

abstract class BaseState<StatefulWidget> extends State<BaseStatefulWidget> {
  late final BaseController baseController;
}
