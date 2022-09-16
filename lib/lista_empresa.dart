import 'dart:io';
import 'package:desafio_modulo_dart/pessoa.dart';

import 'empresa.dart';
import 'padrao_de_impressao.dart';

abstract class ListaEmpresas {
  static var mapaEmpresas = {};
  static List<String?> listaEmpresas =
      []; //Lista de Strings com as razões sociais das empresas cadastradas
  static var mapaSocio = {};
  static List<String?> listaSocios = [];

  static bool addEmpresa(Empresa empresa) {
    if (mapaEmpresas.containsKey(empresa.razaoSocial)) {
      return false;
    } else {
      mapaEmpresas[empresa.razaoSocial] = {};
      mapaEmpresas[empresa.razaoSocial]["id"] = empresa.id;
      mapaEmpresas[empresa.razaoSocial]["cnpj"] = empresa.cnpj;
      mapaEmpresas[empresa.razaoSocial]["razaoSocial"] = empresa.razaoSocial;
      mapaEmpresas[empresa.razaoSocial]["nomeFantasia"] = empresa.nomeFantasia;
      mapaEmpresas[empresa.razaoSocial]["telefone"] = empresa.telefone;
      mapaEmpresas[empresa.razaoSocial]["logradouroEmpresa"] =
          empresa.logradouro;
      mapaEmpresas[empresa.razaoSocial]["numeroResidenciaEmpresa"] =
          empresa.numeroResidencia;
      mapaEmpresas[empresa.razaoSocial]["complementoEmpresa"] =
          empresa.complemento;
      mapaEmpresas[empresa.razaoSocial]["bairroEmpresa"] = empresa.bairro;
      mapaEmpresas[empresa.razaoSocial]["cidadeufEmpresa"] = empresa.cidadeuf;
      mapaEmpresas[empresa.razaoSocial]["cepEmpresa"] = empresa.cep;
      mapaEmpresas[empresa.razaoSocial]["telefoneEmpresa"] = empresa.telefone;
      mapaEmpresas[empresa.razaoSocial]["horaCadastro"] = empresa.horaCadastro;
      mapaEmpresas[empresa.razaoSocial]["codigoSocio"] = "";
      listaEmpresas.add(empresa.razaoSocial);
      listaEmpresas.sort();
      print("Você adicinou a empresa com sucesso!");
      print('''O ID da empresa cadastrada é ${empresa.id}. 
    Anote pois você precisará dele caso queira excluir a empresa!''');
      sleep(Duration(seconds: 2));
      return true;
    }
  }

  static void addSocio(Pessoa socio, Empresa empresa) {
    mapaSocio[socio.codigo] = {};
    mapaSocio[socio.codigo]["codigoSocio"] = socio.codigo;
    if (socio.pessoafisica == false) {
      mapaSocio[socio.codigo]["razaoSocial"] = socio.razaoSocial;
      mapaSocio[socio.codigo]["nomeFantasia"] = socio.nomeFantasia;
    } else {
      mapaSocio[socio.codigo]["nome"] = socio.nome;
    }
    mapaSocio[socio.codigo]["logradouroSocio"] = socio.logradouro;
    mapaSocio[socio.codigo]["numeroResidenciaSocio"] = socio.numeroResidencia;
    mapaSocio[socio.codigo]["complementoSocio"] = socio.complemento;
    mapaSocio[socio.codigo]["bairroSocio"] = socio.bairro;
    mapaSocio[socio.codigo]["cidadeufSocio"] = socio.cidadeuf;
    mapaSocio[socio.codigo]["cepSocio"] = socio.cep;
    mapaSocio[socio.codigo]["empresasAssociadas"] = [];
    cadastrarEmpresaAoSocio(socio, empresa);
    listaSocios.add(socio.codigo);
  }

  static void cadastrarEmpresaAoSocio(Pessoa socio, Empresa empresa) {
    List lista = mapaSocio[socio.codigo]["empresasAssociadas"];
    lista.add(empresa.cnpj);
    mapaSocio[socio.codigo]["empresasAssociadas"] = lista;
    mapaEmpresas[empresa.razaoSocial]["codigoSocio"] = socio.codigo;
  }

  static void buscarEmpresaPorCodigoDoSocio(String codigo) {
    if (mapaSocio.isNotEmpty) {
      if (mapaSocio.containsKey(codigo)) {
        for (var empresasAssociada in mapaSocio[codigo]["empresasAssociadas"]) {
          if (buscarEmpresaPorCNPJ(empresasAssociada) == true) {
            print("");
          } else if (buscarEmpresaPorCNPJ(empresasAssociada) == false) {
            print("Não foram encontradas empresas para o sócio procurado!");
            print("");
          } else {
            print("Ainda não há empresas cadastradas");
          }
        }
      } else {
        print("Não há sócios cadastrados com o código procurado.");
      }
    } else {
      print("Ainda não há nenhum sócio cadastrado!");
      print("");
    }
  }

