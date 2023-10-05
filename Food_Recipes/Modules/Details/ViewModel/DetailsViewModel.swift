//
//  Details.swift
//  Food_Recipes
//
//  Created by MAC on 03/10/2023.
//

import Foundation
class DetailsViewModel {
    var bindResultToView : (()->()) = {}
      
      var res = MyResult(count: 0, results: []) {
          didSet{
              bindResultToView()
          }
      }
    private var apiFetchHandler : NetworkServiceProtocol!
    init(apiFetchHandler: NetworkServiceProtocol!) {
           self.apiFetchHandler = apiFetchHandler
    }
    
    func getData(url:String){
        apiFetchHandler.fetchData(url: url) { [weak self] (root: MyResult?, err) in
            guard let root = root else { return }
            self?.res = root
            print("id :\(self?.res.results?[1].id)")
        }
    }
}
