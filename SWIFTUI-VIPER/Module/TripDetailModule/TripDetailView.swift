//
//  TripDetailView.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 22/02/22.
//

import SwiftUI

struct TripDetailView:View{
    @ObservedObject var presenter:TripDetailPresenter
    var body: some View{
        VStack{
            TextField("Trip Name", text: presenter.setTripName)
                .textFieldStyle(.roundedBorder)
                .padding([.horizontal])
            presenter.makeMapView()
            Text(presenter.distanceLabel)
            HStack{
                Spacer()
                EditButton()
                Button(action:presenter.addWaypoint, label: {
                    Text("Add")
                })
            }.padding([.horizontal])
            List{
                ForEach(presenter.waypoints,content:presenter.cell)
                    .onMove(perform: presenter.didMovewaypoint(fromOffsets:toOffset:))
                    .onDelete(perform: presenter.didDeleteWaypoint(_:))
            }
        }.navigationTitle("\(presenter.tripName)")
            .navigationBarTitleDisplayMode(.inline)
        navigationBarItems( trailing: Button(action: presenter.save, label: {
            Text("Save")
        }))
    }
}


struct TripDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let model = DataModel.sample
    let trip = model.trips[1]
    let mapProvider = RealMapDataProvider()
    let presenter = TripDetailPresenter(interactor:
      TripDetailInteractor(
        trip: trip,
        model: model,
        mapInfoProvider: mapProvider))
    return NavigationView {
      TripDetailView(presenter: presenter)
    }
  }
}

