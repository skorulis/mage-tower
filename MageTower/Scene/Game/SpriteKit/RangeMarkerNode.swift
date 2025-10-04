//Created by Alexander Skorulis on 4/10/2025.

import Foundation
import SpriteKit

final class RangeMarkerNode: SKShapeNode {
    
    var range: CGFloat = 1 {
        didSet {
            if range != oldValue {
                updateRangeRing()
            }
        }
    }
    
    override init() {
        super.init()
        setupRangeMarker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupRangeMarker()
    }
    
    private func setupRangeMarker() {
        // Set up the range marker as a ring (hollow circle)
        fillColor = .clear
        strokeColor = .white
        lineWidth = 2.0
        alpha = 0.6
        zPosition = -1 // Behind the tower but above background
        
        updateRangeRing()
    }
    
    private func updateRangeRing() {
        // Create a circular path for the range ring
        let path = CGMutablePath()
        let radius = range
        path.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        self.path = path
    }
}
