import 'package:flutter/material.dart';

void main() => runApp(const BancoApp());

class BancoApp extends StatelessWidget {
  const BancoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROLÂNDIA BANK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Contato> _contatos = []; // Lista de contatos no estado do Dashboard
  final List<Transferencia> _transferencias = []; // Lista de transferências no estado do Dashboard

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ROLÂNDIA BANK"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.savings, // Ícone de porquinho
              size: 72,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                    context, "Contatos", Icons.contacts, Colors.blue,
                    ListaContatos(contatos: _contatos)), // Passa a lista de contatos
                _buildDashboardCard(
                    context, "Transferências", Icons.currency_exchange, Colors.green,
                    ListaTransferencias(transferencias: _transferencias)), // Passa a lista de transferências
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String titulo, IconData icone,
      Color cor, Widget destino) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destino),
        );
      },
      child: Card(
        color: cor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 48, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                titulo,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListaContatos extends StatefulWidget {
  final List<Contato> contatos;

  ListaContatos({super.key, required this.contatos});

  @override
  State<StatefulWidget> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEndereco = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerCpf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: widget.contatos.length,
        itemBuilder: (context, indice) {
          final contato = widget.contatos[indice];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: Text(contato.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Endereço: ${contato.endereco}'),
                  Text('Telefone: ${contato.telefone}'),
                  Text('Email: ${contato.email}'),
                  Text('CPF: ${contato.cpf}'),
                ],
              ),
              isThreeLine: true, 
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarFormularioContato(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarFormularioContato(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Novo Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controllerNome,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _controllerEndereco,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
              TextField(
                controller: _controllerTelefone,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextField(
                controller: _controllerCpf,
                decoration: const InputDecoration(labelText: 'CPF'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final String nome = _controllerNome.text;
                final String endereco = _controllerEndereco.text;
                final String telefone = _controllerTelefone.text;
                final String email = _controllerEmail.text;
                final String cpf = _controllerCpf.text;

                if (nome.isNotEmpty && email.isNotEmpty) {
                  final novoContato = Contato(
                      nome: nome,
                      endereco: endereco,
                      telefone: telefone,
                      email: email,
                      cpf: cpf);
                  setState(() {
                    widget.contatos.add(novoContato); // Adiciona contato
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}

class Contato {
  final String nome;
  final String endereco;
  final String telefone;
  final String email;
  final String cpf;

  Contato(
      {required this.nome,
      required this.endereco,
      required this.telefone,
      required this.email,
      required this.cpf});
}


class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> transferencias;

  ListaTransferencias({super.key, required this.transferencias});

  @override
  State<StatefulWidget> createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: widget.transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget.transferencias[indice];
          return ListTile(
            leading: const Icon(Icons.currency_exchange, color: Colors.green),
            title: Text('R\$ ${transferencia.valor.toString().replaceAll('.', ',')}'),
            subtitle: Text('Conta: ${transferencia.numeroConta}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarFormularioTransferencia(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarFormularioTransferencia(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Transferência'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controllerNumeroConta,
                decoration: const InputDecoration(labelText: 'Número da Conta'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _controllerValor,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final int? numeroConta =
                    int.tryParse(_controllerNumeroConta.text);
                final double? valor = double.tryParse(_controllerValor.text);

                if (numeroConta != null && valor != null) {
                  final novaTransferencia =
                      Transferencia(valor, numeroConta);
                  setState(() {
                    widget.transferencias.add(novaTransferencia); // Adiciona uma tasrnferência
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
