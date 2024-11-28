//
//  ContentView.swift
//  teste luis 2
//
//  Created by user on 28/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var transacoes: [Transacao] = [] 
    @State private var mostrarTelaAdicionarTransacao = false

    
    var saldoTotal: Double {
        let entradas = transacoes.filter { $0.tipo == .entrada }.reduce(0) { $0 + $1.valor }
        let saidas = transacoes.filter { $0.tipo == .saida }.reduce(0) { $0 + $1.valor }
        return entradas - saidas
    }

    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text("Saldo Total:")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "R$ %.2f", saldoTotal))
                        .font(.headline)
                        .foregroundColor(saldoTotal >= 0 ? .green : .red)
                }
                .padding()

                
                List {
                    ForEach(transacoes) { transacao in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transacao.nome)
                                    .font(.headline)
                                Text(transacao.data, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(String(format: "R$ %.2f", transacao.valor))
                                .foregroundColor(transacao.tipo == .entrada ? .green : .red)
                        }
                    }
                    .onDelete(perform: deletarTransacao)
                }
            }
            .navigationTitle("Controle Financeiro")
            .navigationBarItems(trailing: Button(action: {
                mostrarTelaAdicionarTransacao.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $mostrarTelaAdicionarTransacao) {
                TelaAdicionarTransacao(transacoes: $transacoes)
            }
        }
    }

   
    func deletarTransacao(at offsets: IndexSet) {
        transacoes.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
