//
//  CityName.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

struct CityNameView: View {
    
    @ObservedObject var cityViewModel = CityViewModel()
    @State private var showingCitiesView = false
    @State private var showingSettingsView = false
    var city: String
    var date: String

    var body: some View {
        
        HStack {
            NavigationLink(destination: CitiesView()) {
                
                Image(systemName: "list.dash")
                    .foregroundColor(.white)
                    .padding(.leading, 15)
            }
            .navigationTitle("")

            Spacer()

            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                
                Text(city)
                    .font(.title3)
                    .bold()
                
                Text(date)
                
            }).foregroundColor(.white)
                .font(.system(size: 12))

            Spacer()

            NavigationLink(destination: SettingsView()) {
                
                Image(systemName: "gear")
                    .foregroundColor(.white)
                    .padding(.trailing, 15)
            }
        }
    }
}

//struct CityNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        CityNameView(city: "Moscow", date: "12/12/1970")
//            .environmentObject(mainViewModel)
//    }
//}

