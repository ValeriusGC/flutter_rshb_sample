import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'core/api/remote_provider.dart';
import 'core/api/remote_stub_provider_impl.dart';
import 'core/db/local_hive_storage_impl.dart';
import 'core/db/local_storage.dart';
import 'core/model/catalog_model.dart';
import 'ui/catalog_page/catalog_page_view_model.dart';
import 'ui/main_page/main_page_view_model.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<RemoteProvider>(() => RemoteStubProviderImpl());
  getIt.registerLazySingleton<MainPageViewModel>(() => MainPageViewModel());
  getIt.registerLazySingleton<CatalogPageViewModel>(() => CatalogPageViewModel());
  getIt.registerLazySingleton<CatalogModel>(() => CatalogModel());
  getIt.registerSingletonAsync<LocalStorage>(() async {
    final o = LocalHiveStorageImpl();
    final path = (await getApplicationDocumentsDirectory()).path;
    await o.init(path);
    return o;
  });
}

// ignore: non_constant_identifier_names
final TheRemoteProvider = getIt<RemoteProvider>();

// ignore: non_constant_identifier_names
final TheMainPageViewModel = getIt<MainPageViewModel>();

// ignore: non_constant_identifier_names
final TheCatalogPageViewModel = getIt<CatalogPageViewModel>();

// ignore: non_constant_identifier_names
final TheCatalogModel = getIt<CatalogModel>();

// ignore: non_constant_identifier_names
final TheLocalStorage = getIt<LocalStorage>();

