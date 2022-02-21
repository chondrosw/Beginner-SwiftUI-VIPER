//
//  TripDetailPresenter.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 22/02/22.
//

import Foundation
import Combine

class TripDetailPresenter:ObservableObject{
    private let interactor:TripDetailInteractor
    private let router:TripDetailRouter
    
    init(interactor:TripDetailInteractor) {
        self.interactor = interactor
        self.router = TripDetailRouter(mapProvider: interactor.mapInfoProvider)
        
    }
}
