//
//  ViewController.swift
//  DemoAnimation
//
//  Created by Roger Zhang on 25/7/18.
//  Copyright © 2018 Roger Zhang. All rights reserved.
//

import UIKit
import WebKit
import Lottie

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var controlButton: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var animationContainer: UIView!
    private var demoAnimation: LOTAnimationView?
    fileprivate let bgColor = UIColor(named: "BGColor")! //UIColor("#0060AA")
    fileprivate let webURL = URLRequest(url: URL(string: "https://www.google.com.au")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view.
        webView.backgroundColor = bgColor
        webView.scrollView.backgroundColor = bgColor
        animationContainer.backgroundColor = bgColor
        webView.navigationDelegate = self
        self.webView.isHidden = true
        
        
        // Create Boat Animation
        demoAnimation = LOTAnimationView(name: "bubbles")
        
        
        // Set view to full screen, aspectFill
        demoAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        demoAnimation!.contentMode = .scaleAspectFill
        demoAnimation!.frame = animationContainer.bounds
        // Add the Animation
        animationContainer.addSubview(demoAnimation!)
        
        
        controlButton.title = "Loading"
        controlButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Play the first portion of the animation on loop until the download finishes.
        demoAnimation?.loopAnimation = true
        demoAnimation?.play()
        
        loadWebPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        demoAnimation?.stop()
    }
    
    func loadWebPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            [weak self] in
            self?.webView.load(self!.webURL)
        })
    }

    @IBAction func controlButtonTapped(_ sender: UIBarButtonItem) {
        controlButton.title = "Loading"
        webView.isHidden = true
        animationContainer.isHidden = false
        demoAnimation?.loopAnimation = true
        demoAnimation?.play()
        loadWebPage()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.isHidden = false
        animationContainer.isHidden = true
        demoAnimation?.stop()
        controlButton.title = "Refresh"
        controlButton.isEnabled = true
    }
}

