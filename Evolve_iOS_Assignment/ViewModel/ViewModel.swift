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
    
    func filterListOnProblems(problemsList: [String]) {
        if !problemsList.isEmpty {
            var filteredItems = [Item]()
            print("Problems List: \(problemsList)")
            print("Items: \(networkManager.tempItemsList)")
            filteredItems = networkManager.tempItemsList.filter { item in
                item.problems.contains { problem in
                    problemsList.contains(problem)
                }
            }
            print("Filtered Items: \(filteredItems)")
            if !filteredItems.isEmpty {
                networkManager.items = filteredItems
            }
        }
    }
    
    
    
    func toggleSelection(for problem: Problem) {
        if problem.title == "All" {
            problems = problems.map { Problem(title: $0.title, isSelected: false) }
        }
       // else {
            if let index = problems.firstIndex(where: { $0.id == problem.id }) { problems[index].isSelected.toggle() }
        //}
    }
    
    
}
