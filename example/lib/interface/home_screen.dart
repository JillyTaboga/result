import 'package:example/core/number_formatters.dart';
import 'package:example/models/adress_model.dart';
import 'package:example/services/cep_service.dart';
import 'package:example/services/viacep_service.dart';
import 'package:flutter/material.dart';
import 'package:result/serviceresult.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CepService cepService = ViaCepService();
  AdressModel adressModel;
  bool loading = false;
  TextEditingController cepController;

  @override
  void initState() {
    super.initState();
    cepController = TextEditingController();
  }

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  _searchAdress(String cep) async {
    FocusScope.of(context).unfocus();
    setState(() {
      loading = true;
      cepController.clear();
      adressModel = null;
    });

    ///A classe result faz o intermédio para que um retorno de um service possa receber o dado ou um erro
    ///Na tela pode ser usado os métodos successWithWarning para atribuir uma ação facilmente ou mostrar uma mensagem de erro
    Result<AdressModel> result = await cepService.getAdress(cep);
    result.successWithWarning(
      context: context,
      onSuccess: (data) {
        setState(() {
          adressModel = data;
        });
      },
    );
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: TextField(
              inputFormatters: [
                CepInputFormatter(),
              ],
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CEP:',
              ),
              onSubmitted: (value) => _searchAdress(value),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            child: loading
                ? Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text('Search'),
            onPressed: () => _searchAdress(cepController.text),
          ),
          SizedBox(
            height: 15,
          ),
          adressModel == null
              ? Center(
                  child: Container(
                    height: 65,
                    width: 35,
                  ),
                )
              : Center(
                  child: Text(
                    adressModel.toString(),
                  ),
                ),
        ],
      ),
    );
  }
}
