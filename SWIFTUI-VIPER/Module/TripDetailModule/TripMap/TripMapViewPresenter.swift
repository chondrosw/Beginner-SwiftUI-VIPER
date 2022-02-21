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
    
    private var cancellables = Set<AnyCancellable>()
    
}
