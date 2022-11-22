import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// size nullable
typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performResize() {
    super.performResize();

    Size? newSize = child?.size;
    if (oldSize == newSize) return;
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        onChange(newSize!);
      });
    }
  }

  @override
  void performLayout() {
    super.performLayout();

    Size? newSize = child?.size;
    if (oldSize == newSize) return;

    oldSize = newSize!;
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        onChange(newSize);
      });
    }
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize(
       {
        Key? key,
         required Widget child,
         required this.onChange,
      }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
