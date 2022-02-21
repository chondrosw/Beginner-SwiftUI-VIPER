//
//  ContentView.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 20/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var model:DataModel

    var body: some View {
        NavigationView {
            TripListView(presenter: TripListPresenter(interactor: TripListInteractor(model: model)))
        }
    }

    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
