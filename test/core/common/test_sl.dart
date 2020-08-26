import 'package:frshbsample/core/api/remote_provider.dart';
import 'package:frshbsample/core/api/remote_stub_provider_impl.dart';
import 'package:frshbsample/core/db/local_hive_storage_impl.dart';
import 'package:frshbsample/core/db/local_storage.dart';
import 'package:frshbsample/core/model/catalog_model.dart';
import 'package:get_it/get_it.dart';

import 'common.dart';

final getIt = GetIt.instance;

///
void setupGetIt() {
  getIt.registerLazySingleton<RemoteProvider>(() => RemoteStubProviderImpl());
  getIt.registerSingletonAsync<LocalStorage>(() async {
    final o = LocalHiveStorageImpl();
    final path = (await getTempDir()).path;
    await o.init(path);
    return o;
  });
  getIt.registerSingletonWithDependencies<CatalogModel>(() => CatalogModel(),
      dependsOn: [LocalStorage]);

}

// ignore: non_constant_identifier_names
final TestTheRemoteProvider = getIt<RemoteProvider>();

// ignore: non_constant_identifier_names
final TestTheLocalStorage = getIt<LocalStorage>();

// ignore: non_constant_identifier_names
final TestTheCatalogModel = getIt<CatalogModel>();
