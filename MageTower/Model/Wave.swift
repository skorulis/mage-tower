//  Created by Alexander Skorulis on 13/9/2025.

import Foundation

struct Wave {
    var number: Int
    var time: TimeInterval
    var duration: TimeInterval
    
    static var empty: Self {
        .init(number: 1, time: 0, duration: 1)
    }
    
    mutating func add(delta: TimeInterval) {
        time += delta
        if time >= duration {
            time -= duration
            number += 1
        }
    }
}
