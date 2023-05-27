//
//  RecipeCoreDataProtocol.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation

protocol RecipeCoreDataProtocol {
    
    func insertFavRecipe(recipeInserted: RecipeEntity)
    func getStoredRecipe() -> [RecipeEntity]
    func deleteFavRecipe(recipe : RecipeEntity)
    func isRecipeExist(recipe : RecipeEntity) -> Bool
}
