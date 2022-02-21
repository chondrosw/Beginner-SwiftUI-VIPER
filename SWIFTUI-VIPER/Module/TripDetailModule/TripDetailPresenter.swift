//
//  TripDetailPresenter.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 22/02/22.
//

import Foundation
import Combine
import SwiftUI

class TripDetailPresenter:ObservableObject{
    private let interactor:TripDetailInteractor
    private let router:TripDetailRouter
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var tripName:String = "No Name"
    let setTripName:Binding<String>
    @Published var distanceLabel:String = "Calculating..."
    @Published var waypoints:[Waypoint] = []
    init(interactor:TripDetailInteractor) {
        self.interactor = interactor
        self.router = TripDetailRouter(mapProvider: interactor.mapInfoProvider)
        
        setTripName = Binding<String>(
            get: { interactor.tripName},
            set: {interactor.setTripName($0)}
        )
        
        interactor.tripNamePublisher
            .assign(to: \.tripName, on: self)
            .store(in: &cancellables)
        
        interactor.$totalDistance
            .map{
                "Total Distance: " + MeasurementFormatter().string(from: $0)
            }
            .replaceNil(with: "Calculating...")
            .assign(to: \.distanceLabel, on: self)
            .store(in: &cancellables)
        
        interactor.$waypoints
            .assign(to: \.waypoints, on: self)
            .store(in: &cancellables)
    }
    
    func save(){
        interactor.save()
    }
    
    func makeMapView() -> some View{
        TripMapView(presenter: TripMapViewPresenter(interactor: interactor))
    }
    
    func addWaypoint(){
        interactor.addWaypoint()
    }
    
    func didMovewaypoint(fromOffsets:IndexSet,toOffset:Int){
        interactor.moveWayPoint(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func didDeleteWaypoint(_ atOffsets:IndexSet){
        interactor.deleteWaypoint(atOffsets: atOffsets)
    }
    
    func cell(for waypoint:Waypoint) -> some View{
        let destionation = router.makeWaypointView(for: waypoint)
            .onDisappear(perform:interactor.updateWaypoints)
        return NavigationLink(destination: destionation, label: {
            Text(waypoint.name)
        })
    }
}
