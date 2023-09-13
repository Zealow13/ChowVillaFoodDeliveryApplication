//
//  ChowVilaaApp.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI
import Firebase

@main
struct ChowVilaaApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

