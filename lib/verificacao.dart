import 'dart:convert';
import 'dart:io';
import 'dart:core';

import 'empresa.dart';
import 'lista_empresa.dart';
import 'pessoa.dart';

abstract class Verifica {
  static String verificaEntradaVazia(String entrada) {
    if (entrada.isEmpty) {
      print("Você deve digitar um valor válido! Por favor tente novamente:");
      String saida = stdin.readLineSync()!;
      verificaEntradaVazia(saida);
      return "";
    } else {
      return entrada;
    }
  }

  static String verificaEntradaCNPJ(String cnpj) {
    final pattern = RegExp(r'^[0-9]{14,14}$');
    cnpj = verificaEntradaVazia(cnpj);
    if (pattern.hasMatch(cnpj)) {
      return cnpj;
    } else {
      print(
          "Você não digitou o CNPJ no padrão exigido. Você deve digitar 14 números referentes ao CNPJ sem pontos e traços!");
      print("Por favor, tente novamente:");
      String novaTentativa = stdin.readLineSync(encoding: utf8)!;
      return verificaEntradaCNPJ(novaTentativa);
    }
  }

  static String verificaEntradaCPF(String cpf) {
    verificaEntradaVazia(cpf);
    final pattern = RegExp(r'^[0-9]{11,11}$');
    cpf = verificaEntradaVazia(cpf);
    if (pattern.hasMatch(cpf)) {
      return cpf;
    } else {
      print(
          "Você não digitou o CPF no padrão exigido. Você deve digitar 11 números referentes ao CPF sem pontos e traços!");
      print("Por favor, tente novamente:");
      String novaTentativa = stdin.readLineSync(encoding: utf8)!;
      return verificaEntradaCPF(novaTentativa);
    }
  }

  static String verificaEntradaTelefone(String telefone) {
    verificaEntradaVazia(telefone);
    final pattern = RegExp(r'^[0-9]{11,11}$');
    telefone = verificaEntradaVazia(telefone);
    if (pattern.hasMatch(telefone)) {
      return telefone;
    } else {
      print(
          "Você não digitou o telefone no padrão exigido. Você deve digitar 11 números referentes ao código de área e telefone!");
      print("Por favor, tente novamente:");
      String novaTentativa = stdin.readLineSync(encoding: utf8)!;
      return verificaEntradaTelefone(novaTentativa);
    }
  }

  static String verificaEntradaCEP(String cep) {
    verificaEntradaVazia(cep);
    final pattern = RegExp(r'^[0-9]{8,8}$');
    cep = verificaEntradaVazia(cep);
    if (pattern.hasMatch(cep)) {
      return cep;
    } else {
      print(
          "Você não digitou o CEP no padrão exigido. Você deve digitar 8 números referentes ao CEP sem pontos e traços!");
      print("");
      print("Por favor, tente novamente:");
      print("");
      String novaTentativa = stdin.readLineSync(encoding: utf8)!;
      return verificaEntradaCEP(novaTentativa);
    }
  }

  static bool verificaPessoa() {
    print(
        "Caso o sócio seja uma pessoa física digite F, caso seja uma pessoa J digite J:");
    String temp = stdin.readLineSync(encoding: utf8)!;
    while (temp != "F" && temp != "J" && temp != "f" && temp != "j") {
      print("Por favor, digite F ou J");
      temp = stdin.readLineSync(encoding: utf8)!;
    }
    if (temp == "F" || temp == "f") {
      return true;
    } else {
      return false;
    }
  }

  static void verificaSocio(Pessoa socio, Empresa empresa) {
    socio.pessoafisica = Verifica.verificaPessoa();
    if (socio.pessoafisica == true) {
      print("Digite o CPF do sócio (apenas os números):");
      socio.codigo = stdin.readLineSync(encoding: utf8)!;
      socio.codigo = Verifica.verificaEntradaCPF(socio.codigo!);
    } else {
      print("Digite o CNPJ do sócio (apenas os números):");
      socio.codigo = stdin.readLineSync(encoding: utf8)!;
      socio.codigo = Verifica.verificaEntradaCNPJ(socio.codigo!);
    }
    if (ListaEmpresas.listaSocios.contains(socio.codigo)) {
      print("Sócio já está cadastrado!");
      print(
          "Desaja cadastrar esta empresa a este sócio? Digite S para sim ou N para não.");
      String resposta = stdin.readLineSync(encoding: utf8)!;
      if (resposta == "S" || resposta == "s") {
        ListaEmpresas.cadastrarEmpresaAoSocio(socio, empresa);
      } else if ((resposta == "N" || resposta == "n")) {
        print("Você NÃO adicionou outra empresa a este sócio!");
        ListaEmpresas.excluirEmpresaPorId(empresa.id!);
        print(
            "A empresa precisa ter um sócio. Por favor verifique os dados e refaça o cadastro da empresa!");
      }
    } else {
      socio.cadastrarSocio(socio);
      ListaEmpresas.addSocio(socio, empresa);
    }
  }
}
