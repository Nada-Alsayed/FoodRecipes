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
    
    var favArray:[RecipeEntity]!
    
    init( coreData: RecipeCoreDataProtocol!) {
        self.coreData = coreData
    }
    
    func getSoredFavs() -> [RecipeEntity]{
        return coreData.getStoredRecipe()
    }
    

    func deleteFavRecipe(recipe:RecipeEntity){
        coreData.deleteFavRecipe(recipe: recipe)
    }
    
    
    func insertFavRecipe(recipe:RecipeEntity){
        coreData.insertFavRecipe(recipeInserted: recipe)
    }
    
    func isRecipeExist(recipe:RecipeEntity)->Bool{
        return coreData.isRecipeExist(recipe: recipe)
    }
    
}
