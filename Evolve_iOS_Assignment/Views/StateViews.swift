//
//  StateViews.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import SwiftUI


struct EmptyStateView: View {
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            HStack {
                Spacer()
                Text("No data available")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer()
        }
    }
}


struct ErrorStateView: View {
    let message: String
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            HStack {
                Spacer()
                Text("\(message)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                Spacer()
            }
            Spacer()
        }
        .padding(.bottom,16)
    }
}
