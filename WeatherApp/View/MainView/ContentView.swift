//
//  ContentView.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cityViewModel = CityViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationView {
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        City(cityViewModel: cityViewModel)
                            .padding(.top, 50)
                    }
                }
                .navigationBarHidden(true)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6050806046, green: 0.8078469634, blue: 0.9820559621, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7923670909, blue: 0.6096786965, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .edgesIgnoringSafeArea(.all)
            }
            .environmentObject(cityViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ForEach(["iPhone SE (2nd generation)", "iPhone 11"], id: \.self) { deviceName in
//                ContentView()
//                    .previewDevice(PreviewDevice(rawValue: deviceName))
//                    .previewDisplayName(deviceName)
//            }
            ContentView()
//            ContentView()
//                .colorScheme(.dark)
        }
    }
}
