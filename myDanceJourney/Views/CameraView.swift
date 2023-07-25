//
//  CameraView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var viewModel = ViewModel()
    @Binding var showCamera: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    init(showCamera: Binding<Bool>) {
        self._showCamera = showCamera
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(white: 1, alpha: 0.2)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            FrameView(cameraService: viewModel.cameraService) { result in
                switch result {
                case .success(let photo):
                    if let photoData = photo.fileDataRepresentation() {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Error: No Image Data Found")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .ignoresSafeArea()
            
            
            OverlayButtons
        }
    }
    
    private var RecordButton: some View {
        Button {
            viewModel.toggleRecording()
        } label: {
            ZStack {
                Circle()
                    .stroke(.white)
                    .frame(width: 55)
                
                if viewModel.isRecording {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.red)
                        .frame(width: 30, height: 30)
                } else {
                    Circle()
                        .fill(.red)
                        .frame(width: 50)
                }
            }
        }
    }
    
    private var CloseCameraButton: some View {
        Button {
            self.showCamera = false
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
    
    private var RecordLengthPicker: some View {
        Picker("", selection: $viewModel.recordingLength) {
            ForEach(RecordLength.allCases, id: \.self) { item in
                Text(item.name)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .padding(.vertical, 10)
        .opacity(viewModel.isRecording ? 0 : 1)
    }
    
    private var RightSideDropdown: some View {
        VStack {
            Button {
                viewModel.toggleFlash()
            } label: {
                Image(systemName: viewModel.useFlash ? "bolt.fill" : "bolt.slash")
                    .padding(.bottom, 25)
            }
            
            Button {
                viewModel.invertCamera()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                    .padding(.bottom, 25)
            }
            
            Button {
                viewModel.toggleMirroredImage()
            } label: {
                Image(systemName: "arrow.right.and.line.vertical.and.arrow.left")
                    .padding(.bottom, 25)
            }
            
            Image(systemName: "clock.arrow.circlepath")
                .padding(.bottom, 25)
            
            Image(systemName: "alarm")
                .padding(.bottom, 25)
        }
        .offset(y: viewModel.displayRightSideDropdown ? 0 : -500)
        .font(.system(size: 25, weight: .medium))
        .foregroundColor(.white)
    }
    
    private var DropdownToggle: some View {
        Button {
            viewModel.toggleRightSideDropdown()
        } label: {
            Image(systemName: viewModel.displayRightSideDropdown ? "chevron.down" : "chevron.up")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
        }
    }
    
    private var OverlayButtons: some View {
        VStack {
            
            if !viewModel.isRecording {
                
                HStack(alignment: .top) {
                    CloseCameraButton
                    
                    Spacer()
                    
                    DropdownToggle
                    
                    Spacer()
                    
                    RightSideDropdown
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
            
            
            Spacer()
            
            RecordLengthPicker
            
            RecordButton
            
            
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(showCamera: .constant(true))
    }
}
