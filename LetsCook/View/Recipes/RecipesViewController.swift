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
    let searchController = UISearchController(searchResultsController: nil)
    
    var recipesViewModel: RecipesViewModelProtocol?
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        recipesViewModel = RecipesViewModel()
        loadingIndicator.startAnimating()
        recipesViewModel?.getRecipes(completion: { [weak self] _ in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.recipesTableView.reloadData()
            }
        })
        
        configureSearchController()
    }
    
    fileprivate func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
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
        let numberOfRecipes = recipesViewModel?.numberOfRecipes() ?? 0
        noResultsLabel.isHidden = !(numberOfRecipes == 0 && !isSearchBarEmpty)
        return numberOfRecipes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableId) else { return UITableViewCell() }
        configure(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let recipe = recipesViewModel?.recipe(at: indexPath.row)
        performSegue(withIdentifier: segueId, sender: recipe?.id)
    }
}

extension RecipesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterRecipesForText(searchController.searchBar.text ?? "")
    }
    
    func filterRecipesForText(_ text: String) {
        recipesViewModel?.filterRecipes(for: text)
        recipesTableView.reloadData()
    }
    
}
