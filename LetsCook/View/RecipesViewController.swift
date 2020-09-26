//
//  RecipesViewController.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    let reusableId = "recipeCell"
    let segueId = "recipeDetail"
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipesTableView: UITableView!
    
    var recipesViewModel: RecipesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        recipesViewModel = RecipesViewModel()
        recipesViewModel?.getRecipes(completion: { [weak self] _ in
            DispatchQueue.main.async {
                self?.recipesTableView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func configure(cell: UITableViewCell, index: Int) {
        let recipe = recipesViewModel?.recipe(at: index)
        cell.textLabel?.text = recipe?.title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC  = segue.destination as? RecipeDetailViewController, let recipeId = sender as? Int {
            destinationVC.recipeId = recipeId
        }
    }
}

extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesViewModel?.numberOfRecipes() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableId) else { return UITableViewCell() }
        configure(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipesViewModel?.recipe(at: indexPath.row)
        performSegue(withIdentifier: segueId, sender: recipe?.id)
    }
}
