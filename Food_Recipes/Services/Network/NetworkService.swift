//
//  NetworkService.swift
//  Food_Recipes
//
//  Created by Moaz Khaled on 26/05/2023.
//

import Foundation
import Alamofire

class NetworkerService :NetworkServiceProtocol{
    
//    let headers = [
//        "X-RapidAPI-Key": "82ebfc0d39mshe9944f193412711p1185dejsn8af599cc676c",
//        "X-RapidAPI-Host": "tasty.p.rapidapi.com"
//    ]
    
    let headers: HTTPHeaders = [
        "X-RapidAPI-Key": "82ebfc0d39mshe9944f193412711p1185dejsn8af599cc676c",
        "X-RapidAPI-Host": "tasty.p.rapidapi.com"
            ]
    
    func fetchData<T:Codable>(url:String,complition : @escaping (T?,Error?) -> () ){
            
        print("CallingURL",url)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil).response { response in
         //   print(response)
            switch response.result{
            case .success(let data):
              do{
                  let jsonData = try JSONDecoder().decode(T.self, from: data!)
                  complition(jsonData,nil)
                  debugPrint(jsonData)
             } catch {
                print(error.localizedDescription)
             }
           case .failure(let error):
             print(error.localizedDescription)
              complition(nil,error)
            }
        }
    }
    
}
