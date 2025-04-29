import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// A custom scroll physics that applies an elastic effect when the user
/// scrolls beyond the boundaries of the scrollable content.
///
/// This class extends [PageScrollPhysics] and overrides the necessary methods
/// to provide a custom scrolling behavior.
///
/// The elastic effect is achieved by applying a friction factor to the user
/// offset when the scroll position is at the edge of the scrollable content.
///
/// - `applyTo`: Creates a copy of this physics object with the given ancestor.
/// - `applyPhysicsToUserOffset`: Applies a friction factor to the user offset
///   when the scroll position is at the edge.
/// - `applyBoundaryConditions`: Determines the overscroll amount when the
///   scroll position goes beyond the boundaries.
///
/// You can measure how much the scroll effect stretches by adjusting the
/// `frictionFactor` in the `applyPhysicsToUserOffset` method.
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
