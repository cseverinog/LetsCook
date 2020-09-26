//
//  RecipeDetailViewViewModel.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeDetailViewViewModelProtocol {
    var title: String? { get }
    var instructions: String? { get }
    func getRecipeDetail(completion: @escaping ((Bool) -> Void))
    func setImage(to imageView: UIImageView)
    func setRating(to imageCollection: [UIImageView])
}

class RecipeDetailViewViewModel: RecipeDetailViewViewModelProtocol {
    var recipeId: Int
    var recipeDetail: RecipeDetailViewModel?
    
    var title: String? {
        return recipeDetail?.title
    }
    
    var instructions: String? {
        return recipeDetail?.instructions
    }
    
    init(recipeId: Int) {
        self.recipeId = recipeId
    }
    
    func getRecipeDetail(completion: @escaping ((Bool) -> Void)) {
        APIManager.shared.getRecipeDetail(with: recipeId) { [weak self] (recipeDetail) in
            guard let recipeDetail = recipeDetail else { return }
            self?.recipeDetail = RecipeDetailViewModel(recipeDetail: recipeDetail)
            completion(true)
        }
    }
    
    func setImage(to imageView: UIImageView) {
        recipeDetail?.getImage(completion: { (image) in
            DispatchQueue.main.async {
                imageView.image = image
            }
        })
    }
    
    func setRating(to imageCollection: [UIImageView]) {
        for i in 0..<(recipeDetail?.rating ?? 0) {
            imageCollection[i].image = #imageLiteral(resourceName: "fill_star")
        }
        
        for i in (recipeDetail?.rating ?? 0)..<5 {
            imageCollection[i].image = #imageLiteral(resourceName: "unfilled_star")
        }
    }
}
