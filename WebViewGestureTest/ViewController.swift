//
//  ViewController.swift
//  WebViewGestureTest
//
//  Created by Arvindh Sukumar on 10/11/23.
//

import SnapKit
import WebKit
import UIKit

class ViewController: UIViewController {
  var webView: WKWebView!
  var offsetLabel: UILabel!
  var zoomLabel: UILabel!
  var headerView: UIView!
  var headerViewTopConstraint: Constraint!
  
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView(frame: .zero)
    scrollView.isScrollEnabled = false
    scrollView.contentInsetAdjustmentBehavior = .never
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    edgesForExtendedLayout = []
    
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(view)
    }
    
    setupHeaderView()
    setupWebView()
    setupLabels()
  }
  
  func setupHeaderView() {
    headerView = UIView()
    headerView.backgroundColor = .red
    
    let label = UILabel()
    label.text = "Header"
    headerView.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalTo(headerView)
    }
    
    scrollView.addSubview(headerView)
    headerView.snp.makeConstraints { make in
      headerViewTopConstraint =  make.top.equalTo(scrollView.snp.top).constraint
      make.left.right.equalTo(view)
      make.width.equalTo(scrollView)
      make.height.equalTo(100)
    }
  }

  func setupWebView() {
    webView = WKWebView()
    webView.scrollView.delegate = self
    
    scrollView.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.left.right.equalTo(view)
      make.top.equalTo(headerView.snp.bottom)
      make.height.equalTo(view)
    }

    webView.load(URLRequest(url: URL(string:"https://www.google.com")!))
  }
  
  func setupLabels() {
    offsetLabel = UILabel()
    offsetLabel.backgroundColor = .red
    offsetLabel.setContentHuggingPriority(.required, for: .vertical)
    
    view.addSubview(offsetLabel)
    offsetLabel.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.center.equalTo(view)
    }
    
    zoomLabel = UILabel()
    zoomLabel.backgroundColor = .red
    zoomLabel.setContentHuggingPriority(.required, for: .vertical)
    
    view.addSubview(zoomLabel)
    zoomLabel.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.centerX.equalTo(offsetLabel)
      make.top.equalTo(offsetLabel.snp.bottom).offset(20)
    }
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    offsetLabel.text = "Offset: \(scrollView.contentOffset.y)"
    self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: false)
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    zoomLabel.text = "Zoom: \(scrollView.zoomScale)"
  }
}

