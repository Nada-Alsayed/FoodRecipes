//
//  HomeVC.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {
    var categoryNames = ["Popular","Breakfast","Launch","Dinner","Dessert"]
    var categoryImages = ["fire","breakfast","launch","dinner","cake"]
    var favViewModel:FavoriteViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        Utlites.registerCell(collectionView:collectionView)
        // Do any additional setup after loading the view.
        
        favViewModel = FavoriteViewModel(coreData: RecipieCoreData.sharedInstance)

        
        let layout = UICollectionViewCompositionalLayout{ index , environment in
            
            return self.drawTopSection()
                 
                }
                collectionView.setCollectionViewLayout(layout, animated: true)
    }

}
extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.cellBg.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.04)
        
      
        
        cell.cellBg.layer.cornerRadius = 8

        cell.cellName.text = categoryNames[indexPath.row]
        cell.cellImage.image = UIImage(named: categoryImages[indexPath.row])
             
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
       // cell.cellBg.backgroundColor = UIColor(red: 217, green: 150, blue: 81, alpha: 1)
        cell.cellBg.backgroundColor = UIColor.green
        
        var fav = RecipeEntity(criditName: "Eman", recipeImg: "", recipeName: "Checken", recipeUrl: "rr", showName: "tt", yeild: "oo", id: 5)
        
        if(indexPath.row == 1){
        favViewModel?.insertFavRecipe(recipe: fav)
        // print("Hi")
        }
        else{
         //   print("bye")
            favViewModel?.deleteFavRecipe(recipe: fav)
            
        }
        print(favViewModel?.isRecipeExist(recipe: fav))
     //   print( favViewModel?.getSoredFavs())
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.cellBg.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.04)
    }
    
    func drawTopSection() -> NSCollectionLayoutSection{
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing:8)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 8)

            return section
        }
    
}
