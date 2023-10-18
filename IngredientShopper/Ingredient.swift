//  Ingredient.swift
//  IngredientShopper
//  Created by Cameron Alexander Cutler on 10/11/23.
import UIKit
class Ingredient: Equatable, Codable {
    var name: String
    var meal: String
    var store: String
    var priceInDollars: Int
    init(name: String, meal: String, store: String, priceInDollars: Int) {
        self.name = name
        self.meal = meal
        self.store = store
        self.priceInDollars = priceInDollars
    }
    convenience init() {
        self.init(name: "", meal: "", store: "", priceInDollars: 0)
    }
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name == rhs.name && lhs.priceInDollars == rhs.priceInDollars && lhs.meal == rhs.meal && lhs.store == rhs.store
    }
}
