//
//  GridCellView.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 29/11/24.
//

import SwiftUI

struct GridCellView: View {
    var name: String
    var mins: String
    var promoText: String
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 0) {
            Image("SampleImage")
                .resizable()
                .renderingMode(.original)
                .cornerRadius(8)
                .frame(width:170,height:116)
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 18))
                    .bold()
                Text("\(promoText) • \(mins)")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 12))
            }
            .padding(.top,8)
        }
        .cornerRadius(8)
        
    }
}

