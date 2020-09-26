//
//  RecipeDetailViewController.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipeId: Int!
    var recipeDetailVM: RecipeDetailViewViewModelProtocol?
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet var ratingImages: [UIImageView]!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailVM = RecipeDetailViewViewModel(recipeId: recipeId)
        
        recipeDetailVM?.getRecipeDetail(completion: { [weak self] _ in
            self?.updateView()
        })
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.recipeDetailVM?.setImage(to: self.recipeImage)
            self.recipeDetailVM?.setRating(to: self.ratingImages)
            self.navigationItem.title = self.recipeDetailVM?.title
            self.instructionsTextView.text = self.recipeDetailVM?.instructions
        }
    }
}
