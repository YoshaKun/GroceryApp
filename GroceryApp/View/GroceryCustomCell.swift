//
//  GroceryCustomCell.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI

struct GroceryCustomCell: View {
    
    // MARK: - View model reference as Observable object
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var itemState: GroceryItemState
    
    let isList: Bool
    let item: GroceryItemModel
    
    var body: some View {
        if isList {
            // MARK: - List Cell
            HStack {
                ZStack {
                    // MARK: - Image
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing, 16)
                    
                    // MARK: - Flag view
                    if item.isNew || item.isHitToPrices || item.isPriceByCard {
                        createFlag()
                    }
                    createDiscountList()
                        .padding(.trailing, 20)
                }
                .frame(width: UIScreen.main.bounds.width * 0.42)
                .padding(.leading, 16)
                .padding(.top, 16)
                
                // MARK: - Description
                
                ZStack {
                    VStack(alignment: .leading) {
                        createReviewsView()
                        
                        createTitleAndCountry()
                        createSegmentedControl()
                        
                        if itemState.isBusketHidden {
                            // MARK: - Segmented control
                            
                            chooseCountOfProduct()
                        } else {
                            // MARK: - Price and busket button
                            createPriceAndBusketView()
                        }
                    }
                    // MARK: - Favorite and listing buttons
                    createFavoriteAndListView()
                }
            }
            .frame(height: UIScreen.main.bounds.width * 0.4)
            .padding(.top, 10)
            .padding(.bottom, 20)
            .padding(.trailing, 16)
            
        } else {
            // MARK: - Grid Cell
            VStack(alignment: .leading) {
                ZStack {
                    // MARK: - Image
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    // MARK: - Flag view
                    if item.isNew || item.isHitToPrices || item.isPriceByCard {
                        createFlag()
                    }
                    
                    // MARK: - Favorite view
                    createFavoriteAndListView()
                    createReviewsView()
                }
                .padding(.bottom, 5)
                
                createTitleAndCountry()
                createSegmentedControl()
                
                if itemState.isBusketHidden {
                    // MARK: - Segmented control
                    
                    chooseCountOfProduct()
                } else {
                    // MARK: - Price and busket button
                    createPriceAndBusketView()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(viewModel.cornerRadiusCell)
            .frame(height: 278)
        }
    }
    
    // MARK: - Create custom Flag in top of the Cells
    
    @ViewBuilder
    private func createFlag() -> some View {
        VStack {
            HStack {
                if item.isNew {
                    Text("Новинки")
                        .padding(.leading, 15)
                        .padding(.top, 2)
                        .padding(.bottom, 4)
                        .padding(.trailing, 6)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10))
                        .background(Color(.customPurple))
                        .clipShape(CustomRoundedRectangle(corners: [.topRight, .bottomRight], radius: 8))
                        .clipShape(CustomRoundedRectangle(corners: [.topLeft], radius: viewModel.cornerRadiusCell))
                        .clipShape(CustomRoundedRectangle(corners: [.bottomLeft], radius: 0))
                } else if item.isHitToPrices {
                    Text("Удар по ценам")
                        .lineLimit(1, reservesSpace: false)
                        .padding(.leading, 15)
                        .padding(.top, 2)
                        .padding(.bottom, 4)
                        .padding(.trailing, 6)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10))
                        .background(Color(.customLightRed))
                        .clipShape(CustomRoundedRectangle(corners: [.topRight, .bottomRight], radius: 8))
                        .clipShape(CustomRoundedRectangle(corners: [.topLeft], radius: viewModel.cornerRadiusCell))
                        .clipShape(CustomRoundedRectangle(corners: [.bottomLeft], radius: 0))
                } else if item.isPriceByCard {
                    Text("Цена по карте")
                        .lineLimit(1, reservesSpace: false)
                        .padding(.leading, 15)
                        .padding(.top, 2)
                        .padding(.bottom, 4)
                        .padding(.trailing, 6)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10))
                        .background(Color(.customLightGreen))
                        .clipShape(CustomRoundedRectangle(corners: [.topRight, .bottomRight], radius: 8))
                        .clipShape(CustomRoundedRectangle(corners: [.topLeft], radius: viewModel.cornerRadiusCell))
                        .clipShape(CustomRoundedRectangle(corners: [.bottomLeft], radius: 0))
                }
                Spacer()
            }
            Spacer()
        }
        .offset(x: -16, y: -16)
    }
    
    // MARK: - wrgdg
    @ViewBuilder
    private func createTitleAndCountry() -> some View{
        // MARK: - Title
        Text(item.title)
            .font(.system(size: 12))
            .padding(.leading, -8)
            .padding(.trailing, -8)

        // MARK: - Manufacturer country
        if let text = item.manufacturerName, let img = item.manufacturerImage {
            HStack {
                Text(text)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(.customTextGray))
                Text("\(img)")
                    .font(.system(size: 15))
            }
            .padding(.top, -3)
            .padding(.leading, -8)
            .padding(.trailing, -8)
            
            Spacer()
        } else {
            Spacer()
        }
    }
    
    // MARK: - Create Favorite and List view
    
    @ViewBuilder
    private func createFavoriteAndListView() -> some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Button {
                        // some action
                    } label: {
                        Image(.listingItem)
                            .padding(.top, 10)
                    }
                    
                    Button {
                        itemState.isFav.toggle()
                        
                    } label: {
                        if itemState.isFav {
                            Image(.favoriteSelected)
                                .padding(10)
                        } else {
                            Image(.favorite)
                                .padding(10)
                        }
                        
                    }
                }
                .background(Color.white.opacity(0.5))
                .frame(width: 32)
                .clipShape(CustomRoundedRectangle(corners: [.allCorners], radius: viewModel.cornerRadiusCell))
            }
            Spacer()
        }
        .offset(x: 16, y: isList ? -2 : -16)
    }
    
    // MARK: - Create Reviews Star
    
    @ViewBuilder
    private func createReviewsView() -> some View {
        if !isList {
            // MARK: - Grid cell
            VStack {
                Spacer()
                HStack {
                    Image(.star)
                    if let review = item.rating {
                        Text("\(review, specifier: "%g")")
                            .font(.system(size: 12))
                    }
                    Spacer()
                    if let discountPercent = item.discountPercent {
                        Text("\(discountPercent)%")
                            .font(.system(size: 16))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.customBrown)
                    }
                }
            }
            .padding(.leading, -8)
            .padding(.trailing, -8)
        } else {
            // MARK: - List cell
            HStack(spacing: 4) {
                Image(.star)
                if let review = item.rating {
                    Text("\(review, specifier: "%g")")
                        .font(.system(size: 12))
                }
                Rectangle()
                    .frame(width: 1, height: 16)
                    .foregroundStyle(Color.customTextGray)
                Text("\(item.reviewsCount) отзывов")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.customTextGray)
                
                Spacer()
            }
            .padding(.leading, -10)
        }
        
    }
    
    // MARK: - Create Discount for List
    
    @ViewBuilder
    private func createDiscountList() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                if let discountPercent = item.discountPercent {
                    Text("\(discountPercent)%")
                        .font(.system(size: 16))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.customBrown)
                }
            }
        }
        .padding(.bottom, -8)
    }
    
    // MARK: - Create Segmented control fo Busket
    
    @ViewBuilder
    private func createSegmentedControl() -> some View {
        var customOpacity = itemState.isSegmentedControlHidden ? 0 : 1
        Picker("", selection: $itemState.selectedUnit) {
            Text("Шт").tag("Шт")
            Text("Кг").tag("Кг")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, -3)
        .padding(.leading, -8)
        .padding(.trailing, -8)
        .opacity(Double(customOpacity))
    }
    
    // MARK: - Create Price and Busket button
    
    @ViewBuilder
    private func createPriceAndBusketView() -> some View {
        let priceString = String(format: "%.2f", item.price)
        let parts = priceString.split(separator: ".")
        
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(parts.first ?? "")
                        .font(.system(size: 20, weight: .regular))
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .padding(.trailing, -6)
                    Text(parts.last ?? "")
                        .font(.system(size: 16, weight: .regular))
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .padding(.top, 1.5)
                    Image(.perAmountIcon)
                        .padding(.leading, -6)
                        .padding(.trailing, -9)
                }
                
                // MARK: - Old price
                if let oldPrice = item.oldPrice {
                    HStack {
                        Text(String(format: "%.2f", oldPrice))
                            .font(.system(size: 12))
                            .foregroundStyle(Color.customTextGray)
                            .strikethrough(color: Color.customTextGray)
                        
                        Spacer()
                    }
                }
                
            }
            
            Spacer()
            
            Button {
                viewModel.addToCart(item: item, quantity: 1, unit: itemState.selectedUnit)
                withAnimation {
                    itemState.isBusketHidden.toggle()
                    itemState.isSegmentedControlHidden.toggle()
                }
            } label: {
                Image(.busket)
                    .aspectRatio(contentMode: .fill)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 51)
            .padding(.top)
            .padding(.bottom)
            .background(Color.customGreen)
            .clipShape(CustomRoundedRectangle(corners: [.allCorners], radius: 40))
            
        }
        .frame(height: 36)
        .padding(.bottom, -5)
        .padding(.leading, -8)
        .padding(.trailing, -8)
        
    }
    
    @ViewBuilder
    private func chooseCountOfProduct() -> some View {
        HStack {
            Button(action: {
                if itemState.quantity > 1 {
                    itemState.quantity -= 1
                    viewModel.decrementQuantity(for: item)
                } else if itemState.quantity <= 1 {
                    withAnimation {
                        viewModel.decrementQuantity(for: item)
                        itemState.isBusketHidden.toggle()
                        itemState.isSegmentedControlHidden.toggle()
                    }
                }
            }) {
                Image(systemName: "minus")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.leading, 11)
            
            Spacer()
            
            VStack {
                Text("\(itemState.quantity, specifier: "%g") \(itemState.selectedUnit.lowercased())")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                Text("~\(String(format: "%.2f", itemState.quantity * item.price)) ₽")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(height: 36)
            
            Spacer()
            
            Button(action: {
                itemState.quantity += 1
                viewModel.addToCart(item: item, quantity: 1, unit: itemState.selectedUnit)
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.trailing, 11)
        }
        .background(Color.customGreen)
        .cornerRadius(40)
        .padding(.top, -3)
        .padding(.leading, -8)
        .padding(.trailing, -8)
        .padding(.bottom, -10)
    }
}
