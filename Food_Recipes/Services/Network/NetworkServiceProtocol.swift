//
//  NetworkServiceProtocol.swift
//  Food_Recipes
//
//  Created by Moaz Khaled on 26/05/2023.
//

import Foundation
 
protocol NetworkServiceProtocol {
    func fetchData<T:Codable>(url:String,complition : @escaping (T?,Error?) -> () )
}
