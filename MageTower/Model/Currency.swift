//Created by Alexander Skorulis on 15/10/2025.

import Foundation

nonisolated enum Currency: Hashable, Codable {
    // In game currency
    case aether
    
    // Persitent currency
    case anima
}

struct Wallet: Codable {
    // The total earnings for this wallet
    private(set) var totalEarned: [Currency: Double]
    
    // The current balance
    private(set) var amounts: [Currency: Double]
    
    init(amounts: [Currency: Double] = [:]) {
        self.totalEarned = amounts
        self.amounts = amounts
    }
    
    mutating func add(currency: Currency, amount: Double) {
        totalEarned[currency] = (totalEarned[currency] ?? 0) + amount
        amounts[currency] = self.amount(currency) + amount
    }
    
    func amount(_ currency: Currency) -> Double {
        amounts[currency] ?? 0
    }
    
    var anima: Double { amount(.anima) }
    var aether: Double { amount(.aether) }
}
