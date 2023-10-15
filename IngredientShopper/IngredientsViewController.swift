//  IngredientsViewController.swift
//  IngredientShopper
//  Created by Cameron Alexander Cutler on 10/11/23.
import UIKit
class IngredientsViewController: UITableViewController {
    var ingredientStore: IngredientStore!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientStore.allIngredients.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = ingredientStore.allIngredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        cell.detailTextLabel?.text = "$\(ingredient.priceInDollars)"
        return cell
    }
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let newIngredient = ingredientStore.createIngredient()
        if let index = ingredientStore.allIngredients.firstIndex(of: newIngredient) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ingredient = ingredientStore.allIngredients[indexPath.row]
            ingredientStore.removeIngredient(ingredient)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        ingredientStore.moveIngredient(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
