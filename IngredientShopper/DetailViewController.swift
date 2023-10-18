//  DetailViewController.swift
//  IngredientShopper
//  Created by Cameron Alexander Cutler on 10/15/23.
import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var mealField: UITextField!
    @IBOutlet var storeField: UITextField!
    @IBOutlet var priceField: UITextField!
    var ingredient: Ingredient! {
        didSet {
            navigationItem.title = ingredient.name
        }
    }
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = ingredient.name
        mealField.text = ingredient.meal
        storeField.text = ingredient.store
        priceField.text = numberFormatter.string(from: NSNumber(value: ingredient.priceInDollars))
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        ingredient.name = nameField.text ?? ""
        ingredient.meal = mealField.text ?? ""
        ingredient.store = storeField.text ?? ""
        if let priceText = priceField.text, let price = numberFormatter.number(from: priceText) {
            ingredient.priceInDollars = price.intValue
        } else {
            ingredient.priceInDollars = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
