//Created by Alexander Skorulis on 25/10/2025.

import Foundation

struct LevelRecord: Codable {
    var bestWave: Int
    var bestIncome: [Currency: Double]
    
    func merge(other: LevelRecord?) -> LevelRecord {
        guard let other else { return self }
        return LevelRecord(
            bestWave: max(self.bestWave, other.bestWave),
            bestIncome: mergeIncome(current: self.bestIncome, new: other.bestIncome)
        )
    }
    
    private func mergeIncome(current: [Currency: Double], new: [Currency: Double]) -> [Currency: Double] {
        var result = current
        for (currency, amount) in new {
            result[currency] = max(result[currency] ?? 0, amount)
        }
        return result
    }
}

struct LevelRecords: Codable {
    var levels: [Level: LevelRecord]
}
