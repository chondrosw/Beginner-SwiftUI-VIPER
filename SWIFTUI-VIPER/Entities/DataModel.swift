//
//  DataModel.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 20/02/22.
//

import Foundation
import Combine

final class DataModel{
    private let persistance = Persistence()
    @Published var trips:[Trip] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func load(){
        persistance.load().assign(to:\.trips,on:self).store(in: &cancellables)
    }
    
    func save(){
        persistance.save(trips: trips)
    }
    
    func loadDefault(synchronous:Bool = false){
        persistance.loadDefault(synchronous: synchronous).assign(to: \.trips,on:self).store(in: &cancellables)
    }
    
    func pushNewTrip(){
        let new = Trip()
        new.name = "New Trip"
        trips.insert(new, at: 0)
    }
    
    func removeTrip(trip:Trip){
        trips.removeAll{ $0.id == trip.id }
    }
}

extension DataModel:ObservableObject{}

#if DEBUG
extension DataModel{
    static var sample:DataModel{
        let model = DataModel()
        model.loadDefault(synchronous: true)
        return model
    }
}
#endif
