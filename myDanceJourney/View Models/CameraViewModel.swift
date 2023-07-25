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
    
    @MainActor final class ViewModel: ObservableObject {
        @Published private(set) var isRecording: Bool = false
        @Published private var recordedURLs: [URL] = []
        @Published private(set) var previewURL: URL?
        @Published private(set) var showPreview: Bool = false
        @Published private var output = AVCaptureMovieFileOutput()
        
        @Published private(set) var displayRightSideDropdown: Bool = false
        @Published var recordingLength: RecordLength = .oneMin
        
        @Published var numSecondsDelay: Int = 0
        
        @Published private(set) var showMirrorImage: Bool = false
        @Published private(set) var displayFrontFacingCamera: Bool = false
        @Published private(set) var useFlash: Bool = false
        @Published var speedRatio: CGFloat = 1
        
        private func startRecording() {
            let tempURL = NSTemporaryDirectory() + "\(Date()).mov"
            
        }
        
        let cameraService = CameraService()
        
        func toggleMirroredImage() {
            withAnimation { self.showMirrorImage.toggle() }
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
