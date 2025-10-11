//Created by Alexander Skorulis on 11/10/2025.

import Foundation

enum ScalingFunctions {
    
    // MARK: - Linear Scaling Functions
    
    /// Simple linear scaling: base + (level * multiplier)
    static func linear(base: Double, multiplier: Double, level: Int) -> Double {
        return base + Double(level) * multiplier
    }
    
    // MARK: - Exponential Scaling Functions
    
    /// Exponential scaling: base * (1 + rate)^level
    static func exponential(base: Double, rate: Double, level: Int) -> Double {
        return base * pow(1 + rate, Double(level))
    }
    
    /// Power scaling: base * level^power
    static func power(base: Double, power: Double, level: Int) -> Double {
        return base * pow(Double(level), power)
    }
    
    /// Polynomial scaling: base * (level^exponent)
    static func polynomial(base: Double, exponent: Double, level: Int) -> Double {
        return base * pow(Double(level), exponent)
    }
    
    // MARK: - Logarithmic and Diminishing Returns Functions
    
    /// Logarithmic scaling: base + (multiplier * log(level))
    static func logarithmic(base: Double, multiplier: Double, level: Int) -> Double {
        guard level > 0 else { return base }
        return base + multiplier * log(Double(level))
    }
    
    /// Square root scaling: base + (multiplier * sqrt(level))
    static func squareRoot(base: Double, multiplier: Double, level: Int) -> Double {
        return base + multiplier * sqrt(Double(level))
    }
    
    /// Diminishing returns: maxValue * (1 - (1 / (1 + level * rate)))
    static func diminishingReturns(maxValue: Double, rate: Double, level: Int) -> Double {
        return maxValue * (1 - (1 / (1 + Double(level) * rate)))
    }
    
    // MARK: - Compound Scaling Functions
    
    /// Linear then exponential blend (useful for wave scaling)
    /// Uses linear up to transitionLevel, then blends into exponential
    static func linearExponentialBlend(
        base: Double,
        linearMultiplier: Double,
        exponentialRate: Double,
        transitionLevel: Int,
        level: Int
    ) -> Double {
        if level <= transitionLevel {
            return base + Double(level) * linearMultiplier
        } else {
            // Calculate value at transition using linear formula
            let linearAtTransition = base + Double(transitionLevel) * linearMultiplier
            // Calculate what exponential would be at transition
            let expAtTransition = base * pow(1 + exponentialRate, Double(transitionLevel))
            // Find blend multiplier to ensure continuity
            let blendMultiplier = linearAtTransition / expAtTransition
            // Use exponential for level > transition, scaled for continuity
            return blendMultiplier * base * pow(1 + exponentialRate, Double(level))
        }
    }
    
    /// Quadratic scaling: base + (level^2 * coefficient)
    static func quadratic(base: Double, coefficient: Double, level: Int) -> Double {
        return base + pow(Double(level), 2) * coefficient
    }
    
    /// Cubic scaling: base + (level^3 * coefficient)
    static func cubic(base: Double, coefficient: Double, level: Int) -> Double {
        return base + pow(Double(level), 3) * coefficient
    }
    
    // MARK: - Cost Scaling Functions
    
    /// Exponential cost scaling with different rates
    static func exponentialCost(baseCost: Double, rate: Double, level: Int) -> Double {
        return baseCost * pow(1 + rate, Double(level))
    }
    
    /// Power-based cost scaling
    static func powerCost(baseCost: Double, power: Double, level: Int) -> Double {
        return baseCost * pow(Double(level), power)
    }
    
    /// Fibonacci-like cost scaling (each level costs more than the previous two combined)
    static func fibonacciCost(baseCost: Double, level: Int) -> Double {
        guard level > 0 else { return baseCost }
        if level == 1 { return baseCost }
        
        var prev2 = baseCost
        var prev1 = baseCost * 1.5
        var current = prev1
        
        for i in 2..<level {
            current = prev1 + prev2 * 0.618 // Golden ratio for smoother scaling
            prev2 = prev1
            prev1 = current
        }
        
        return current
    }
    
    // MARK: - Specialized Game Functions
    
    /// Health scaling for enemies (combines linear and exponential)
    static func enemyHealth(
        baseHealth: Double,
        linearMultiplier: Double,
        exponentialRate: Double,
        wave: Int
    ) -> Double {
        return linearExponentialBlend(
            base: baseHealth,
            linearMultiplier: linearMultiplier,
            exponentialRate: exponentialRate,
            transitionLevel: 100,
            level: wave
        )
    }
    
    /// Damage scaling for enemies
    static func enemyDamage(baseDamage: Double, rate: Double, wave: Int) -> Double {
        return exponential(base: baseDamage, rate: rate, level: wave)
    }
    
    /// Tower stat scaling
    static func towerStat(baseValue: Double, growthFactor: Double, level: Int) -> Double {
        return power(base: baseValue, power: growthFactor, level: level)
    }
    
    /// XP requirement scaling
    static func xpRequirement(baseXP: Double, rate: Double, level: Int) -> Double {
        return exponential(base: baseXP, rate: rate, level: level)
    }
    
    /// Spawn rate scaling (diminishing returns to prevent overwhelming)
    static func spawnRate(baseRate: Double, maxRate: Double, rate: Double, level: Int) -> Double {
        return diminishingReturns(maxValue: maxRate, rate: rate, level: level) + baseRate
    }
}
