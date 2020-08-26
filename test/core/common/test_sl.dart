import 'package:frshbsample/core/api/remote_provider.dart';
import 'package:frshbsample/core/api/remote_stub_provider_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

///
void setupGetIt() {
  getIt.registerLazySingleton<RemoteProvider>(() => RemoteStubProviderImpl());
}

// ignore: non_constant_identifier_names
final TestRemoteProvider = getIt<RemoteProvider>();

