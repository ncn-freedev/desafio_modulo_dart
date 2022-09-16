import 'dart:convert';
import 'dart:io';

import 'package:desafio_modulo_dart/empresa.dart';
import 'package:desafio_modulo_dart/lista_empresa.dart';
import 'package:desafio_modulo_dart/pessoa.dart';
import 'package:desafio_modulo_dart/verificacao.dart';

void main(List<String> arguments) {
  limparTerminal();
  int escolha = 0;
  while (escolha != 6) {
    print('''
    1 - Cadastrar uma nova empresa;
    2 - Buscar Empresa cadastrada por CNPJ;
    3 - Buscar Empresa por CPF/CNPJ do Sócio;
    4 - Listar Empresas cadastradas em ordem alfabética (baseado na Razão Social);
    5 - Excluir uma empresa (por ID);
    6 - Sair.''');
    print("Selecione a opção desejada:");
    escolha = int.parse(stdin.readLineSync()!);

    switch (escolha) {
      case 1:
        limparTerminal();
        print("Você escolheu a opção 1.");
        Empresa empresa = Empresa();
        empresa.cadastrarEmpresa(empresa);
        bool cadastro = ListaEmpresas.addEmpresa(empresa);
        if (cadastro) {
          print("Agora vamos cadastrar o sócio referente a esta empresa!");
          Pessoa socio = Pessoa();
          Verifica.verificaSocio(socio, empresa);
          break;
        } else {
          limparTerminal();
          print("Empresa já cadastrada. Por favor verifique os dados!");
          sleep(Duration(seconds: 2));
          break;
        }

      case 2:
        limparTerminal();
        print("Você escolheu a opção 2.");
        print("Qual o CNPJ você deseja procurar?");
        String cnpjProcurado = stdin.readLineSync(encoding: utf8)!;
        cnpjProcurado = Verifica.verificaEntradaCNPJ(cnpjProcurado);
        bool? procuraEmpresa =
            ListaEmpresas.buscarEmpresaPorCNPJ(cnpjProcurado);
        if (procuraEmpresa == null) {
          print("Ainda não há empresas cadastradas!");
        }
        escolha = voltarAoMenu();
        break;

      case 3:
        limparTerminal();
        print("Você escolheu a opção 3.");
        print("Para CPF digite 1. Para CNPJ digite 2:");
        String opcao = stdin.readLineSync(encoding: utf8)!;
        while (opcao != "1" && opcao != "2") {
          print("Você deve digitar 1 ou 2");
          print("Por favor, tente novamente:");
          opcao = stdin.readLineSync(encoding: utf8)!;
        }
        if (opcao == "1") {
          print("Digite o CPF");
          String codigoProcurado = stdin.readLineSync(encoding: utf8)!;
          codigoProcurado = Verifica.verificaEntradaCPF(codigoProcurado);
          ListaEmpresas.buscarEmpresaPorCodigoDoSocio(codigoProcurado);
          escolha = voltarAoMenu();
          break;
        } else {
          print("Digite o CNPJ");
          String codigoProcurado = stdin.readLineSync(encoding: utf8)!;
          codigoProcurado = Verifica.verificaEntradaCNPJ(codigoProcurado);
          ListaEmpresas.buscarEmpresaPorCodigoDoSocio(codigoProcurado);
          escolha = voltarAoMenu();
          break;
        }

      case 4:
        limparTerminal();
        print("Você escolheu a opção 4.");
        ListaEmpresas.mostraEmpresasOrdemAlfabetica();
        break;

      case 5:
        limparTerminal();
        print("Você escolheu a opção 5.");
        print("Qual o ID da empresa que você deseja excluir?");
        String id = stdin.readLineSync(encoding: utf8)!;
        ListaEmpresas.excluirEmpresaPorId(id);
        break;

      case 6:
        escolha = sairDoMenu();
        break;
    }
  }
}

void limparTerminal() {
  ///scriptzinho para limpar o terminal durante a execuação do programa que
  ///peguei em:
  ///https://stackoverflow.com/questions/21269769/clearing-the-terminal-screen-in-a-command-line-dart-app
  if (Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

int voltarAoMenu() {
  print(
      "Para voltar ao menu digite 0. Ou digite qualquer outra tecla para encerrar a sessão!");
  String voltar = stdin.readLineSync()!;
  if (voltar == "0") {
    limparTerminal();
    return 0;
  } else {
    return sairDoMenu();
  }
}

int sairDoMenu() {
  limparTerminal();
  print("Você escolheu a opção 6");
  sleep(Duration(seconds: 2));
  print("Saindo...");
  int escolha = 6;
  return escolha;
}
