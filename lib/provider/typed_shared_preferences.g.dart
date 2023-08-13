// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typed_shared_preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boolSharedPreferencesHash() =>
    r'ccad60dbd5ace6ca5aafeef66063aa8411476d64';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BoolSharedPreferences
    extends BuildlessAutoDisposeNotifier<SharedPreferencesState<bool?>> {
  late final String key;

  SharedPreferencesState<bool?> build(
    String key,
  );
}

/// See also [BoolSharedPreferences].
@ProviderFor(BoolSharedPreferences)
const boolSharedPreferencesProvider = BoolSharedPreferencesFamily();

/// See also [BoolSharedPreferences].
class BoolSharedPreferencesFamily
    extends Family<SharedPreferencesState<bool?>> {
  /// See also [BoolSharedPreferences].
  const BoolSharedPreferencesFamily();

  /// See also [BoolSharedPreferences].
  BoolSharedPreferencesProvider call(
    String key,
  ) {
    return BoolSharedPreferencesProvider(
      key,
    );
  }

  @override
  BoolSharedPreferencesProvider getProviderOverride(
    covariant BoolSharedPreferencesProvider provider,
  ) {
    return call(
      provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'boolSharedPreferencesProvider';
}

/// See also [BoolSharedPreferences].
class BoolSharedPreferencesProvider extends AutoDisposeNotifierProviderImpl<
    BoolSharedPreferences, SharedPreferencesState<bool?>> {
  /// See also [BoolSharedPreferences].
  BoolSharedPreferencesProvider(
    this.key,
  ) : super.internal(
          () => BoolSharedPreferences()..key = key,
          from: boolSharedPreferencesProvider,
          name: r'boolSharedPreferencesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boolSharedPreferencesHash,
          dependencies: BoolSharedPreferencesFamily._dependencies,
          allTransitiveDependencies:
              BoolSharedPreferencesFamily._allTransitiveDependencies,
        );

  final String key;

  @override
  bool operator ==(Object other) {
    return other is BoolSharedPreferencesProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  SharedPreferencesState<bool?> runNotifierBuild(
    covariant BoolSharedPreferences notifier,
  ) {
    return notifier.build(
      key,
    );
  }
}

String _$intSharedPreferencesHash() =>
    r'3bfeb89cf1754ffe8a7d99020d529839b538f6ea';

abstract class _$IntSharedPreferences
    extends BuildlessAutoDisposeNotifier<SharedPreferencesState<int?>> {
  late final String key;

  SharedPreferencesState<int?> build(
    String key,
  );
}

/// See also [IntSharedPreferences].
@ProviderFor(IntSharedPreferences)
const intSharedPreferencesProvider = IntSharedPreferencesFamily();

/// See also [IntSharedPreferences].
class IntSharedPreferencesFamily extends Family<SharedPreferencesState<int?>> {
  /// See also [IntSharedPreferences].
  const IntSharedPreferencesFamily();

  /// See also [IntSharedPreferences].
  IntSharedPreferencesProvider call(
    String key,
  ) {
    return IntSharedPreferencesProvider(
      key,
    );
  }

  @override
  IntSharedPreferencesProvider getProviderOverride(
    covariant IntSharedPreferencesProvider provider,
  ) {
    return call(
      provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'intSharedPreferencesProvider';
}

/// See also [IntSharedPreferences].
class IntSharedPreferencesProvider extends AutoDisposeNotifierProviderImpl<
    IntSharedPreferences, SharedPreferencesState<int?>> {
  /// See also [IntSharedPreferences].
  IntSharedPreferencesProvider(
    this.key,
  ) : super.internal(
          () => IntSharedPreferences()..key = key,
          from: intSharedPreferencesProvider,
          name: r'intSharedPreferencesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$intSharedPreferencesHash,
          dependencies: IntSharedPreferencesFamily._dependencies,
          allTransitiveDependencies:
              IntSharedPreferencesFamily._allTransitiveDependencies,
        );

  final String key;

  @override
  bool operator ==(Object other) {
    return other is IntSharedPreferencesProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  SharedPreferencesState<int?> runNotifierBuild(
    covariant IntSharedPreferences notifier,
  ) {
    return notifier.build(
      key,
    );
  }
}

String _$stringSharedPreferencesHash() =>
    r'64324e1c569548b239a77a46841a381efd872a98';

abstract class _$StringSharedPreferences
    extends BuildlessAutoDisposeNotifier<SharedPreferencesState<String?>> {
  late final String key;

  SharedPreferencesState<String?> build(
    String key,
  );
}

/// See also [StringSharedPreferences].
@ProviderFor(StringSharedPreferences)
const stringSharedPreferencesProvider = StringSharedPreferencesFamily();

/// See also [StringSharedPreferences].
class StringSharedPreferencesFamily
    extends Family<SharedPreferencesState<String?>> {
  /// See also [StringSharedPreferences].
  const StringSharedPreferencesFamily();

  /// See also [StringSharedPreferences].
  StringSharedPreferencesProvider call(
    String key,
  ) {
    return StringSharedPreferencesProvider(
      key,
    );
  }

  @override
  StringSharedPreferencesProvider getProviderOverride(
    covariant StringSharedPreferencesProvider provider,
  ) {
    return call(
      provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stringSharedPreferencesProvider';
}

/// See also [StringSharedPreferences].
class StringSharedPreferencesProvider extends AutoDisposeNotifierProviderImpl<
    StringSharedPreferences, SharedPreferencesState<String?>> {
  /// See also [StringSharedPreferences].
  StringSharedPreferencesProvider(
    this.key,
  ) : super.internal(
          () => StringSharedPreferences()..key = key,
          from: stringSharedPreferencesProvider,
          name: r'stringSharedPreferencesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stringSharedPreferencesHash,
          dependencies: StringSharedPreferencesFamily._dependencies,
          allTransitiveDependencies:
              StringSharedPreferencesFamily._allTransitiveDependencies,
        );

  final String key;

  @override
  bool operator ==(Object other) {
    return other is StringSharedPreferencesProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  SharedPreferencesState<String?> runNotifierBuild(
    covariant StringSharedPreferences notifier,
  ) {
    return notifier.build(
      key,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
