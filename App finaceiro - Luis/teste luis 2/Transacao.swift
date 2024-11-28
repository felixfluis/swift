//
//  Transacao.swift
//  teste luis 2
//
//  Created by user on 28/11/24.
//

import Foundation

enum TipoTransacao: String, Codable, CaseIterable {
    case entrada = "Entrada"
    case saida = "Saída"
}

struct Transacao: Identifiable {
    var id = UUID()
    var nome: String
    var valor: Double
    var data: Date
    var tipo: TipoTransacao
}
