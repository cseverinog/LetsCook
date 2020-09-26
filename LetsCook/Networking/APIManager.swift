//
//  APIManager.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    static let recipesEndpoint = "https://gl-endpoint.herokuapp.com/recipes/"
    static var shared = APIManager()
    
    private init() {}
    
    func getRecipes(completion: @escaping ((_ recipes: [Recipe]) -> Void)) {
        guard let url = URL(string: APIManager.recipesEndpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print(error?.localizedDescription)
                completion([])
            } else {
                guard let data = data else {
                    completion([])
                    return
                }
                
                do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    completion(recipes)
                    
                } catch {
                    completion([])
                }
            }
            
        }.resume()
    }
    
    func getRecipeDetail(with id: Int, completion: @escaping ((_ recipeDetail: RecipeDetail?) -> Void)) {
        guard let url = URL(string: "\(APIManager.recipesEndpoint)\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print(error?.localizedDescription)
                completion(nil)
            } else {
                guard let data = data else {
                    completion(nil)
                    return
                }
                do {
                    let recipeDetail = try JSONDecoder().decode(RecipeDetail.self, from: data)
                    completion(recipeDetail)
                } catch {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func getImage(with urlString: String, completion: @escaping((_ image: UIImage?) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print(error?.localizedDescription)
                completion(nil)
            } else {
                guard let data = data else {
                    completion(nil)
                    return
                }
                completion(UIImage(data: data))
            }
        }.resume()
    }
}
