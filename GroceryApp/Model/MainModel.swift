//
//  File.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI
import RealmSwift

// MARK: - Model of Products
struct GroceryItemModel: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let rating: Double?
    let reviewsCount: Int
    let manufacturerName: String?
    let manufacturerImage: String?
    let price: Double
    let oldPrice: Double?
    let discountPercent: Int?
    let isFavorite: Bool
    let isNew: Bool
    let isHitToPrices: Bool
    let isPriceByCard: Bool
}

// MARK: - Model of items for adding to Busket and saving in Realm
class CartItemModel: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var itemID: String = ""
    @objc dynamic var itemName: String = ""
    @objc dynamic var unit: String = "Кг"
    @objc dynamic var quantity: Double = 1.0
    @objc dynamic var price: Double = 0.0

    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Model for saving states of Cells
class GroceryItemState: ObservableObject {
    @Published var selectedUnit: String
    @Published var quantity: Double
    @Published var isBusketHidden: Bool
    @Published var isSegmentedControlHidden: Bool
    @Published var isFav: Bool

    init(
        selectedUnit: String = "Кг",
        quantity: Double = 1,
        isBusketHidden: Bool = false,
        isSegmentedControlHidden: Bool = true,
        isFav: Bool = false
    ) {
        self.selectedUnit = selectedUnit
        self.quantity = quantity
        self.isBusketHidden = isBusketHidden
        self.isSegmentedControlHidden = isSegmentedControlHidden
        self.isFav = isFav
    }
}


// MARK: - Additional Methods and Views
struct CustomRoundedRectangle: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
