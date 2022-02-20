//
//  TripListIneractor.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 20/02/22.
//

import Foundation

class TripListInteractor{
    let model:DataModel
    
    init(model:DataModel) {
        self.model = model
    }
    
    func addNewTrip(){
        model.pushNewTrip()
    }
    
    func deleteTrip(_ index:IndexSet){
        model.trips.remove(atOffsets: index)
    }
}
