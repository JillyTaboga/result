import 'package:example/models/adress_model.dart';
import 'package:result/serviceresult.dart';

abstract class CepService {
  Future<Result<AdressModel>> getAdress(String cep);
}
