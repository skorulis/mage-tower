//Created by Alexander Skorulis on 27/9/2025.

@testable import MageTower
import Testing

nonisolated struct MainStatTests {
    
    @MainActor @Test func values() async throws {
        #expect(MainStat.health.value(level: 1) == 10)
        
        #expect(Int(MainStat.health.value(level: 10)) == 102)
        #expect(Int(MainStat.health.value(level: 100)) == 1047)
    }
}
