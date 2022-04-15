import UIKit
import WebKit

public class WebViewController: UIViewController {

  public let webView: WKWebView = {
    let config = WKWebViewConfiguration()
    config.suppressesIncrementalRendering = true
    config.allowsInlineMediaPlayback = true
    let webView = WKWebView(frame: .zero, configuration: config)
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

  public override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    addWebView()
  }

  public override func viewDidLoad() {
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
