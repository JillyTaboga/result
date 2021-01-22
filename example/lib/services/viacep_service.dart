import 'package:dio/dio.dart';
import 'package:example/models/adress_model.dart';
import 'package:example/services/cep_service.dart';
import 'package:result/serviceresult.dart';

class ViaCepService implements CepService {
  ViaCepService() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
      ),
    );
  }
  final String url = 'https://viacep.com.br/ws/';
  final String format = '/json/';
  Dio dio;

  @override
  Future<Result<AdressModel>> getAdress(String cep) async {
    String clearedCep = cep.replaceAll(RegExp("[^0-9]"), '');
    try {
      Response response = await dio.get(clearedCep + format);
      return Result.success(AdressModel.fromMap(response.data));
    } catch (e) {
      print(e);
      if (e is DioError) {
        if (e.response.statusCode == 400) {
          return Result.error(BadRequestError());
        }
      }
      return Result.errorMessage(message: e.toString());
    }
  }
}

class BadRequestError extends ResultError {
  BadRequestError()
      : super(
          message: 'Cep mal formulado',
          description: 'Preencha um CEP válido com 8 dígitos',
          cod: '1',
        );
}
