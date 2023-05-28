//
//  NetworkService.swift
//  Food_Recipes
//
//  Created by Moaz Khaled on 26/05/2023.
//

import Foundation
import Alamofire

class NetworkerService :NetworkServiceProtocol,DataProviderProtocol{
    var res = MyResult(count: 0, results: [])
  
    func fetchData(teamUrl: String) -> MyResult{
        self.fetchData(url: teamUrl) { [weak self] (root: MyResult?, err) in
            guard let root = root else { return }
            self?.res = root
        }
        return res
    }
    
//    let headers = [
//        "X-RapidAPI-Key": "82ebfc0d39mshe9944f193412711p1185dejsn8af599cc676c",
//        "X-RapidAPI-Host": "tasty.p.rapidapi.com"
//    ]
    
    let headers: HTTPHeaders = [
        "X-RapidAPI-Key": "1d718779b5msh8297d4af6898039p1a9457jsned6bc2a79e8b",
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
