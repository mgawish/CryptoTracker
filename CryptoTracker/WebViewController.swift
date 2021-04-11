//
//  WebView.swift
//  CryptoTracker
//
//  Created by Gawish on 11/04/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var urlString: String = ""
    var webView: WKWebView!
    
    class func present(urlString: String, parent: UIViewController) {
        if let vc = parent.storyboard?.instantiateViewController(identifier: "WebViewController") as? WebViewController {
            parent.navigationController?.pushViewController(vc, animated: true)
            vc.urlString = urlString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
