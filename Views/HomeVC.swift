//
//  HomeVC.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit
import SwiftUI
import Kingfisher
class HomeVC: UIViewController {
    
    var viewModel = HomeViewModel(apiFetchHandler: NetworkerService())
    var favViewModel = FavoriteViewModel(coreData: RecipieCoreData.sharedInstance)
    var arrayOfReciebes = [Reciepe]()
    var recipeEntity = RecipeEntity()
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inidicator: UIActivityIndicatorView!
     var isInitialBool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        isInitialBool = true
        collectionView.delegate = self
        collectionView.dataSource = self
        Utlites.registerCell(collectionView:collectionView)
        inidicator.startAnimating()
        viewModel.bindResultToView = { [weak self]  in
            DispatchQueue.main.async {
                self?.arrayOfReciebes = self?.viewModel.res.results ?? []
                self?.myTable.reloadData()
                self?.inidicator.stopAnimating()
                self?.inidicator.isHidden = true
            }
        }
        
        viewModel.getData()

        print("Hello World :)")
        myTable.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "CellRecipe")
        
        let layout = UICollectionViewCompositionalLayout{ index , environment in
            return self.drawTopSection()
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
  
    func callAPIToGetData (category:String){
        inidicator.isHidden = false
        inidicator.startAnimating()
        viewModel.category = category
        viewModel.getData()
    }

}

extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource ,UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfReciebes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(174)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecipe", for: indexPath) as!CellRecipe
       
       // myRecipe = arrayOfReciebes[indexPath.row]
        cell.imgBG.layer.cornerRadius = 10
        cell.imgBG?.kf.setImage(with:URL(string: arrayOfReciebes[indexPath.row].thumbnailURL ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
        
        cell.imgLike.image = UIImage(named: "imgLike")
        cell.labelRecipeName.text = arrayOfReciebes[indexPath.row].name
        cell.labelChefName.text = "\(arrayOfReciebes[indexPath.row].credits?[0].name ?? "")"
        cell.labelPike.text = arrayOfReciebes[indexPath.row].show?.name
        cell.labelServings.text = arrayOfReciebes[indexPath.row].yields ?? "Servings:0"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.imgLike.tag = indexPath.row
        cell.imgLike.isUserInteractionEnabled = true
        cell.imgLike.addGestureRecognizer(tapGesture)
        cell.cellReciepe = arrayOfReciebes[indexPath.row]
        return cell

    }
    @objc func imageTapped(_ sender : UITapGestureRecognizer ) {
        print("Image tapped!")
        if let favoritedCellImage = sender.view as? UIImageView {
            if let selectedCell = favoritedCellImage.superview?.superview as? CellRecipe{
                  recipeEntity = RecipeEntity(criditName: selectedCell.cellReciepe.credits?[0].name ,recipeImg: selectedCell.cellReciepe.thumbnailURL,recipeName: selectedCell.cellReciepe.name,recipeUrl: selectedCell.cellReciepe.videoURL,showName: selectedCell.cellReciepe.show?.name,yeild: selectedCell.cellReciepe.yields,id: selectedCell.cellReciepe.id)
                 
                if(favViewModel.isRecipeExist(recipe: recipeEntity) == true)
                {
                    let alert = UIAlertController(title: "Alert", message: "This Item already Saved", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    print("Already saved")
                    
                }else{
                    favViewModel.insertFavRecipe(recipe: recipeEntity)
                    selectedCell.imgLike.image = UIImage(named: "like-2")
                }
                
               
                
            }
        }
        
     
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.cellBg.layer.cornerRadius = 15
        cell.cellName.text = viewModel.categoryNames[indexPath.row]
        cell.cellImage.image = UIImage(named: viewModel.categoryImages[indexPath.row])
        
        if isInitialBool && indexPath.row == 0{
            cell.img.image = UIImage(named: "clicked")
            isInitialBool = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        let category = viewModel.categoryImages[indexPath.row]
       // cell.cellBg.backgroundColor = UIColor(red: 217, green: 150, blue: 81, alpha: 1)
       
        cell.img.image = UIImage(named: "clicked")
        callAPIToGetData(category: category)
        if indexPath.row != 0 {
            let myindex : IndexPath = IndexPath(row: 0, section: indexPath.section)
            let firstcell = collectionView.cellForItem(at: myindex) as! CategoryCell
            firstcell.img.image = UIImage(named: "idel")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 10) // Adjust the height as per your requirements
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.img.image = UIImage(named: "idel")
    
    }
    
  
    
    func drawTopSection() -> NSCollectionLayoutSection{
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing:8)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top:6, leading: 6, bottom: 0, trailing: 6)

            return section
        }
    
}
