//  Created by Alexander Skorulis on 14/9/2025.

@testable import MageTower
import Testing

nonisolated struct CompactNumberFormatterTests {
    
    @MainActor @Test func formatting() async throws {
        let formatter = CompactNumberFormatter()
        #expect(formatter.string(1) == "1.0")
        #expect(formatter.string(0) == "0.0")
        #expect(formatter.string(1000) == "1.0K")
        #expect(formatter.string(1000000) == "1.0M")
        #expect(formatter.string(1110000) == "1.1M")
        #expect(formatter.string(5010) == "5.0K")
    }
}

