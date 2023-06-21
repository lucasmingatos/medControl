class RemedioCancer {
  late String id;
  late String nome;
  late String tipo;
  late String dosagem;
  late String hora;
  late String qtd;
  late String obs;
  late String url;

  //construtor
  RemedioCancer(this.id, this.nome, this.tipo, this.dosagem, this.hora,
      this.qtd, this.obs, this.url);

  //Converter doc em objeto
  RemedioCancer.fromJson(Map<String, dynamic> map, this.id) {
    nome = map['nome'];
    tipo = map['tipo'];
    dosagem = map['dosagem'];
    hora = map['hora'];
    qtd = map['qtd'];
    obs = map['obs'];
    url = map['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'dosagem': dosagem,
      'hora': hora,
      'qtd': qtd,
      'obs': obs,
      'url': url,
    };
  }
}
