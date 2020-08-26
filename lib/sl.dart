import 'package:get_it/get_it.dart';
import 'core/api/remote_provider.dart';
import 'core/api/remote_stub_provider_impl.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<RemoteProvider>(() => RemoteStubProviderImpl());
}

// ignore: non_constant_identifier_names
final TheRemoteProvider = getIt<RemoteProvider>();

