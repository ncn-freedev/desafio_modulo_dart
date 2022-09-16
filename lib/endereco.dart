import 'dart:convert';
import 'dart:io';

import 'verificacao.dart';

abstract class Endereco {
  String? logradouro;
  String? numeroResidencia;
  String? complemento;
  String? bairro;
  String? cidadeuf;
  String? cep;

  void cadastraEndereco() {
    print("Digite o logradouro:");
    logradouro = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(logradouro!);

    print("Digite o número da residência:");
    numeroResidencia = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(numeroResidencia!);

    print("Digite o complemento:");
    complemento = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(complemento!);

    print("Digite o bairro");
    bairro = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(bairro!);

    print("Digite o cidade/UF:");
    cidadeuf = stdin.readLineSync(encoding: utf8);
    Verifica.verificaEntradaVazia(cidadeuf!);

    print("Digite o CEP (apenas os números):");
    cep = stdin.readLineSync(encoding: utf8);
    cep = Verifica.verificaEntradaCEP(cep!);
  }
}
