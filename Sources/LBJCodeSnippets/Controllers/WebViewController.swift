import UIKit
import WebKit

open class WebViewController: UIViewController {

  public lazy var webView: WKWebView = {
    let config = WKWebViewConfiguration()
    config.suppressesIncrementalRendering = true
    config.allowsInlineMediaPlayback = true
    let webView = WKWebView(frame: .zero, configuration: config)
    webView.navigationDelegate = self
    return webView
  }()
  private var observation: NSKeyValueObservation?

  public lazy var loadingIndicator: UIActivityIndicatorView = {
    let indicator: UIActivityIndicatorView
    if #available(iOS 13.0, *) {
      indicator = UIActivityIndicatorView(style: .medium)
    } else {
      indicator = UIActivityIndicatorView(style: .gray)
    }
    return indicator
  }()

  // MARK: - View Lifecycles

    open override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    addWebView()
  }

    open override func viewDidLoad() {
    super.viewDidLoad()
    loadingIndicator.startAnimating()
    observation = webView.observe(\WKWebView.estimatedProgress, options: .new) { [weak self] _, change in
      if let value = change.newValue, value > 0.9 {
        self?.loadingIndicator.stopAnimating()
      }
    }
  }

  deinit {
    observation = nil
  }
}

extension WebViewController: WKNavigationDelegate {
  public func webView(
    _ webView: WKWebView,
    decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
  ) {
    guard
      let url = navigationAction.request.url,
      let scheme = url.scheme
    else {
      decisionHandler(.cancel)
      return
    }

    switch scheme.lowercased() {
    case "mailto":
      UIApplication.shared.open(url)
      decisionHandler(.cancel)
    default:
      decisionHandler(.allow)
    }
  }
}

// MARK: - Setup Subviews
extension WebViewController {
  private func addWebView() {
    view.addSubview(webView)
    view.addSubview(loadingIndicator)
    webView.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
