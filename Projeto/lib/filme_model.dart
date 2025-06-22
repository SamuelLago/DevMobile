class Filme {
  final String titulo;
  final String genero;
  final String ano;
  double? nota;
  bool assistido;
  final String comentario;
  final DateTime dataCadastro;

  Filme({
    required this.titulo,
    required this.genero,
    required this.ano,
    this.nota,
    required this.assistido,
    required this.comentario,
    required this.dataCadastro,
  });
}
