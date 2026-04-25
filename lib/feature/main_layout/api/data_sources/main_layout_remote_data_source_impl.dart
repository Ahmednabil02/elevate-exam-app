
import 'package:exam_app/config/api/api_execute.dart';
import 'package:exam_app/config/base_response/result.dart';
import '../../data/data_sources/main_layout_remote_data_source_contract.dart';
import '../api_client/main_layout_api_client.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: MainLayoutRemoteDataSourceContract)
class MainLayoutRemoteDataSourceImpl
    implements MainLayoutRemoteDataSourceContract {
  final MainLayoutApiClient _mainLayoutApiClient;
  const MainLayoutRemoteDataSourceImpl(this._mainLayoutApiClient);
  @override
  Future<Result<void>> logout() async {
    return await executeApi<void>(() async {
      return await _mainLayoutApiClient.logout();
    });
  }
}
