import 'package:flutter/material.dart';
import 'filme_model.dart';
import 'add_filme_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<Filme> _filmes = [];
  late TabController _tabController;
  String _busca = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _adicionarFilme(Filme novoFilme) {
    setState(() => _filmes.add(novoFilme));
  }

  void _removerFilme(Filme filme) {
    setState(() => _filmes.remove(filme));
  }

  void _alternarStatus(Filme filme) async {
    if (!filme.assistido) {
      final nota = await _solicitarNota();
      if (nota == null) return;
      setState(() {
        filme.assistido = true;
        filme.nota = nota;
      });
    } else {
      setState(() {
        filme.assistido = false;
        filme.nota = null;
      });
    }
  }

  Future<double?> _solicitarNota() async {
    final controller = TextEditingController();
    return await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informe a nota do filme'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Nota de 0 a 10',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final nota = double.tryParse(controller.text);
              if (nota != null && nota >= 0 && nota <= 10) {
                Navigator.pop(context, nota);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final assistidos = _filmes
        .where((f) =>
            f.assistido &&
            f.titulo.toLowerCase().contains(_busca.toLowerCase()))
        .toList()
      ..sort((a, b) => (b.nota ?? 0).compareTo(a.nota ?? 0));
    final paraVer = _filmes
        .where((f) =>
            !f.assistido &&
            f.titulo.toLowerCase().contains(_busca.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Filmes"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(text: 'Assistidos'),
            Tab(text: 'Quero Ver'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Filme? resultado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFilmeScreen()),
          );
          if (resultado != null) _adicionarFilme(resultado);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por título',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (texto) => setState(() => _busca = texto),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLista(assistidos),
                _buildLista(paraVer),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLista(List<Filme> lista) {
    if (lista.isEmpty) {
      return const Center(child: Text('Nenhum filme nesta categoria.'));
    }
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final filme = lista[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(filme.titulo),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${filme.genero} | ${filme.ano}' +
                    (filme.assistido && filme.nota != null
                        ? ' | Nota: ${filme.nota!.toStringAsFixed(1)}'
                        : '')),
                Text(
                    'Comentário: ${filme.comentario.isEmpty ? 'Nenhum' : filme.comentario}'),
                Text(
                    'Adicionado em: ${filme.dataCadastro.day}/${filme.dataCadastro.month}/${filme.dataCadastro.year}'),
              ],
            ),
            trailing: Wrap(
              spacing: 12,
              children: [
                IconButton(
                  icon: Icon(
                    filme.assistido ? Icons.undo : Icons.check,
                    color: filme.assistido ? Colors.orange : Colors.green,
                  ),
                  onPressed: () => _alternarStatus(filme),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removerFilme(filme),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
