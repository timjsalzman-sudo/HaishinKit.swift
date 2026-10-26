import Foundation
import Network
import Testing

@testable import RTMPHaishinKit

@Suite struct RTMPConnectionTests {
    @Test func requiredInterfaceType() async {
        #expect(await RTMPConnection().requiredInterfaceType == nil)
        let connection = RTMPConnection(requiredInterfaceType: .cellular)
        #expect(await connection.requiredInterfaceType == .cellular)
    }

    @Test func releaseWhenClose() async throws {
        weak var weakConnection: RTMPConnection?
        _ = try? await {
            let connection = RTMPConnection()
            _ = try await connection.connect("rtmp://localhost:19350/live")
            try await connection.close()
            weakConnection = connection
        }()
        #expect(weakConnection == nil)
    }
}
