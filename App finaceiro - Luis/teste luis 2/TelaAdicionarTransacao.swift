import SwiftUI

struct TelaAdicionarTransacao: View {
    @Environment(\.presentationMode) var modoDeApresentacao
    @Binding var transacoes: [Transacao]

    @State private var nome: String = ""
    @State private var valor: String = ""
    @State private var data = Date()
    @State private var tipo: TipoTransacao = .saida

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Transação")) {
                    TextField("Nome da Transação", text: $nome)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Valor", text: $valor)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    DatePicker("Data", selection: $data, displayedComponents: .date)

                    Picker("Tipo", selection: $tipo) {
                        ForEach(TipoTransacao.allCases, id: \.self) { tipo in
                            Text(tipo.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Button(action: salvarTransacao) {
                        Text("Salvar")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(nome.isEmpty || Double(valor) == nil)
                }
            }
            .navigationTitle("Nova Transação")
        }
    }

    private func salvarTransacao() {
        if let valorDouble = Double(valor), !nome.isEmpty {
            let novaTransacao = Transacao(nome: nome, valor: valorDouble, data: data, tipo: tipo)
            transacoes.append(novaTransacao)
            modoDeApresentacao.wrappedValue.dismiss()
        }
    }
}

struct TelaAdicionarTransacao_Previews: PreviewProvider {
    static var previews: some View {
        TelaAdicionarTransacao(transacoes: .constant([]))
    }
}
