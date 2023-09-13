//
//  MapView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 06/09/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(coordinateRegion: .constant(.init(center: .init(latitude: 5.1098650, longitude: -1.3045540), latitudinalMeters: 10000, longitudinalMeters: 10000)))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity)
            .frame(height: 200)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
