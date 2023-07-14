//
//  SetupProfileView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import SwiftUI

struct SetupProfileView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            Picker("", selection: $viewModel.danceGoal) {
                ForEach(DanceGoal.allCases, id: \.self) { item in
                    if item != .uninitialized || viewModel.danceGoal == .uninitialized {
                        Text(item.getDescription())
                    }
                }
            }
            .pickerStyle(.menu)
            
            Picker("", selection: $viewModel.danceLevel) {
                ForEach(DanceLevel.allCases, id: \.self) { item in
                    if item != .uninitialized || viewModel.danceLevel == .uninitialized {
                        Text(item.getDescription())
                    }
                }
            }
            .pickerStyle(.menu)
            
            
        }
    }
}

struct SetupProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetupProfileView()
    }
}
