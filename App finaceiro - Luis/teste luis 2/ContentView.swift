

import SwiftUI

struct ContentView: View {
    @State private var transacoes: [Transacao] = []
    @State private var mostrarTelaAdicionarTransacao = false
    @State private var termoDePesquisa = ""

    
    var saldoTotal: Double {
        let entradas = transacoes.filter { $0.tipo == .entrada }.reduce(0) { $0 + $1.valor }
        let saidas = transacoes.filter { $0.tipo == .saida }.reduce(0) { $0 + $1.valor }
        return entradas - saidas
    }

    
    var transacoesFiltradas: [Transacao] {
        if termoDePesquisa.isEmpty {
            return transacoes
        } else {
            return transacoes.filter { $0.nome.lowercased().contains(termoDePesquisa.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Saldo Total")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text(String(format: "R$ %.2f", saldoTotal))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(saldoTotal >= 0 ? .green : .red)
                    }
                    Spacer()
                    Image(systemName: saldoTotal >= 0 ? "arrow.up.circle" : "arrow.down.circle")
                        .font(.largeTitle)
                        .foregroundColor(saldoTotal >= 0 ? .green : .red)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding()

                               TextField("Buscar transações...", text: $termoDePesquisa)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                                List {
                    ForEach(transacoesFiltradas) { transacao in
                        HStack {
                            Image(systemName: transacao.tipo == .entrada ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                .foregroundColor(transacao.tipo == .entrada ? .green : .red)
                                .font(.title2)

                            VStack(alignment: .leading) {
                                Text(transacao.nome)
                                    .font(.headline)
                                Text(transacao.data, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(String(format: "R$ %.2f", transacao.valor))
                                .font(.body)
                                .foregroundColor(transacao.tipo == .entrada ? .green : .red)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .onDelete(perform: deletarTransacao)
                }

                               Button(action: {
                    mostrarTelaAdicionarTransacao.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Nova Transação")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                .padding()
            }
            .navigationTitle("Controle Financeiro")
            .sheet(isPresented: $mostrarTelaAdicionarTransacao) {
                TelaAdicionarTransacao(transacoes: $transacoes)
            }
        }
    }

        private func deletarTransacao(at offsets: IndexSet) {
        transacoes.remove(atOffsets: offsets)
    }
}
