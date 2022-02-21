//
//  TripMapViewPresenter.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 22/02/22.
//

import Foundation
import Combine
import MapKit

class TripMapViewPresenter:ObservableObject{
    @Published var pins:[MKAnnotation] = []
    @Published var routes:[MKRoute] = []
    
    let interactor:TripDetailInteractor
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor:TripDetailInteractor) {
        self.interactor = interactor
        
        interactor.$waypoints
            .map{
                $0.map {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = $0.location
                    return annotation
                }
            }
            .assign(to: \.pins, on: self)
            .store(in: &cancellables)
        
        interactor.$directions
            .assign(to: \.routes, on: self)
            .store(in: &cancellables)
    }
}
