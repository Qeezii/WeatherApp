//
//  CitiesReceive.swift
//  
//
//  Created by Алексей Полетаев on 07.01.2022.
//

import Foundation
import CoreServices

public class CitiesReceive {
    
    private var network: NetworkReceive

    init(network: NetworkReceive) {
        self.network = network
    }
    
    func getCitiesRecive(for url: URL, complition: @escaping ([CitiesArray]) -> () ) {
        network.fetch(CitiesResponse.self, for: url, completion: { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    complition(response.cities)
                }
            case .failure(let err):
                print(err)
            }
        })
    }
}
