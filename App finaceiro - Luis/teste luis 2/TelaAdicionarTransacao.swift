import SwiftUI

struct TelaAdicionarTransacao: View {
    @Binding var transacoes: [Transacao]
    @Environment(\.presentationMode) var modoDeApresentacao

    @State private var nome: String = ""
    @State private var valor: String = ""
    @State private var data: Date = Date()
    @State private var tipo: TipoTransacao = .entrada

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Transação")) {
                    TextField("Nome", text: $nome)
                        .autocapitalization(.words)

                    TextField("Valor (R$)", text: $valor)
                        .keyboardType(.decimalPad)

                    DatePicker("Data", selection: $data, displayedComponents: .date)

                    Picker("Tipo", selection: $tipo) {
                        Text("Entrada").tag(TipoTransacao.entrada)
                        Text("Saída").tag(TipoTransacao.saida)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                              Button(action: salvarTransacao) {
                    Text("Salvar")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(nome.isEmpty || Double(valor) == nil ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                .disabled(nome.isEmpty || Double(valor) == nil)
            }
            .navigationTitle("Nova Transação")
            .navigationBarItems(leading: Button("Cancelar") {
                modoDeApresentacao.wrappedValue.dismiss()
            })
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
