//
//  CitiesReceive.swift
//  
//
//  Created by Алексей Полетаев on 07.01.2022.
//

import Foundation

public class CitiesReceive<T: Codable> {
    
    public var network: NetworkReceive<T>

    public init() {
        self.network = NetworkReceive<T>()
    }
}
