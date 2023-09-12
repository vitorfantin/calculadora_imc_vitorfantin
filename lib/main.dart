import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculadoraIMCVF(),
  ));
}

class CalculadoraIMCVF extends StatefulWidget {
  const CalculadoraIMCVF({super.key});

  @override
  State<CalculadoraIMCVF> createState() => _CalculadoraIMCVFState();
}

class _CalculadoraIMCVFState extends State<CalculadoraIMCVF> {
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();
  String resultado = "Insira as informações acima !";
  final _formKey = GlobalKey<FormState>();
  void limparCampos() {
    setState(() {
      alturaController.text = "";
      pesoController.text = "";
      resultado = "Insira as informações acima !";
    });
  }

  void calcularIMC() {
    double altura = double.parse(alturaController.text) / 100;
    double peso = double.parse(pesoController.text);
    setState(() {
      double resultadoImc = peso / (altura * altura);

      if (resultadoImc <= 18.5) {
        resultado =
            ("Seu IMC é : ${resultadoImc.toStringAsFixed(2)} , portanto o estado é de MAGREZA");
      } else if (resultadoImc > 18.5 && resultadoImc <= 24.9) {
        resultado =
            ("Seu IMC é : ${resultadoImc.toStringAsFixed(2)} , portanto o estado é de NORMAL");
      } else if (resultadoImc >= 25 && resultadoImc <= 29.9) {
        resultado =
            ("Seu IMC é : ${resultadoImc.toStringAsFixed(2)} , portanto o estado é de SOBREPESO");
      } else if (resultadoImc >= 30 && resultadoImc <= 34.9) {
        resultado =
            ("Seu IMC é : ${resultadoImc.toStringAsFixed(2)} , portanto o estado é de OBESIDADE GRAU I");
      } else if (resultadoImc >= 35 && resultadoImc <= 39.9) {
        resultado =
            ("Seu IMC é : ${resultadoImc.toStringAsFixed(2)} , portanto o estado é de OBESIDADE GRAU II");
      } else if (resultadoImc >= 40) {
        resultado =
            ("Seu IMC é : ${resultadoImc.toStringAsFixed(2)} , portanto o estado é de OBESIDADE GRAU III");
      } else {
        resultado = ("Refaz o teste !");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC VF"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            campoDeEscrita("Altura", "CM", alturaController),
            const SizedBox(
              height: 20,
            ),
            campoDeEscrita("Peso", "Kg", pesoController),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calcularIMC();
                  }
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(0, 50)),
                child: const Text(
                  "Calcular",
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: limparCampos,
                style: ElevatedButton.styleFrom(fixedSize: const Size(0, 50)),
                child: const Text(
                  "RESET",
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            Text(resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}

Widget campoDeEscrita(
    String label, String suffix, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      suffixText: suffix,
    ),
    validator: (valor) {
      if (valor == null || valor.isEmpty) {
        if (label == "Altura") {
          return "Coloque sua Altura em CM";
        } else if (label == "Peso") {
          return "Coloque sua Peso em Kg";
        } else {
          return "Ocorreu alguma coisa de errado !";
        }
      }
      return null;
    },
  );
}
