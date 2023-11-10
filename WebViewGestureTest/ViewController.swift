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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    edgesForExtendedLayout = []
    
    setupHeaderView()
    setupWebView()
    setupLabels()
  }
  
  func setupHeaderView() {
    headerView = UIView()
    headerView.backgroundColor = .lightGray
    
    let label = UILabel()
    label.text = "Header"
    headerView.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalTo(headerView)
    }
    
    view.addSubview(headerView)
    headerView.snp.makeConstraints { make in
      headerViewTopConstraint =  make.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint
      make.left.right.equalTo(view)
      make.height.equalTo(100)
    }
  }

  func setupWebView() {
    webView = WKWebView()
    webView.scrollView.delegate = self
    
    view.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(headerView.snp.bottom)
//      make.top.equalTo(view)
    }

    webView.load(URLRequest(url: URL(string:"https://www.apple.com")!))
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
    headerViewTopConstraint.update(offset: min(-scrollView.contentOffset.y, 0))
    view.setNeedsLayout()
    
    UIView.animate(withDuration: 0) {
      self.view.layoutIfNeeded()
    }
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    zoomLabel.text = "Zoom: \(scrollView.zoomScale)"
  }
}

