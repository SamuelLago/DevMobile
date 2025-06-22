import 'package:flutter/material.dart';
import 'filme_model.dart';

class AddFilmeScreen extends StatefulWidget {
  const AddFilmeScreen({super.key});

  @override
  State<AddFilmeScreen> createState() => _AddFilmeScreenState();
}

class _AddFilmeScreenState extends State<AddFilmeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _generoController = TextEditingController();
  final _anoController = TextEditingController();
  final _comentarioController = TextEditingController();
  final _notaController = TextEditingController();
  bool _assistido = false;

  void _salvarFilme() {
    if (_formKey.currentState!.validate()) {
      final novoFilme = Filme(
        titulo: _tituloController.text,
        genero: _generoController.text,
        ano: _anoController.text,
        nota: _assistido ? double.tryParse(_notaController.text) ?? 0 : null,
        assistido: _assistido,
        comentario: _comentarioController.text,
        dataCadastro: DateTime.now(),
      );

      Navigator.pop(context, novoFilme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Filme')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o título' : null,
              ),
              TextFormField(
                controller: _generoController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o gênero' : null,
              ),
              TextFormField(
                controller: _anoController,
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o ano' : null,
              ),
              TextFormField(
                controller: _comentarioController,
                decoration:
                    const InputDecoration(labelText: 'Comentário (opcional)'),
              ),
              SwitchListTile(
                title: const Text('Já assisti'),
                value: _assistido,
                onChanged: (value) {
                  setState(() => _assistido = value);
                },
              ),
              if (_assistido)
                TextFormField(
                  controller: _notaController,
                  decoration: const InputDecoration(labelText: 'Nota (0 a 10)'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (!_assistido) return null;
                    final nota = double.tryParse(value ?? '');
                    if (nota == null || nota < 0 || nota > 10) {
                      return 'Digite uma nota válida';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarFilme,
                child: const Text('Salvar Filme'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
