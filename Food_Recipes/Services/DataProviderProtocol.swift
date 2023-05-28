//
//  DataProviderProtocol.swift
//  Food_Recipes
//
//  Created by NadaAshraf on 27/05/2023.
//

import Foundation
protocol DataProviderProtocol {
    func fetchData(teamUrl: String) -> MyResult
}
