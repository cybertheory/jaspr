extension UnitExt on num {
  Unit get percent => Unit.percent(toDouble());
  Unit get px => Unit.pixels(toDouble());
  Unit get pt => Unit.points(toDouble());
  Unit get em => Unit.em(toDouble());
  Unit get rem => Unit.rem(toDouble());
}

abstract class Unit {
  static const Unit zero = _ZeroUnit();

  static const Unit auto = _AutoUnit();

  /// Constructs a [Unit] in the form '100%'
  const factory Unit.percent(double value) = _PercentUnit;

  /// Constructs a [Unit] in the form '100px'
  const factory Unit.pixels(double value) = _PixelsUnit;

  /// Constructs a [Unit] in the form '100pt'
  const factory Unit.points(double value) = _PointsUnit;

  /// Constructs a [Unit] in the form '100em'
  const factory Unit.em(double value) = _EmUnit;

  /// Constructs a [Unit] in the form '100rem'
  const factory Unit.rem(double value) = _RemUnit;

  /// The css value
  String get value;
}

class _ZeroUnit implements Unit {
  const _ZeroUnit();

  @override
  String get value => '0';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Unit && other._value == 0;

  @override
  int get hashCode => 0;
}

class _AutoUnit implements Unit {
  const _AutoUnit();

  @override
  String get value => 'auto';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _AutoUnit;

  @override
  int get hashCode => 0;
}

class _Unit implements Unit {
  final String _unit;
  final double _value;

  const _Unit(this._value, this._unit);

  @override
  String get value => '${_value.numstr}$_unit';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      _value == 0 &&
          (other is _ZeroUnit || (other is _Unit && other._value == 0)) ||
      other is _Unit &&
          runtimeType == other.runtimeType &&
          _unit == other._unit &&
          _value == other._value;

  @override
  int get hashCode => _value == 0 ? 0 : _unit.hashCode ^ _value.hashCode;
}

class _PercentUnit extends _Unit {
  const _PercentUnit(double value) : super(value, '%');
}

class _PixelsUnit extends _Unit {
  const _PixelsUnit(double value) : super(value, 'px');
}

class _PointsUnit extends _Unit {
  const _PointsUnit(double value) : super(value, 'pt');
}

class _EmUnit extends _Unit {
  const _EmUnit(double value) : super(value, 'em');
}

class _RemUnit extends _Unit {
  const _RemUnit(double value) : super(value, 'rem');
}

extension NumberString on double {
  String get numstr {
    return roundToDouble() == this ? round().toString() : toString();
  }
}
