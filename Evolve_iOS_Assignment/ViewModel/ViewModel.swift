//
//  ViewModel.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var networkManager = NetworkManager()
    
    @Published var problems: [Problem] = [Problem(title: "All"), Problem(title: "🌻 Self-love"), Problem(title: "🌈 LGBTQIA+"), Problem(title: "🧠 Neurodiversity"), Problem(title: "❤️ Relationships"), Problem(title: "💼 Work"), Problem(title: "🌸 Sexual health"), Problem(title: "💵 Finance") ]
        
    
    
    func toggleSelection(for problem: Problem) {
        if problem.title == "All" {
            problems = problems.map { Problem(title: $0.title, isSelected: false) }
            problems[0].isSelected.toggle()
            networkManager.currentPage = 1
            networkManager.state = .loading
            networkManager.items.removeAll()
            networkManager.fetchDataInPages()
        }
        
        else {
            if let index = problems.firstIndex(where: { $0.id == problem.id }) { problems[index].isSelected.toggle()
                problems[0].isSelected = false
//                if let index = problemsList.firstIndex(where: { $0.id == problem.id}){
//                    problemsList.remove(at: index)
//                } else {
//                    problemsList.append(problems[index])
//                }
            }
        }
        
    }
    
    
}
