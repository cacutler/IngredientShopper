//  IngredientStore.swift
//  IngredientShopper
//  Created by Cameron Alexander Cutler on 10/13/23.
import UIKit
class IngredientStore {
    var allIngredients = [Ingredient]()
    let ingredientArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("ingredients.plist")
    }()
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
    @objc func saveChanges() -> Bool {
        print("Saving ingredients to: \(ingredientArchiveURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allIngredients)
            try data.write(to: ingredientArchiveURL, options: [.atomic])
            print("Saved all of the ingredients")
            return true
        } catch let encodingError {
            print("Error encoding allIngredients: \(encodingError)")
            return false
        }
    }
    init() {
        do {
            let data = try Data(contentsOf: ingredientArchiveURL)
            let unarchiver = PropertyListDecoder()
            let ingredients = try unarchiver.decode([Ingredient].self, from: data)
            allIngredients = ingredients
        } catch {
            print("Error reading in saved ingredients: \(error)")
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
}
