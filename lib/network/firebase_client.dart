// *  Not needed as of now
import 'index.dart';

// /// Doesn't support non dart data mod
class FirebaseClient implements IClient {
  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath,
      {bool customHeaders}) async {
    return null;
//
//    if (T.runtimeType == SpeakersData) {
//      return MappedNetworkServiceResponse<T>(
//        networkServiceResponse: NetworkServiceResponse<T>(success: true, content: await FirebaseRepository().speakers())
//      );
//    } else
//      return MockClient().getAsync(resourcePath);
//
//    if (resourcePath == HomeProvider.kConstGetTeamsUrl) {}
//
//    if (resourcePath == HomeProvider.kConstGetFirstDaySessionsUrl) {}
//
//    if (resourcePath == HomeProvider.kConstGetSecondDaySessionsUrl) {}
  }

  @override
  Future<MappedNetworkServiceResponse<T>> postAsync<T>(
      String resourcePath, data,
      {bool customHeaders = false}) {
    return null;
  }
}
