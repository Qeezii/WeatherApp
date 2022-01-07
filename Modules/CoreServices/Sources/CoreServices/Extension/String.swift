//
//  String.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 28.12.2021.
//

import Foundation

extension String {
    public var encodeUrl : String
        {
            return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        }
        var decodeUrl : String
        {
            return self.removingPercentEncoding!
        }
}
