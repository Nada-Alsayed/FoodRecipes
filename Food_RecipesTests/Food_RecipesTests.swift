//
//  Food_RecipesTests.swift
//  Food_RecipesTests
//
//  Created by MAC on 26/05/2023.
//

import XCTest
@testable import Food_Recipes

final class Food_RecipesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadDataFromAPI(){
        func url(string :String)->String{
            return "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=\(string)"
           }
        let expectation = expectation(description: "wait for api")
        NetworkerService().fetchData(url: url(string: "breakfast")) { [weak self] (root: MyResult?, err) in
            if let root = root {
                XCTAssert(root.results?.count ?? 0 > 0)
                print("Recipe Name : \(root.results?[0].name ?? "")")
                expectation.fulfill()
            }
            else{
               XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 7)
    }

}
