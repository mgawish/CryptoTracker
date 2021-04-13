//
//  WebView.swift
//  CryptoTracker
//
//  Created by Gawish on 11/04/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var urlString: String = ""
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    class func present(urlString: String, parent: UIViewController) {
        let vc = WebViewController()
        vc.urlString = urlString
        parent.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.allowsBackForwardNavigationGestures = true

        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        updateUI()
    }
    
    func updateUI() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let safari = UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: self, action: #selector(openSafari))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        progressView = UIProgressView(progressViewStyle: .bar)
        let progressBarItem = UIBarButtonItem(customView: progressView)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        toolbarItems = [progressBarItem, spacer, safari, refresh]
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc func openSafari() {
        guard let url = webView.url else {
            return
        }
        UIApplication.shared.open(url)
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
