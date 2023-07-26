//
//  CameraProductionViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI
import SwiftUICam

extension CameraProductionView {
    
    enum RecordLength: String, CaseIterable {
        case fifteenSeconds = "15s"
        case thirtySeconds = "30s"
        case oneMin = "1min"
        case threeMin = "3min"
        case fiveMin = "5min"
        
        var name: String { self.rawValue }
        
        var durationInSeconds: Int {
            switch self {
            case .fifteenSeconds:
                return 15
            case .thirtySeconds:
                return 30
            case .oneMin:
                return 60
            case .threeMin:
                return 180
            case .fiveMin:
                return 300
            }
        }
    }
    
    enum CameraType {
        case pointFive
        case regular
        
    }
    
    @MainActor final class ViewModel: ObservableObject, CameraActions {
        // Handles all camera events behind the scenes
        let events = UserEvents()
        
        // State variables used for updating UI
        @Published private(set) var isRecording: Bool = false
        @Published var recordLength: RecordLength = .oneMin
        @Published private(set) var enableFlash: Bool = false
        @Published private(set) var showFrontFacingCamera: Bool = false
        @Published var delayInSeconds: CGFloat = 0
        @Published var delayDisplay: Int? = nil
        @Published private(set) var showDelaySlider: Bool = false
        @Published var isEditingDelay: Bool = false
        
        
        
        func toggleRecording() {
            let delay = self.isRecording ? 0 : self.delayInSeconds
            
            for i in 0...Int(delay) {
                DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(i)) { [weak self] in
                    guard let self = self else { return }
                    withAnimation { self.delayDisplay = Int(delay) - i }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let self = self else { return }
                withAnimation { self.delayDisplay = nil }
                withAnimation { self.isRecording.toggle() }
                self.toggleVideoRecording(events: self.events)
            }
        }
        
        func toggleFlash() {
            withAnimation { self.enableFlash.toggle() }
            self.changeFlashMode(events: events)
        }
        
        func invertCamera() {
            withAnimation { self.showFrontFacingCamera.toggle() }
            self.rotateCamera(events: events)
        }
        
        func toggleDelaySlider() {
            withAnimation { self.showDelaySlider.toggle() }
        }
    }
}
