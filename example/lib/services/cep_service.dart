import 'package:example/models/adress_model.dart';
import 'package:result/result.dart';

abstract class CepService {
  Future<Result<AdressModel>> getAdress(String cep);
}
