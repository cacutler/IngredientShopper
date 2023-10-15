//  IngredientStore.swift
//  IngredientShopper
//  Created by Cameron Alexander Cutler on 10/13/23.
import UIKit
class IngredientStore {
    var allIngredients = [Ingredient]()
    @discardableResult func createIngredient() -> Ingredient {
        let newIngredient = Ingredient()
        allIngredients.append(newIngredient)
        return newIngredient
    }
    func removeIngredient(_ ingredient: Ingredient) {
        if let index = allIngredients.firstIndex(of: ingredient) {
            allIngredients.remove(at: index)
        }
    }
    func moveIngredient(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedIngredient = allIngredients[fromIndex]
        allIngredients.remove(at: fromIndex)
        allIngredients.insert(movedIngredient, at: toIndex)
    }
}
