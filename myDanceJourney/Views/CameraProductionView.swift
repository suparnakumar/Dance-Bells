//
//  CameraProductionView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/25/23.
//

import SwiftUI
import SwiftUICam

struct CameraProductionView: View {
    @Binding var showCamera: Bool
    @StateObject var viewModel = ViewModel()
    
    init(showCamera: Binding<Bool>) {
        self._showCamera = showCamera
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(white: 1, alpha: 0.3)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
        
            CameraView(
                events: viewModel.events,
                applicationName: "Dance Bells",
                preferredStartingCameraType: .builtInTripleCamera,
                preferredStartingCameraPosition: .back,
                focusImage: nil,
                pinchToZoom: true,
                tapToFocus: true,
                doubleTapCameraSwitch: true
            )
            .ignoresSafeArea()
            .onTapGesture {
                if viewModel.showDelaySlider {
                    viewModel.toggleDelaySlider()
                }
            }
            
            OverlayButtons
            
            if let delay = viewModel.delayDisplay {
                Text("\(delay)")
                    .font(.system(size: 100, weight: .semibold))
                    .foregroundColor(Color(white: 0.8))
            }
            
            
        }
    }
    
    private var OverlayButtons: some View {
        VStack {
            HStack(alignment: .top) {
                
                // Close camera button
                CameraButton(withName: "xmark") {
                    withAnimation { self.showCamera = false }
                }
                
                Spacer()
                
                if !viewModel.isRecording {
                    
                    VStack(spacing: 20) {
                        // Toggle flash button
                        CameraButton(withName: viewModel.enableFlash ? "bolt.fill" : "bolt.slash") {
                            viewModel.toggleFlash()
                        }
                        
                        // Invert camera button
                        CameraButton(withName: "arrow.triangle.2.circlepath.camera") {
                            viewModel.invertCamera()
                        }
                        
                        CameraButton(withName: viewModel.showDelaySlider ? "deskclock.fill" : "deskclock") {
                            viewModel.toggleDelaySlider()
                        }
                    }
                }
                
            }
            .padding()
            
            Spacer()
            
            if !viewModel.isRecording {
                
                DelaySlider
                    .opacity(viewModel.showDelaySlider ? 1 : 0)
                
                RecordLengthPicker
            }
            
            RecordButton
        }
    }
    
    private func CameraButton(withName buttonName: String, buttonAction: @escaping () -> ()) -> some View {
        Button {
            buttonAction()
        } label: {
            Image(systemName: buttonName)
                .modifier(CameraButtonStyle())
        }
    }
    
    private var DelaySlider: some View {
        VStack(spacing: 0) {
            Text("Set Timer")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.vertical, 5)
            
            Slider(
                value: $viewModel.delayInSeconds,
                in: 0...10,
                step: 1
            ) {
                
            } minimumValueLabel: {
                Text("0s")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal)
            } maximumValueLabel: {
                Text("10s")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal)
            } onEditingChanged: { editing in
                withAnimation { viewModel.isEditingDelay = editing }
            }
            .tint(Color.purple.opacity(0.5))
            
            Text("\(Int(viewModel.delayInSeconds))s")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white.opacity(0.7))
                .opacity(viewModel.isEditingDelay ? 1 : 0)
        }
        .frame(width: 300)
        .padding()
        .background(Capsule().fill(.gray.opacity(0.15)))
    }
    
    private var RecordButton: some View {
        Button {
            viewModel.toggleRecording()
        } label: {
            ZStack {
                Circle()
                    .stroke(.white)
                    .frame(width: 80)
                    
                if viewModel.isRecording {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.red)
                        .frame(width: 40, height: 40)
                } else {
                    Circle()
                        .fill(.red)
                        .frame(width: 70)
                }
            }
        }
    }
    
    private var RecordLengthPicker: some View {
        Picker("", selection: $viewModel.recordLength) {
            ForEach(RecordLength.allCases, id: \.self) { item in
                Text(item.name)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    
    
    
    
}

struct CameraProductionView_Previews: PreviewProvider {
    static var previews: some View {
        CameraProductionView(showCamera: .constant(true))
    }
}
