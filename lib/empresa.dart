import 'dart:convert';
import 'dart:io';
import 'verificacao.dart';

import 'endereco.dart';
import 'package:uuid/uuid.dart';

class Empresa extends Endereco {
  String? id;
  String? cnpj;
  String? razaoSocial;
  String? nomeFantasia;
  String? telefone;
  DateTime? horaCadastro;

  void cadastrarEmpresa(Empresa empresa) {
    id = Uuid().v1();
    print("Digite o CNPJ da empresa (apenas os números):");
    cnpj = stdin.readLineSync(encoding: utf8);
    cnpj = Verifica.verificaEntradaCNPJ(cnpj!);

    print("Digite a razão social");
    razaoSocial = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(razaoSocial!);

    print("Digite o nome fantasia:");
    nomeFantasia = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(nomeFantasia!);

    print("Digite o telefone (apenas os números):");
    telefone = stdin.readLineSync(encoding: utf8);
    telefone = Verifica.verificaEntradaTelefone(telefone!);

    horaCadastro = DateTime.now();

    empresa.cadastraEndereco();
  }
}
