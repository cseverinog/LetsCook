//
//  RecipeDetailViewModel.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeDetailViewModelProtocol: RecipeViewModelProtocol {
    var rating: Int { get }
    var instructions: String { get }
    
    func getImage(completion: @escaping((_ image: UIImage?) -> Void))
}

class RecipeDetailViewModel: RecipeDetailViewModelProtocol {
    var recipeDetail: RecipeDetail
    
    var id: Int {
        return recipeDetail.id
    }
    
    var title: String {
        return recipeDetail.title
    }
    
    var rating: Int {
        return recipeDetail.rating
    }
    
    var instructions: String {
        return recipeDetail.instructions
    }
    
    init(recipeDetail: RecipeDetail) {
        self.recipeDetail = recipeDetail
    }
    
    func getImage(completion: @escaping ((UIImage?) -> Void)) {
        APIManager.shared.getImage(with: recipeDetail.imageURL, completion: completion)
    }
}
