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

     override func viewDidLoad() {
         super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
       //  Utlites.registerTableCell(tableView:self.tableView)
         tableView.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "CellRecipe")
         favViewModel = FavoriteViewModel(coreData: RecipieCoreData.sharedInstance)
    var favArr:[RecipeEntity] = favViewModel?.getSoredFavs() ?? []
     //   favLabel.text = favArr[0].recipeName
        //favLabel.text = "Eman"
    }

    override func viewWillAppear(_ animated: Bool) {

       if(favViewModel?.getSoredFavs() != nil){
            favArr = favViewModel?.getSoredFavs() ?? []
            tableView.reloadData()
            noRecipeImg.isHidden = true
        }else{
            noRecipeImg.isHidden = false
            noRecipeImg.image = UIImage(named: "no favourite place holder")
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
       
     //   myRecipe = arrayOfReciebes[indexPath.row]
        cell.imgBG.layer.cornerRadius = 9
        cell.imgBG?.kf.setImage(with:URL(string: favArr[indexPath.row].recipeImg ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
        
        cell.imgLike.image = UIImage(named: "imgLike")
        cell.labelRecipeName.text = favArr[indexPath.row].recipeName
        cell.labelChefName.text = "\(favArr[indexPath.row].criditName ?? "")"
        cell.labelPike.text = favArr[indexPath.row].showName
        cell.labelServings.text = favArr[indexPath.row].yeild ?? "Servings:0"
        

        return cell

    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Handle the delete action
            let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.favViewModel?.deleteFavRecipe(recipe: self.favArr[indexPath.row])
                self.favViewModel?.getSoredFavs()
                self.favArr.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               present(alert, animated: true, completion: nil)
        }
    }
}
