//
//  TripListView.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 21/02/22.
//

import SwiftUI

struct TripListView: View {
    @ObservedObject var presenter:TripListPresenter
    var body: some View {
        List{
            ForEach(presenter.trips,id:\.id){item in
                TripListCell(trip: item).frame(height:240)
            }.onDelete(perform:presenter.deleteTrip)
        }.onAppear(perform: {
            print(presenter.trips)
        }).navigationBarItems( trailing: presenter.makeAddNewButton()).navigationTitle("Roadtrips").navigationBarTitleDisplayMode(.inline)
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let interactor = TripListInteractor(model: model)
        let presenter = TripListPresenter(interactor: interactor)
        return NavigationView{
            TripListView(presenter: presenter)
        }
        
    }
}
