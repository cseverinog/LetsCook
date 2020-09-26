//
//  RecipeViewModel.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import Foundation

protocol RecipeViewModelProtocol {
    var id: Int { get }
    var title: String { get }
}

class RecipeViewModel: RecipeViewModelProtocol {
    
    let recipe: Recipe
    
    var id: Int {
        return recipe.id
    }
    
    var title: String {
        return recipe.title
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
