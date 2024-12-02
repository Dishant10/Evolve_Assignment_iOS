//
//  GridCellViewShimmer.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import SwiftUI

struct GridCellViewShimmer: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.gray)
                .frame(width:170,height: 116)
            VStack(alignment: .leading, spacing: 4) {
                Color.gray
                    .frame(width: 108, height: 12)
                    .cornerRadius(8.0)
                
                Color.gray
                    .frame(width: 56, height: 12)
                    .cornerRadius(8.0)
            }
            .padding(.top,8)
        }
        .frame(maxWidth:170,maxHeight:198)
        .cornerRadius(8)
        
    }
}
