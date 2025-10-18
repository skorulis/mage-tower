//Created by Alexander Skorulis on 15/10/2025.

import Foundation

enum Currency: Hashable, Codable {
    // In game currency
    case aether
    
    // Persitent currency
    case anima
}

struct Wallet: Codable {
    private var amounts: [Currency: Double]
    
    init() {
        amounts = [:]
    }
    
    mutating func add(currency: Currency, amount: Double) {
        amounts[currency] = self.amount(currency) + amount
    }
    
    func amount(_ currency: Currency) -> Double {
        amounts[currency] ?? 0
    }
    
    var anima: Double {
        amount(.anima)
    }
}
