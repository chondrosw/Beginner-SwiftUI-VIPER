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

    var body: some Scene {
        WindowGroup {
            ContentView()
                
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
