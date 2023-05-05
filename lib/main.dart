import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Imc(),
    debugShowCheckedModeBanner: false,
  )
  );
}

class Imc extends StatefulWidget {
  const Imc({ Key? key }) : super(key: key);

  @override
  _ImcState createState() => _ImcState();
}

class _ImcState extends State<Imc> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String infor = "Informe seus dados!";
  GlobalKey <FormState> formkey = GlobalKey<FormState>();

  void resetCampos(){
    pesoController.text="";
    alturaController.text="";
    infor = "Informe seus dados!";
  }

  void calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      //print(imc);
      if (imc < 18.5) {
        infor = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 18.5 && imc <= 24.9) {
        infor = "Peso normal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc <= 29.9) {
        infor = "Sobrepeso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc <= 34.9) {
        infor = "Obesidade grau 1 (${imc.toStringAsPrecision(3)})";
      } else {
        infor = "Obesidade grau 2 (${imc.toStringAsPrecision(3)})";
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        backgroundColor: Color.fromARGB(255, 76, 102, 175),
        centerTitle: true,
        actions: [
            IconButton(onPressed: (){resetCampos();}, icon: Icon(Icons.refresh))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
        key: formkey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.person_outline, size: 120, color:Color.fromARGB(255, 76, 102, 175),),
          TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Peso (kg)",
            labelStyle: TextStyle(color: Color.fromARGB(255, 76, 102, 175))
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 76, 102, 175), fontSize: 25),
          controller: pesoController,
          validator: (value){
            if (value == null || value.isEmpty){
              return 'Insira seu peso';
            }
            return null;
          },
          ),

          TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Altura (cm)",
            labelStyle: TextStyle(color: Color.fromARGB(255, 76, 102, 175))
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 76, 102, 175), fontSize: 25),
          controller: alturaController,
          validator: (value){
            if (value == null || value.isEmpty){
              return 'Insira sua altura';
            }
            return null;
          },
          ),

          ElevatedButton(
          onPressed: (){
            if(formkey.currentState!.validate()){
              calcular();
            }
          },
          child: Text('Calcular'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 76, 102, 175),
            textStyle: const TextStyle(color: Colors.white, fontSize: 25)
          )
          ),

          Text(infor,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 76, 102, 175), fontSize: 25),
          )
        ],
      ),)
      )
    );
  }
}