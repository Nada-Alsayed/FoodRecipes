//
//  ViewModelHome.swift
//  Food_Recipes
//
//  Created by MAC on 26/05/2023.
//

import Foundation

class HomeViewModel {
    var categoryNames = ["Popular","Breakfast","Launch","Dinner","Dessert"]
    var categoryImages = ["middle_eastern","breakfast","lunch","dinner","desserts"]
    var repo: DataProviderProtocol!
 
    var bindResultToView : (()->()) = {}
      
      var res = MyResult(count: 0, results: []) {
          didSet{
              bindResultToView()
          }
      }
    
    private var apiFetchHandler : NetworkServiceProtocol!
    var category : String
    
    
    init(apiFetchHandler: NetworkServiceProtocol!) {
           self.apiFetchHandler = apiFetchHandler
           self.repo = LocalService()//apiFetchHandler as? any DataProviderProtocol
           self.category = categoryImages[0]
       }
    
    func teamURL()->String{
        return "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=\(category)"
       }
    
    func getData(){
        self.res = repo.fetchData(teamUrl: teamURL())
    }
//    func getData(){
//        apiFetchHandler.fetchData(url: teamURL()) { [weak self] (root: MyResult?, err) in
//            guard let root = root else { return }
//            self?.res = root
//          //  print("image URL :\(self?.res.results?[1].thumbnailURL)")
//        }
        
     
    }
