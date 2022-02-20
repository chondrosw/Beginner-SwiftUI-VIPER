//
//  WayPoint.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 20/02/22.
//

import Foundation
import CoreLocation
import MapKit
import Combine

final class Waypoint {
    @Published var name:String
    @Published var location:CLLocationCoordinate2D
    var id:UUID
    
    init(){
        id = UUID()
        name = "Time Square"
        location = CLLocationCoordinate2D.timesSquare
    }
    required init (from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: Codingkeys.self)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(CLLocationCoordinate2D.self, forKey: .location)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    func copy()-> Waypoint{
        let new = Waypoint()
        new.name = name
        new.location = location
        return new
    }
}

extension Waypoint:Equatable{
    static func == (lhs:Waypoint,rhs:Waypoint)-> Bool{
        return lhs.id == rhs.id
    }
}

extension Waypoint:CustomStringConvertible{
    var description: String{name}
}
extension Waypoint:Codable{
    enum Codingkeys:CodingKey{
        case name
        case location
        case id
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Codingkeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(id, forKey: .id)
    }
}

extension Waypoint:Identifiable{}

extension Waypoint{
    var mapItem:MKMapItem{
        return MKMapItem(placemark: MKPlacemark(coordinate: location))
    }
}

extension CLLocationCoordinate2D:Codable{
    public init(from decoder: Decoder) throws {
        let representation = try decoder.singleValueContainer().decode([String:CLLocationDegrees].self)
        self.init(latitude: representation["latitude"] ?? 0, longitude: representation["longitude"] ?? 0)
    }
    
    public func encode(to encoder: Encoder) throws {
        let representation = ["latitude":self.latitude,"longitude":self.longitude]
        try representation.encode(to: encoder)
    }
}
