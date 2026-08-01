class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Storage for dependencies
  final Map<Type, dynamic> _services = {};
  final Map<String, dynamic> _namedServices = {};

  /// Get service by type. Pass [name] for named registrations.
  T get<T>({String? name}) {
    if (name != null) {
      final key = '${T}_$name';
      final service = _namedServices[key];
      if (service == null) {
        throw Exception('Named service of type $T with name "$name" is not registered');
      }
      return service as T;
    }
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T is not registered');
    }
    return service as T;
  }

  /// Register service. Pass [name] for named registrations.
  void register<T>(T service, {String? name}) {
    if (name != null) {
      _namedServices['${T}_$name'] = service;
    } else {
      _services[T] = service;
    }
  }

  /// Check if service is registered
  bool isRegistered<T>({String? name}) {
    if (name != null) {
      return _namedServices.containsKey('${T}_$name');
    }
    return _services.containsKey(T);
  }

  /// Unregister service
  void unregister<T>({String? name}) {
    if (name != null) {
      _namedServices.remove('${T}_$name');
    } else {
      _services.remove(T);
    }
  }

  /// Reset all services
  void reset() {
    _services.clear();
    _namedServices.clear();
  }
}

/// Global accessor for the [ServiceLocator] singleton.
///
/// Use `sl.get<T>()` instead of `ServiceLocator().get<T>()` for clarity —
/// the pattern makes it obvious you're accessing a shared singleton, not
/// creating a new instance.
///
/// ```dart
/// final useCase = sl.get<GetVehiclesUseCase>();
/// ```
ServiceLocator get sl => ServiceLocator();
