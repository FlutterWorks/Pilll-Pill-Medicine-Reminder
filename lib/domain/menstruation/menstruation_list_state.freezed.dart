// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'menstruation_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MenstruationListStateTearOff {
  const _$MenstruationListStateTearOff();

  _MenstruationListState call(
      {bool isNotYetLoaded = true,
      List<MenstruationHistoryRowState> rows = const []}) {
    return _MenstruationListState(
      isNotYetLoaded: isNotYetLoaded,
      rows: rows,
    );
  }
}

/// @nodoc
const $MenstruationListState = _$MenstruationListStateTearOff();

/// @nodoc
mixin _$MenstruationListState {
  bool get isNotYetLoaded => throw _privateConstructorUsedError;
  List<MenstruationHistoryRowState> get rows =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MenstruationListStateCopyWith<MenstruationListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenstruationListStateCopyWith<$Res> {
  factory $MenstruationListStateCopyWith(MenstruationListState value,
          $Res Function(MenstruationListState) then) =
      _$MenstruationListStateCopyWithImpl<$Res>;
  $Res call({bool isNotYetLoaded, List<MenstruationHistoryRowState> rows});
}

/// @nodoc
class _$MenstruationListStateCopyWithImpl<$Res>
    implements $MenstruationListStateCopyWith<$Res> {
  _$MenstruationListStateCopyWithImpl(this._value, this._then);

  final MenstruationListState _value;
  // ignore: unused_field
  final $Res Function(MenstruationListState) _then;

  @override
  $Res call({
    Object? isNotYetLoaded = freezed,
    Object? rows = freezed,
  }) {
    return _then(_value.copyWith(
      isNotYetLoaded: isNotYetLoaded == freezed
          ? _value.isNotYetLoaded
          : isNotYetLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      rows: rows == freezed
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<MenstruationHistoryRowState>,
    ));
  }
}

/// @nodoc
abstract class _$MenstruationListStateCopyWith<$Res>
    implements $MenstruationListStateCopyWith<$Res> {
  factory _$MenstruationListStateCopyWith(_MenstruationListState value,
          $Res Function(_MenstruationListState) then) =
      __$MenstruationListStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isNotYetLoaded, List<MenstruationHistoryRowState> rows});
}

/// @nodoc
class __$MenstruationListStateCopyWithImpl<$Res>
    extends _$MenstruationListStateCopyWithImpl<$Res>
    implements _$MenstruationListStateCopyWith<$Res> {
  __$MenstruationListStateCopyWithImpl(_MenstruationListState _value,
      $Res Function(_MenstruationListState) _then)
      : super(_value, (v) => _then(v as _MenstruationListState));

  @override
  _MenstruationListState get _value => super._value as _MenstruationListState;

  @override
  $Res call({
    Object? isNotYetLoaded = freezed,
    Object? rows = freezed,
  }) {
    return _then(_MenstruationListState(
      isNotYetLoaded: isNotYetLoaded == freezed
          ? _value.isNotYetLoaded
          : isNotYetLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      rows: rows == freezed
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<MenstruationHistoryRowState>,
    ));
  }
}

/// @nodoc
class _$_MenstruationListState extends _MenstruationListState {
  _$_MenstruationListState({this.isNotYetLoaded = true, this.rows = const []})
      : super._();

  @JsonKey(defaultValue: true)
  @override
  final bool isNotYetLoaded;
  @JsonKey(defaultValue: const [])
  @override
  final List<MenstruationHistoryRowState> rows;

  @override
  String toString() {
    return 'MenstruationListState(isNotYetLoaded: $isNotYetLoaded, rows: $rows)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MenstruationListState &&
            (identical(other.isNotYetLoaded, isNotYetLoaded) ||
                const DeepCollectionEquality()
                    .equals(other.isNotYetLoaded, isNotYetLoaded)) &&
            (identical(other.rows, rows) ||
                const DeepCollectionEquality().equals(other.rows, rows)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isNotYetLoaded) ^
      const DeepCollectionEquality().hash(rows);

  @JsonKey(ignore: true)
  @override
  _$MenstruationListStateCopyWith<_MenstruationListState> get copyWith =>
      __$MenstruationListStateCopyWithImpl<_MenstruationListState>(
          this, _$identity);
}

abstract class _MenstruationListState extends MenstruationListState {
  factory _MenstruationListState(
      {bool isNotYetLoaded,
      List<MenstruationHistoryRowState> rows}) = _$_MenstruationListState;
  _MenstruationListState._() : super._();

  @override
  bool get isNotYetLoaded => throw _privateConstructorUsedError;
  @override
  List<MenstruationHistoryRowState> get rows =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MenstruationListStateCopyWith<_MenstruationListState> get copyWith =>
      throw _privateConstructorUsedError;
}
