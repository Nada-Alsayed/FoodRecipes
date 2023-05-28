//
//  LocalService.swift
//  Food_Recipes
//
//  Created by NadaAshraf on 27/05/2023.
//

import Foundation

class LocalService: DataProviderProtocol{
    func fetchData(teamUrl: String) -> MyResult{
        return MyResult(count: 0, results: [])
    }
}
