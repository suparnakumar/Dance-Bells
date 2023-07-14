//
//  CameraViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension CameraView {
    
    enum RecordLength: String, CaseIterable {
        case fifteenSeconds = "15s"
        case thirtySeconds = "30s"
        case oneMin = "1min"
        case threeMin = "3min"
        case fiveMin = "5min"
        
        func getName() -> String {
            return self.rawValue
        }
        
        func getDurationInSeconds() -> Int {
            let getDuration: [RecordLength: Int] = [
                .fifteenSeconds: 15,
                .thirtySeconds: 30,
                .oneMin: 60,
                .threeMin: 180,
                .fiveMin: 300
            ]
            
            return getDuration[self] ?? 60
        }
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var isRecording: Bool = false
        @Published private(set) var displayRightSideDropdown: Bool = false
        @Published var numSecondsDelay: Int = 0
        @Published var recordingLength: RecordLength = .oneMin
        @Published private(set) var didInvertCameraLeftRight: Bool = false
        @Published private(set) var displayFrontFacingCamera: Bool = false
        @Published private(set) var useFlash: Bool = false
        @Published var speedRatio: CGFloat = 1
        
        func invertCameraLeftRight() {
            withAnimation { self.didInvertCameraLeftRight.toggle() }
        }
        
        func invertCamera() {
            withAnimation { self.displayFrontFacingCamera.toggle() }
        }
        
        func toggleFlash() {
            withAnimation { self.useFlash.toggle() }
        }
        
        func toggleRecording() {
            withAnimation { self.isRecording.toggle() }
        }
        
        func toggleRightSideDropdown() {
            withAnimation { self.displayRightSideDropdown.toggle() }
        }
    }
}
