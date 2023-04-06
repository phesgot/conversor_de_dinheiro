import 'package:conversor_de_dinheiro/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import '../service/finance.dart';

final data = finance();

class Conversor extends StatelessWidget {
  Conversor({Key? key}) : super(key: key);

  final TextEditingController controllerReais = TextEditingController();
  final TextEditingController controllerDolares = TextEditingController();
  final TextEditingController controllerEuros = TextEditingController();

  final String labelReais = 'Reais';
  final String labelDolar = 'Dólares';
  final String labelEuro = 'Euros';
  final String prefixoReais = 'R\$';
  final String prefixoDolares = 'US\$';
  final String prefixoEuros = '€';

  double? dolar;
  double? euro;

  void _clearAll() {
    controllerReais.text = "";
    controllerDolares.text = "";
    controllerEuros.text = "";
  }

  void realChanged(String text){
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    controllerDolares.text = (real / dolar!).toStringAsFixed(2);
    controllerEuros.text = (real / euro!).toStringAsFixed(2);
  }
  void dolarChanged(String text){
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    controllerReais.text = (dolar * this.dolar!).toStringAsFixed(2);
    controllerEuros.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }
  void euroChanged(String text){
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    controllerReais.text = (euro * this.euro!).toStringAsFixed(2);
    controllerDolares.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text(
          '\$Conversor\$',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
        future: data.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  'Carregando Dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar dados :(',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                 dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                 euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 180,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      buildTextField(
                        label: labelReais,
                        prefix: prefixoReais,
                        controller: controllerReais,
                        changed: realChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        label: labelDolar,
                        prefix: prefixoDolares,
                        controller: controllerDolares,
                        changed: dolarChanged,

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        label: labelEuro,
                        prefix: prefixoEuros,
                        controller: controllerEuros,
                        changed: euroChanged,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}