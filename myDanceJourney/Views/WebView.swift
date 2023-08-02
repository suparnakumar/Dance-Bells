//
//  WebView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/1/23.
//

import SwiftUI
import WebKit
import UIKit
import KeychainAccess

struct WebView: UIViewRepresentable {
    @EnvironmentObject var authentication: AuthManager

    var url: URL
    var navigationController: UINavigationController?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.navigationDelegate = context.coordinator
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, auth: authentication)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        let auth: AuthManager
        
        init (_ parent: WebView, auth: AuthManager) {
            self.parent = parent
            self.auth = auth
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            // If redirected...
            if let navURL = navigationAction.request.url {

                if navURL.host == "spotify-callback" {
                    var code = URLComponents(string: navURL.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
                    if let code = code {
                        self.auth.exchangeCode(code: code)
                        self.auth.loginVisible = false
                    }
                    
//                    code = URLComponents(string: navURL.absoluteString)?.queryItems?.first(where: { $0.name == "error" })?.value
//                    if code != nil {
//                        self.auth.loginVisible = false
//                    }
                }
            }
            decisionHandler(.allow)
        }
    }
}
