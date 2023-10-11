import XCTest
@testable import Food_Recipes

final class Mocking: XCTestCase {
    
    var fakeNetwork = FakeNetwork(returnError: false)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testLoadDataFake(){
        fakeNetwork.loadData(urls: "") { res , err  in
            if (err == nil ) {
                XCTAssertNotNil(res)
            }else{
                XCTFail()
            }
        }
        
        
    }

}
