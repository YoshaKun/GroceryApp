//
//  ViewModel.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI
import Combine
import RealmSwift

class ViewModel: ObservableObject {
    @Published var isList: Bool = true
    @Published var cornerRadiusCell: CGFloat = 20
    @Published var cartItems: [CartItemModel] = []
    @Published var groceryArray: [GroceryItemModel]
    @Published var itemStates: [UUID: GroceryItemState] = [:]
    
    // MARK: - REALM Instance member
    private var realm = try! Realm()
    
    init() {
        self.groceryArray = mokGroceriesArray
        self.initializeStates(for: mokGroceriesArray)
    }

    private func initializeStates(for items: [GroceryItemModel]) {
        for item in items {
            itemStates[item.id] = GroceryItemState()
        }
    }

    // MARK: - Loading Items in Busket
    func loadCartItems() {
        let items = realm.objects(CartItemModel.self)
        cartItems = Array(items)
    }

    // MARK: - Adding items in Busket
    func addToCart(item: GroceryItemModel, quantity: Double, unit: String) {
        if let existingItem = cartItems.first(where: { $0.itemID == item.id.uuidString }) {
            try! realm.write {
                existingItem.quantity += quantity
            }
        } else {
            let cartItem = CartItemModel()
            cartItem.itemID = item.id.uuidString
            cartItem.itemName = item.title
            cartItem.unit = unit
            cartItem.quantity = quantity
            cartItem.price = item.price
            
            try! realm.write {
                realm.add(cartItem)
            }
        }
        loadCartItems()
    }
    
    func decrementQuantity(for item: GroceryItemModel) {
        if let cartItem = cartItems.first(where: { $0.itemID == item.id.uuidString }) {
            try! realm.write {
                if cartItem.quantity > 1 {
                    cartItem.quantity -= 1
                } else if cartItem.quantity <= 1 {
                    realm.delete(cartItem)
                }
            }
            loadCartItems()
        }
    }
    
    func clearBusket() {
        do {
            let allItems = realm.objects(CartItemModel.self)
            try realm.write {
                realm.delete(allItems)
            }
            print("Cart cleared successfully.")
        } catch let error {
            print("Failed to clear cart: \(error.localizedDescription)")
        }
    }
    
    func removeFromCart(item: CartItemModel) {
        try! realm.write {
            realm.delete(item)
        }
        loadCartItems()
    }
    
    func calculateTotal() -> Double {
        let sum = cartItems.reduce(0) { $0 + $1.price * $1.quantity }
        return sum
    }
    
    func calculateTotalItems() -> Int {
        return cartItems.count
    }
    
    // MARK: - MOK Model
    private let mokGroceriesArray: [GroceryItemModel] = [
        GroceryItemModel(
            image: Image("Image_0"),
            title: "сыр Ламбер 500/0 230г",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: "Франция",
            manufacturerImage: "🇫🇷",
            price: 12299.90,
            oldPrice: 199.0,
            discountPercent: 19,
            isFavorite: true,
            isNew: false,
            isHitToPrices: true,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_1"),
            title: "Энергетический Напит",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: nil,
            manufacturerImage: nil,
            price: 99.90,
            oldPrice: 199.0,
            discountPercent: nil,
            isFavorite: false,
            isNew: true,
            isHitToPrices: false,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_2"),
            title: "Салат Овощной с Крабовыми Палочками",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: nil,
            manufacturerImage: nil,
            price: 99.90,
            oldPrice: 199.0,
            discountPercent: nil,
            isFavorite: false,
            isNew: false,
            isHitToPrices: false,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_3"),
            title: "Дорадо Охлажденная Непотрошеная 300-400г",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: "Франция",
            manufacturerImage: "🇫🇷",
            price: 12299.90,
            oldPrice: 199.0,
            discountPercent: 25,
            isFavorite: false,
            isNew: false,
            isHitToPrices: false,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_4"),
            title: "Ролл Маленькая Япония 216г",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: nil,
            manufacturerImage: nil,
            price: 99.90,
            oldPrice: 199.0,
            discountPercent: 25,
            isFavorite: false,
            isNew: false,
            isHitToPrices: false,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_5"),
            title: "Огурцы тепличные cадово-огородные",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: nil,
            manufacturerImage: nil,
            price: 99.90,
            oldPrice: 199.0,
            discountPercent: 25,
            isFavorite: false,
            isNew: false,
            isHitToPrices: false,
            isPriceByCard: true
        ),
        GroceryItemModel(
            image: Image("Image_6"),
            title: "Манго Кео",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: "Франция",
            manufacturerImage: "🇫🇷",
            price: 12299.90,
            oldPrice: 199.0,
            discountPercent: 25,
            isFavorite: true,
            isNew: false,
            isHitToPrices: true,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_7"),
            title: "Салат Овощной с Крабовыми Палочками",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: nil,
            manufacturerImage: nil,
            price: 99.90,
            oldPrice: 199.0,
            discountPercent: 25,
            isFavorite: false,
            isNew: false,
            isHitToPrices: false,
            isPriceByCard: false
        ),
        GroceryItemModel(
            image: Image("Image_8"),
            title: "Масло Слобода Рафинированное 1,8л",
            rating: 4.1,
            reviewsCount: 19,
            manufacturerName: nil,
            manufacturerImage: nil,
            price: 99.90,
            oldPrice: 199.0,
            discountPercent: 25,
            isFavorite: false,
            isNew: false,
            isHitToPrices: false,
            isPriceByCard: false
        )
    ]
}
