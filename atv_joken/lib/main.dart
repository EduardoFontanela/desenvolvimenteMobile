import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Jogo(),
  ));
}

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var imagemApp = AssetImage("images/padrao.png");
  var imagemResultado = AssetImage("images/padrao.png");
  var mensagem = "Escolha uma opção abaixo";

  void reiniciar() {
    setState(() {
      imagemApp = AssetImage("images/padrao.png");
      imagemResultado = AssetImage("images/padrao.png");
      mensagem = "Escolha uma opção abaixo";
    });
  }

  void jogar(String escolhaDoUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaDoApp = opcoes[numero];

    setState(() {
      imagemApp = AssetImage("images/" + escolhaDoApp + ".png");
    });

    if (escolhaDoUsuario == escolhaDoApp) {
      setState(() {
        mensagem = "Empatamos!";
        imagemResultado = AssetImage("images/empate.png");
      });
    } else if (
    (escolhaDoUsuario == "pedra" && escolhaDoApp == "tesoura") ||
        (escolhaDoUsuario == "papel" && escolhaDoApp == "pedra") ||
        (escolhaDoUsuario == "tesoura" && escolhaDoApp == "papel")
    ) {
      setState(() {
        mensagem = "Você Venceu!";
        imagemResultado = AssetImage("images/venceu.png");
      });
    } else {
      setState(() {
        mensagem = "Você Perdeu!";
        imagemResultado = AssetImage("images/perdeu.png");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedra, Papel, Tesoura", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text("Escolha do App:", style: TextStyle(fontSize: 20)),
            ),
            Image(image: imagemApp, height: 100),

            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text(mensagem, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Image(image: imagemResultado, height: 100),

            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text("Sua vez:", style: TextStyle(fontSize: 18)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: () => jogar("pedra"), child: Image.asset("images/pedra.png", height: 70)),
                GestureDetector(onTap: () => jogar("papel"), child: Image.asset("images/papel.png", height: 70)),
                GestureDetector(onTap: () => jogar("tesoura"), child: Image.asset("images/tesoura.png", height: 70)),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 40),
              child: ElevatedButton(
                onPressed: reiniciar,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Jogar Novamente", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}