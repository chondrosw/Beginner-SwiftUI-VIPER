//
//  WaypointView.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 21/02/22.
//

import Foundation
import SwiftUI

struct WaypointView:View{
    @EnvironmentObject var model:DataModel
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var presenter:WaypointViewPresenter
    
    init(presenter:WaypointViewPresenter) {
        self.presenter = presenter
    }
    
    func applySuggestion(){
        presenter.didTapUseThis()
        mode.wrappedValue.dismiss()
    }
    
    var body: some View{
        VStack{
            VStack{
                TextField("Type an Address", text: $presenter.query)
                    .textFieldStyle(.roundedBorder)
                HStack{
                    Text(presenter.info)
                    Spacer()
                    Button(action:applySuggestion, label: {
                        Text("Use this")
                    }).disabled(!presenter.isValid)
                }
            }.padding([.horizontal])
            MapView(center:presenter.location)
        }.navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct WaypointView_Previews:PreviewProvider{
    static var previews: some View{
        let model = DataModel.sample
        let waypoint = model.trips[0].waypoints[0]
        let provider = RealMapDataProvider()
        
        Group{
            NavigationView{
                WaypointView(presenter: WaypointViewPresenter(waypoint: waypoint, interactor: WaypointViewInteractor(waypoint: waypoint, mapInfoProvider: provider))).environmentObject(model)
            }.previewDisplayName("Detail")
            NavigationView{
                WaypointView(presenter: WaypointViewPresenter(waypoint: Waypoint(), interactor: WaypointViewInteractor(waypoint: Waypoint(), mapInfoProvider: provider))).environmentObject(model)
            }.previewDisplayName("New")
        }
    }
}
#endif
