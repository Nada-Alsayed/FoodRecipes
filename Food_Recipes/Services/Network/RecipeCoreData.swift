//
//  RecipeCoreData.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation
import CoreData
import UIKit

class RecipieCoreData:RecipeCoreDataProtocol{
    
    var manager : NSManagedObjectContext!
    var recipesArr : [NSManagedObject] = []
    var recipeToBeDeleted : NSManagedObject?
    
    static let sharedInstance = RecipieCoreData()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    
    func insertFavRecipe(recipeInserted: Recipe) {
        
        let entity = NSEntityDescription.entity(forEntityName: "FavReciepe", in: manager)
        let recipe = NSManagedObject(entity: entity ?? NSEntityDescription(), insertInto: manager)
        recipe.setValue(recipeInserted.recipeName, forKey: "recipeName")
        recipe.setValue(recipeInserted.showName, forKey: "showName")
        recipe.setValue(recipeInserted.criditName, forKey: "criditName")
        recipe.setValue(recipeInserted.recipeImg, forKey: "recipeImg")
        recipe.setValue(recipeInserted.recipeUrl, forKey: "recipeUrl")
        recipe.setValue(recipeInserted.yeild, forKey: "yeild")
        recipe.setValue(recipeInserted.id, forKey: "id")

        do{
            try manager.save()
            print("Recipe Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getStoredRecipe() -> [Recipe] {
        var recipes = [Recipe]()
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavReciepe")

        do{
            recipesArr = try manager.fetch(fetch)
            if(recipesArr.count > 0){
                recipeToBeDeleted = recipesArr.first
            }

            for i in recipesArr{
                var myRecipe = Recipe()
                myRecipe.recipeName = i.value(forKey: "recipeName") as? String
                myRecipe.criditName = i.value(forKey: "criditName") as? String
                myRecipe.showName = i.value(forKey: "showName") as? String
                myRecipe.yeild = i.value(forKey: "yeild") as? String
                myRecipe.recipeUrl = i.value(forKey: "recipeUrl") as? String
                myRecipe.recipeImg = i.value(forKey: "recipeImg") as? String
                myRecipe.id = i.value(forKey: "id") as? Int
                recipes.append(myRecipe)
            }

        }catch let error{
            print(error.localizedDescription)
        }

        return recipes
    }
    
    func deleteFavRecipe(recipe: Recipe) {
        for i in recipesArr{
            if ((i.value(forKey: "recipeName") as! String) == recipe.recipeName){

               recipeToBeDeleted = i
            }
        }

        guard let recipe1 = recipeToBeDeleted else{
          //  print("cannot be deleted!")
          //  showToast(message: "cannot be deleted!", font: .systemFont(ofSize: 12.0))
            return
        }
        manager.delete(recipe1)
        do{
            try manager.save()
            print("FavRecipe Deleted!")
            recipeToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
            print("FavRecipe not deleted!!")
        }
    }
    
    func isRecipeExist(recipe: Recipe) -> Bool {
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavReciepe")
        let predicate = NSPredicate(format: "id == %i", recipe.id ?? 0)

        fetch.predicate = predicate
        
        do{
            recipesArr = try manager.fetch(fetch)
            if(recipesArr.count > 0){
                print("Fav is exist")
                return true
            }else{
                print("Fav is Not exist")
                return false
            }


        }catch let error{
            print(error.localizedDescription)
        }

        return false
        
    }
    
    
}
