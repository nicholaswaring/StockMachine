//
//  DiceApp.swift
//  Dice
//
//  Created by Waring, Nicholas S on 5/9/24.
//

import SwiftUI

@main
struct DiceApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var spinners = SpinViews()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(spinners)
        }
    }
}
