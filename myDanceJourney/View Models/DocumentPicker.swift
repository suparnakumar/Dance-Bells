//
//  DocumentPicker.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/13/23.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers.UTType

struct DocumentPicker: UIViewControllerRepresentable {
    
    @Binding var songData: Data?
    @Binding var showNewSongSheet: Bool
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.mp3], asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var parent: DocumentPicker
        
        init(parent: DocumentPicker){
            self.parent = parent
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { print("Failed to access url for song"); return }
            
            do {
                parent.songData = try Data(contentsOf: url.absoluteURL)
            } catch {
                print("=====\nFailed to save song data\n\n\(error.localizedDescription)\n=====")
            }
            parent.showNewSongSheet.toggle()
            print(urls[0].absoluteString)
        }
    }
}





/*
struct DocumentPicker: UIViewControllerRepresentable {
    @EnvironmentObject var profile: ProfileManager
    @Binding var songData: Data?
    @Binding var showNewSongSheet: Bool
    
    func makeCoordinator() -> Coordinator {
        return DocumentPicker.Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.mp3], asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {

    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        private var parent: DocumentPicker
        
        init(_ parentDocumentPicker: DocumentPicker) {
            self.parent = parentDocumentPicker
        }
        
        private func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) async {
            print("HERE")
            guard let mp3Url = urls.first else { print("FAIL"); return }
            do {
                let songData = try Data(contentsOf: mp3Url)
                print("SAVING SONG DATA IN FIREBASE")
                await parent.profile.saveSong(songData: songData, name: "STANDARD_NAME")
            } catch {
                print("=====\nFailed to convert contents of mp3 to songData\n\n\(error.localizedDescription)\n=====")
            }
        }
    }
}
*/
