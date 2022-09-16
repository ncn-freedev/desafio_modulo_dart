import 'dart:convert';
import 'dart:io';

import 'endereco.dart';
import 'verificacao.dart';

class Pessoa extends Endereco {
  bool? pessoafisica;
  String? codigo;
  String? nome;
  String? razaoSocial;
  String? nomeFantasia;

  void cadastrarSocio(Pessoa socio) {
    print("Digite o nome do sócio:");
    nome = stdin.readLineSync(encoding: utf8)!;
    Verifica.verificaEntradaVazia(nome!);

    socio.cadastraEndereco();
  }
}
