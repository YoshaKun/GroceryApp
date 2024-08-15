//
//  MainView.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI

struct MainView: View {
    // MARK: - View model reference as Observable object
    @EnvironmentObject var viewModel: ViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            Color(.white)
                .ignoresSafeArea()
            
            // MARK: - Navigation Bar
            VStack(spacing: 0){
                HStack {
                    // MARK: - List / Grid switcher
                    Button {
                        withAnimation {
                            viewModel.isList.toggle()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(Color.customLightGray)
                            
                            if viewModel.isList {
                                withAnimation {
                                    Image(.list)
                                }
                            } else {
                                withAnimation {
                                    Image(.grid)
                                }
                            }
                        }
                        .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                }
                .padding()
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray),
                        alignment: .bottom
                )
                
                
                // MARK: - List / Grid view
                createCustomList(isList: viewModel.isList)
            }
            
            // MARK: - Busket View
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(height: 130)
                        .padding(.bottom, -55)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 10)
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            HStack {
                                Image(.busket)
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                                Text("190 ₽")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.trailing, 20)
                            }
                            .frame(height: 50)
                            .background(Color.customGreen)
                            .cornerRadius(25)
                            .padding(.horizontal, 16)
                            
                            Text("Корзина")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, -10)
                }
            }
        }
    }
    
    // MARK: - create Grid / List
    
    @ViewBuilder
    private func createCustomList(isList: Bool) -> some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        let listColumns = [GridItem(.flexible())]
        
        if isList {
            ScrollView {
                LazyVGrid(columns: listColumns, spacing: 8) {
                    ForEach(viewModel.groceryArray) { item in
                        VStack {
                            GroceryCustomCell(isList: isList, item: item)
                                .environmentObject(viewModel)
                            
                            Divider()
                                .background(Color.gray)
                        }
                        
                    }
                    .background(Color.white)
                }
                .padding()
            }
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.groceryArray) { item in
                        GroceryCustomCell(isList: isList, item: item)
                            .environmentObject(viewModel)
                    }
                    .shadow(color: .gray.opacity(0.3), radius: 7)
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(ViewModel())
}
