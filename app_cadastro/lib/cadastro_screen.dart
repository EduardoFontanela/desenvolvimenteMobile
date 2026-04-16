import 'package:flutter/material.dart';
import 'confirmacao_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _sexoSelecionado;
  bool _termosAceitos = false;

  final List<String> _opcoesSexo = ['Masculino', 'Feminino', 'Outro'];

  void _validarECadastrar() {
    final nome = _nomeController.text.trim();
    final idadeStr = _idadeController.text.trim();
    final email = _emailController.text.trim();

    if (nome.isEmpty) {
      _mostrarErro('O nome não pode ser vazio.');
      return;
    }

    if (idadeStr.isEmpty) {
      _mostrarErro('A idade não pode ser vazia.');
      return;
    }

    int? idade;
    try {
      idade = int.parse(idadeStr);
      if (idade < 18) {
        _mostrarErro('A idade deve ser maior ou igual a 18.');
        return;
      }
    } catch (e) {
      _mostrarErro('A idade deve ser um número válido.');
      return;
    }

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _mostrarErro('Informe um e-mail válido.');
      return;
    }

    if (_sexoSelecionado == null) {
      _mostrarErro('Selecione o seu sexo.');
      return;
    }

    if (!_termosAceitos) {
      _mostrarErro('Você deve aceitar os termos de uso.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmacaoScreen(
          nome: nome,
          idade: idade!,
          email: email,
          sexo: _sexoSelecionado!,
          termosAceitos: _termosAceitos,
        ),
      ),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Preencha os campos abaixo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nomeController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Idade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexoSelecionado,
                hint: const Text('Selecione o Sexo'),
                decoration: InputDecoration(
                  labelText: 'Sexo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _opcoesSexo.map((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
                onChanged: (String? novoValor) {
                  setState(() {
                    _sexoSelecionado = novoValor;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _termosAceitos,
                    activeColor: Colors.blue,
                    onChanged: (bool? valor) {
                      setState(() {
                        _termosAceitos = valor ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Aceito os termos de uso',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _validarECadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}