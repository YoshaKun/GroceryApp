//
//  ViewModel.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var isList: Bool = true
    @Published var cornerRadiusCell: CGFloat = 20
    
    let titlesArray: [String] = [
        "сыр Ламбер 500 / 0 230г",
        "Энергетический Напит",
        "Салат Овощной с Крабовыми Палочками",
        "Дорадо Охлажденная Непотрошеная 300-400г",
        "Ролл Маленькая Япония 216г",
        "Огурцы тепличные cадово-огородные",
        "Манго Кео",
        "Салат Овощной с Крабовыми Палочками",
        "Салат Овощной с Крабовыми Палочками",
        "Масло Слобода Рафинированное 1,8л",
        "Салат Овощной с Крабовыми Палочками",
        "Макаронные Изделия SPAR Спагетти 450г",
        "Огурцы тепличные cадово-огородные",
        "Огурцы тепличные cадово-огородные",
        "Огурцы тепличные cадово-огородные",
        "Дорадо Охлажденная Непотрошеная 300-400г",
        "Энергетический Напиток AdrenaIine Rush 0,449л ж/б",
        "Манго Кео",
        "сыр Ламбер 500/0 230г",
        "сыр Ламбер 500/0 230г",
        "сыр Ламбер 500/0 230г",
        "сыр Ламбер 500/0 230г"
    ]
    
    let priceArray: [Double] = [
        99.90,
        95699.90,
        250.90,
        99.90,
        367.90,
        99.90,
        1298.90,
        120.90,
        1298.90,
        1298.90,
        250.00,
        2600.90,
        120.90,
        120.90,
        99.90,
        120.90,
        99.90,
        95699.90,
        95699.90,
        95699.90,
        95699.90,
        95699.90
    ]
    
    private func generateGroceryItems() -> [GroceryItemModel] {
        var groceryArray: [GroceryItemModel] = []
        
        for i in 0..<20 {
            let item = GroceryItemModel(
                image: Image("Image_\(i % 10)"), // используем остаток от деления для разнообразия картинок
                title: "Продукт \(i + 1)",
                rating: Double.random(in: 3.0...5.0),
                reviewsCount: Int.random(in: 10...100),
                manufacturerName: i % 2 == 0 ? "Производитель \(i + 1)" : nil, // через раз есть название производителя
                manufacturerImage: i % 2 == 0 ? "🇷🇺" : nil, // через раз есть иконка производителя
                price: Double.random(in: 50.0...1000.0),
                oldPrice: Double.random(in: 100.0...2000.0),
                discountPercent: Int.random(in: 5...30),
                isFavorite: Bool.random(),
                isNew: Bool.random(),
                isHitToPrices: Bool.random(),
                isPriceByCard: Bool.random()
            )
            
            groceryArray.append(item)
        }
        
        return groceryArray
    }
    
    let groceryArray: [GroceryItemModel] = [
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
