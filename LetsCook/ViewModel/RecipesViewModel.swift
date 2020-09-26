//
//  RecipesViewModel.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import Foundation

protocol RecipesViewModelProtocol {
    
    func numberOfRecipes() -> Int
    func getRecipes(completion: @escaping ((Bool) -> Void))
    func recipe(at index: Int) -> RecipeViewModel
}

class RecipesViewModel: RecipesViewModelProtocol {
    
    var recipes = [RecipeViewModel]()
    
    func numberOfRecipes() -> Int {
        return recipes.count
    }
    
    func getRecipes(completion: @escaping ((Bool) -> Void)) {
        APIManager.shared.getRecipes {[weak self] (recipes) in
            self?.recipes = recipes.map { RecipeViewModel(recipe: $0)}
            completion(true)
        }
    }
    
    func recipe(at index: Int) -> RecipeViewModel {
        return recipes[index]
    }
}
