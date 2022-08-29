import XCTest
@testable import CocoaHTTPServer_Routing

final class CocoaHTTPServer_RoutingTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        HTTPRouteMapping.sharedInstance().addHandlerForGet(withPath: "/test") { _, _, _, _, _, _ in
            return HTTPDataResponse(data: Data())
        }
    }
}
