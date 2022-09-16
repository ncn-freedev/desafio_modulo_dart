abstract class Impressao {
  static String imprimeCNPJ(String entrada) {
    String e = entrada;
    String saida =
        "${e.substring(0, 2)}.${e.substring(2, 5)}.${e.substring(5, 8)}/${e.substring(8, 12)}-${e.substring(12)}";
    return saida;
  }

  static String imprimeCPF(String entrada) {
    String e = entrada;
    String saida =
        "${e.substring(0, 4)}.${e.substring(4, 7)}.${e.substring(7, 10)}-${e.substring(10)}";
    return saida;
  }

  static String imprimeTelefone(String entrada) {
    String e = entrada;
    String saida =
        "(${e.substring(0, 2)}) ${e.substring(2, 3)} ${e.substring(3, 7)}-${e.substring(7)}";
    return saida;
  }

  static String imprimeCEP(String entrada) {
    String e = entrada;
    String saida =
        "${e.substring(0, 2)}.${e.substring(2, 5)}-${e.substring(5)}";
    return saida;
  }
}
