//
//  Mocking.swift
//  Food_RecipesTests
//
//  Created by MAC on 26/05/2023.
//

import XCTest
@testable import Food_Recipes

final class Mocking: XCTestCase {
    
    var fakeNetwork = FakeNetwork(returnError: true)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testLoadDataFake(){
        fakeNetwork.loadData(urls: "") { res , err  in
            if (err != nil ) == false {
                XCTAssertNotNil(res)
            }else{
                XCTFail()
            }
        }
        
        
    }

}
