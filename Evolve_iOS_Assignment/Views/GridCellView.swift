//
//  GridCellView.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 29/11/24.
//

import SwiftUI

struct GridCellView: View {
    var name: String
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 0) {
            Image("SampleImage")
                .resizable()
                .renderingMode(.original)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 18))
                    .bold()
                Text("5 sessions • 5-10 mins")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 12))
            }
            .padding(.top,8)
        }
        .frame(maxWidth:170,maxHeight:198)
        .cornerRadius(8)
        
    }
}