  static bool? buscarEmpresaPorCNPJ(String cnpj) {
    bool? retorno;
    if (listaEmpresas.isNotEmpty) {
      for (var razaoSocial in listaEmpresas) {
        if (mapaEmpresas[razaoSocial]["cnpj"] == cnpj) {
          print("");
          print('''
            ID: ${mapaEmpresas[razaoSocial]["id"]}
            CNPJ: ${Impressao.imprimeCNPJ(mapaEmpresas[razaoSocial]["cnpj"])}
            Razão Social: ${mapaEmpresas[razaoSocial]["razaoSocial"]}
            Nome Fantasia: ${mapaEmpresas[razaoSocial]["nomeFantasia"]}
            Telefone: ${Impressao.imprimeTelefone(mapaEmpresas[razaoSocial]["telefoneEmpresa"])}
            Endereço: ${mapaEmpresas[razaoSocial]["logradouroEmpresa"]}, ${mapaEmpresas[razaoSocial]["numeroResidenciaEmpresa"]}, 
            ${mapaEmpresas[razaoSocial]["bairroEmpresa"]}, ${mapaEmpresas[razaoSocial]["cidadeufEmpresa"]}, ${Impressao.imprimeCEP(mapaEmpresas[razaoSocial]["cepEmpresa"])}
            ''');
          ListaEmpresas.imprimeSocio(cnpj);
          retorno = true;
        } else {
          print("Não foi encontrada nenhuma empresa com o CNPJ digitado!");
          retorno = false;
        }
      }
    } else {
      return null;
    }
    return retorno;
  }

  static void imprimeSocio(String cnpjEmpresa) {
    if (listaSocios.isNotEmpty) {
      String codigoSocio = "";
      for (String? codigo in listaSocios) {
        List temp = mapaSocio[codigo]["empresasAssociadas"];
        if (temp.contains(cnpjEmpresa)) {
          codigoSocio = codigo!;
        }
      }
      if (codigoSocio.length == 11) {
        print('''
            Sócio:
            CPF: ${Impressao.imprimeCPF(codigoSocio)}
            Nome Completo: ${mapaSocio[codigoSocio]["nome"]}
            Endereço: ${mapaSocio[codigoSocio]["logradouroSocio"]}, ${mapaSocio[codigoSocio]["numeroResidenciaSocio"]}, 
              ${mapaSocio[codigoSocio]["bairroSocio"]}, ${mapaSocio[codigoSocio]["cidadeufSocio"]}, ${Impressao.imprimeCEP(mapaSocio[codigoSocio]["cepSocio"])}
              ''');
      } else {
        print('''
            Sócio:
            CNPJ: ${Impressao.imprimeCNPJ(codigoSocio)}
            Nome Completo: ${mapaSocio[codigoSocio]["nome"]}
            Endereço: ${mapaSocio[codigoSocio]["logradouroSocio"]}, ${mapaSocio[codigoSocio]["numeroResidenciaSocio"]}, 
              ${mapaSocio[codigoSocio]["bairroSocio"]}, ${mapaSocio[codigoSocio]["cidadeufSocio"]}, ${Impressao.imprimeCEP(mapaSocio[codigoSocio]["cepSocio"])}
              ''');
      }
    }
  }

  static void mostraEmpresasOrdemAlfabetica() {
    if (listaEmpresas.isNotEmpty) {
      for (var empresaMostrada in listaEmpresas) {
        String cnpjMostrado = mapaEmpresas[empresaMostrada]["cnpj"];
        buscarEmpresaPorCNPJ(cnpjMostrado);
      }
    } else {
      print("Ainda não empresas cadastradas!");
      print("");
    }
  }

  static void excluirEmpresaPorId(String idEmpressaExcluida) {
    String? empresaExcluida;
    int verificador = 0;
    for (var razaoSocial in listaEmpresas) {
      if (mapaEmpresas[razaoSocial]["id"] == idEmpressaExcluida) {
        mapaEmpresas.remove(razaoSocial);

        empresaExcluida = razaoSocial;
        verificador++;
      }
    }
    if (verificador == 1) {
      listaEmpresas.remove(empresaExcluida);
      print("A empresa $empresaExcluida foi excluída do cadstro de empresas!");
      print("");
    } else {
      print("Não foi encontrada nenhuma empresa com o ID informado.");
      print("");
    }
  }
}
