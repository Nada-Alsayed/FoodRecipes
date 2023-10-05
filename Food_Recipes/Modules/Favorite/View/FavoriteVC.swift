//
//  FavoriteVC.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit
import Reachability
 
 class FavoriteVC: UIViewController {

   @IBOutlet weak var noRecipeImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var favArr:[RecipeEntity] = []
    var favViewModel:FavoriteViewModel?
    var reachability:Reachability?
    var flagForRech :Bool?
    var recipeEntity = RecipeEntity()
     override func viewDidLoad() {
         super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "CellRecipe")
        favViewModel = FavoriteViewModel(coreData:RecipieCoreData.sharedInstance)
    var favArr:[RecipeEntity] = favViewModel?.getSoredFavs() ?? []
    }

    override func viewWillAppear(_ animated: Bool) {
        favArr = []
        favArr = favViewModel?.getSoredFavs() ?? []
        tableView.reloadData()
        if(favArr.count != 0){
            noRecipeImg.isHidden = true
        }else{
            noRecipeImg.isHidden = false
            noRecipeImg.image = UIImage(named:"no favourite place holder")
        }
     }
 }
extension FavoriteVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favArr.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(174)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecipe", for: indexPath) as!CellRecipe
        cell.imgBG.layer.cornerRadius = 9
        cell.imgBG?.kf.setImage(with:URL(string: favArr[indexPath.row].recipeImg ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
        cell.imgLike.image = UIImage(named: "like-2")
        cell.labelRecipeName.text = favArr[indexPath.row].recipeName
        cell.labelChefName.text = "\(favArr[indexPath.row].criditName ?? "")"
        cell.labelPike.text = favArr[indexPath.row].showName
        cell.labelServings.text = favArr[indexPath.row].yeild ?? "Servings:0"
        
        cell.onDeleteTapped = { [weak self] in
            self?.deleteItem(at: indexPath.row, myrecipe: self?.favArr[indexPath.row] ?? RecipeEntity())
        }
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        //        cell.imgLike.tag = indexPath.row
        //        cell.imgLike.isUserInteractionEnabled = true
        //        cell.imgLike.addGestureRecognizer(tapGesture)
        //        cell.cellEntityRecipe = favArr[indexPath.row]
        
        return cell
        
    }
    
    func deleteItem(at index: Int,myrecipe:RecipeEntity) {

        if(favViewModel?.isRecipeExist(recipe: myrecipe.id ?? 0)==true){

            let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.favArr.remove(at: index)
                self.favViewModel?.deleteFavRecipe(recipe: myrecipe)
                self.favViewModel?.getSoredFavs()
                if self.favArr.count == 0{
                    self.noRecipeImg.isHidden = false
                    self.noRecipeImg.image = UIImage(named:"no favourite place holder")
                }else{
                    self.noRecipeImg.isHidden = true
                }

                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Handle the delete action
                let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                    self.favViewModel?.deleteFavRecipe(recipe: self.favArr[indexPath.row])
                   // self.favViewModel?.getSoredFavs()
                    self.favArr.remove(at: indexPath.row)
                    if self.favArr.count == 0{
                        self.noRecipeImg.isHidden = false
                        self.noRecipeImg.image = UIImage(named:"no favourite place holder")
                    }else{
                        self.noRecipeImg.isHidden = true
                    }
                    tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }

}


