//
//  CityRow.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 14.10.2021.
//

import SwiftUI

struct CityRow: View {

    var cities: Cities

    var body: some View {
        HStack {
            Text(cities.country)
                .foregroundColor(Color.gray)
            Spacer()
            Text(cities.name)
                .foregroundColor(Color.black)
        }
    }
}

//struct CityRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CityRow()
//    }
//}
