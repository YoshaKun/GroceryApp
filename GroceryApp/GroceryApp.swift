//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Yosha Kun on 14.08.2024.
//

import SwiftUI

@main
struct GroceryApp: App {
    
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
