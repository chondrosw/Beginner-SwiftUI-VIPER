//
//  SWIFTUI_VIPERApp.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 20/02/22.
//

import SwiftUI

@main
struct SWIFTUI_VIPERApp: App {
    let persistenceController = PersistenceController.shared
    let model = DataModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
