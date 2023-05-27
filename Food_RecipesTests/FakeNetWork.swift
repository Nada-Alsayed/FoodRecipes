//
//  FakeNetWork.swift
//  Food_RecipesTests
//
//  Created by MAC on 26/05/2023.
//

import Foundation
@testable import Food_Recipes
class FakeNetwork {
    var returnError : Bool
    let league : [[String:Any]] = [[
        "league_key": "205",
        "league_name": "Coppa Italia",
        "country_key": "5",
        "country_name": "Italy",
        "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png",
        "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
    ]]
    
    init(returnError: Bool) {
        self.returnError = returnError
    }
}

extension FakeNetwork {
    func loadData(urls:String, handler:@escaping ([[String:Any]]?)->Void){
        if returnError {
            handler(nil)
        }else{
            handler(league)
        }
    }
}
