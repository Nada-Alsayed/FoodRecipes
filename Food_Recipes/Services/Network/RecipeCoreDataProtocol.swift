//
//  RecipeCoreDataProtocol.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation

protocol RecipeCoreDataProtocol {
    
    func insertFavRecipe(recipeInserted: Recipe)
    func getStoredRecipe() -> [Recipe]
    func deleteFavRecipe(recipe : Recipe)
    func isRecipeExist(recipe : Recipe) -> Bool
}
