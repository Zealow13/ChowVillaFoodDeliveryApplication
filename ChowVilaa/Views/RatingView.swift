//
//  RatingView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 06/09/2023.
//

import SwiftUI

import SwiftUI

struct RatingView: View {
    var rating: Int
    var body: some View {
        VStack(spacing: 4){
            Text("\(rating)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading, 5)
            
            HStack{
                ForEach(1...5, id: \.self){ index in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(index <= rating ? Color.yellow : Color.gray.opacity(0.5))
                }
            }
        }
    }
}
