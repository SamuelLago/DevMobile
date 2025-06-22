# 🎬 Meus Filmes – Aplicativo Flutter

Aplicativo mobile desenvolvido com **Flutter** para gerenciar filmes assistidos e desejados.  
Permite cadastrar, visualizar, buscar, ordenar por nota, adicionar comentários, alternar status e excluir filmes da lista.

---

## 🚀 Funcionalidades

- ✅ Cadastrar filmes com título, gênero, ano, comentário e nota
- ✅ Marcar como “assistido” ou “quero assistir”
- ✅ Ao marcar como assistido, solicitar nota obrigatoriamente
- ✅ Separação por abas: Assistidos e Quero Ver
- ✅ Ordenação automática dos assistidos por nota (maior para menor)
- ✅ Busca por título em tempo real
- ✅ Comentários e data de cadastro visíveis
- ✅ Excluir filmes da lista
- ✅ Interface responsiva para mobile e web

---

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.x**
- **Dart**
- `Material Design`
- `StatefulWidgets`, `ListView`, `TabBarView`, `TextField`
- Suporte Web com Flutter Web

---

## ▶️ Como rodar o projeto localmente

```bash
# Clone o repositório
git clone https://github.com/SEU_USUARIO/meus-filmes

# Acesse a pasta
cd meus-filmes

# Instale as dependências
flutter pub get

# Rode o app
flutter run

# Ou para web:
flutter run -d chrome

## Organizacao das pastas
lib/
├── Home.dart
├── add_filme_screen.dart
├── filme_model.dart
├── SplashScreen.dart
└── main.dart
