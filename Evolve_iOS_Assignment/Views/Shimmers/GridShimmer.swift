//
//  GridShimmer.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import SwiftUI

struct GridShimmer: View {
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0...7, id: \.self) { _ in
                    GridCellViewShimmer()
                }
                
            }
            .padding(.top)
        }
    }
}
