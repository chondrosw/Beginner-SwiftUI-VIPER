//
//  ImageDataSource.swift
//  SWIFTUI-VIPER
//
//  Created by Chondro Satrio Wibowo on 20/02/22.
//

import UIKit
import Combine

protocol ImageDataProvider{
    func getEndImages(for trip:Trip) -> AnyPublisher<[UIImage],Never>
}

private struct PixabayResponse:Codable{
    struct Image:Codable{
        let largeImageURL:String
        let user:String
    }
    let hits:[Image]
}

class PixbayImageDataProvider:ImageDataProvider{
    let apikey = "25789217-880a8d8eda9741bbdae90f70e"
    
    private func searchURL(query:String)->URL{
        var components = URLComponents(string: "https://pixabay.com/api")
        components?.queryItems = [
        URLQueryItem(name: "key", value: apikey),
        URLQueryItem(name: "q", value: query),
        URLQueryItem(name: "image_type", value: "photo")
        ]
        return (components?.url!)!
    }
    
    private func imageForQuery(query:String)-> AnyPublisher<UIImage,Never>{
        URLSession.shared.dataTaskPublisher(for: searchURL(query: query))
            .map{$0.data}
            .decode(type: PixabayResponse.self, decoder: JSONDecoder())
            .tryMap{response -> URL in
                guard let urlString = response.hits.first?.largeImageURL,
                      let url = URL(string: urlString) else{
                          throw CustomErrors.noData
                      }
                return url
            }.catch{ _ in Empty<URL,URLError>()}
            .flatMap{URLSession.shared.dataTaskPublisher(for: $0)}
            .map{$0.data}
            .tryMap{ imageData in
                guard let image = UIImage(data: imageData) else{
                    throw CustomErrors.noData
                }
                return image
            }.catch{_ in Empty<UIImage,Never>()}
            .eraseToAnyPublisher()
    }
    func getEndImages(for trip: Trip) -> AnyPublisher<[UIImage], Never> {
        <#code#>
    }
}
