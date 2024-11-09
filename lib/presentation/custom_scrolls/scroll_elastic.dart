import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ElasticScrollPhysics extends PageScrollPhysics {
  const ElasticScrollPhysics({super.parent});

  @override
  ElasticScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ElasticScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (position.atEdge) {
      final double overscrollPastStart = math.max(position.minScrollExtent - position.pixels, 0.0);
      final double overscrollPastEnd = math.max(position.pixels - position.maxScrollExtent, 0.0);
      final bool easing = (overscrollPastStart > 0.0 || overscrollPastEnd > 0.0);
      final double frictionFactor = easing ? 0.5 : 1.0;
      return offset * frictionFactor;
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.minScrollExtent) {
      return value - position.minScrollExtent;
    }
    if (value > position.maxScrollExtent) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }
}
