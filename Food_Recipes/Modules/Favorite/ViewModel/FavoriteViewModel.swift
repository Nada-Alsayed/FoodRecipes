//
//  FavriteViewModel.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation

class FavoriteViewModel {
    
    var coreData : RecipeCoreDataProtocol!
    
    var bindResultToView : (()->()) = {}
    
    var favArray:[Recipe]!
    
    init( coreData: RecipeCoreDataProtocol!) {
        self.coreData = coreData
    }
    
    func getSoredFavs() -> [Recipe]{
        return coreData.getStoredRecipe()
    }
    

    func deleteFavRecipe(recipe:Recipe){
        coreData.deleteFavRecipe(recipe: recipe)
    }
    
    
    func insertFavRecipe(recipe:Recipe){
        coreData.insertFavRecipe(recipeInserted: recipe)
    }
    
    func isRecipeExist(recipe:Recipe)->Bool{
        return coreData.isRecipeExist(recipe: recipe)
    }
    
}
