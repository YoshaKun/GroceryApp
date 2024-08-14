//
//  File.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI

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
