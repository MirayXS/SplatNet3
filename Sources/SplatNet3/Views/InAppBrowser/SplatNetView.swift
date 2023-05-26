//
//  SwiftUIView.swift
//  
//
//  Created by devonly on 2022/11/28.
//  
//

import WebKit
import SDBridgeSwift
import SwiftUI
import UIKit
import Alamofire
import LinkPresentation

struct SplatNetView: UIViewControllerRepresentable {
    let contentId: ContentId

    init(contentId: ContentId) {
        self.contentId = contentId
    }

    func makeUIViewController(context: Context) -> WebViewController {
        WebViewController(contentId: contentId)
    }

    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
    }

    final class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
        private var bridge: WebViewJavascriptBridge
        private var observer: NSKeyValueObservation?
        private let session: SP3Session = SP3Session()
        private let contentId: ContentId
        private let configuration: WKWebViewConfiguration = WKWebViewConfiguration()

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let button = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close))
            /// イカリング3の場合はナビゲーションバーを表示しない
            self.parent?.navigationController?.setNavigationBarHidden(contentId == .SP3, animated: true)
            self.parent?.navigationItem.rightBarButtonItem = button
            self.parent?.navigationItem.rightBarButtonItem?.tintColor = .white
        }

        @objc func close() {
            dismiss(animated: true)
        }

        init(contentId: ContentId) {
            /// リクエスト
            let locale: String = NSLocalizedString(LocalizedType.CoopHistory_Locale.rawValue, bundle: .module, comment: "")
            var baseURL: URL = contentId.requestURL
            baseURL.queryItems([URLQueryItem(name: "lang", value: locale)])
            var request: URLRequest = URLRequest(url: baseURL)
            self.contentId = contentId
            let webView: WKWebView = WKWebView(frame: .zero, configuration: configuration)
            let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
            indicator.hidesWhenStopped = true
            indicator.translatesAutoresizingMaskIntoConstraints = false
            self.bridge = WebViewJavascriptBridge(webView: webView)

            super.init(nibName: nil, bundle: nil)
            /// コンソールでデータを受け取ったらJavaScriptを実行する
            self.bridge.consolePipeClosure = { content in
                self.evaluateJavaScript(content)
            }

            // WebViewの見た目の変更
            webView.isOpaque = false
            webView.backgroundColor = UIColor(SPColor.SplatNet3.SPBackground)
            webView.uiDelegate = self
            webView.navigationDelegate = self
            indicator.center = view.center
            webView.addSubview(indicator)

            Task(priority: .utility, operation: {
                /// どちらの場合でもX-GameWebTokenを利用してアクセスする
                if let gameWebToken = session.account?.gameWebToken {
                    indicator.startAnimating()
                    do {
                        let account: UserInfo = try await session.refreshIfNeeded(contentId: contentId)
                        switch contentId {
                        case .SP2:
                            /// ヘッダーを更新
                            request.headers.add(name: "X-GameWebToken", value: account.gameWebToken)
                            indicator.stopAnimating()
                            webView.load(request)
                        case .SP3:
                            /// クッキーを設定
                            let cookie = HTTPCookie(properties: [
                                HTTPCookiePropertyKey.name: "_gtoken",
                                HTTPCookiePropertyKey.value: account.gameWebToken,
                                HTTPCookiePropertyKey.domain: contentId.requestURL.host!,
                                HTTPCookiePropertyKey.path: "/"])!
                            await webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
                            indicator.stopAnimating()
                            webView.load(request)
                        }
                    } catch(let error) {
                        webView.load(request)
                    }
                } else {
                    webView.load(request)
                }
            })
            self.view = webView
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        /// リクエスト前に呼ばれる
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url: URL = navigationAction.request.url
            else {
                decisionHandler(.cancel)
                return
            }

            /// Nintendo Storeへのリンクは開かない
            if url.pathComponents.contains("store") {
                decisionHandler(.cancel)
                return
            }

            decisionHandler(.allow)
        }

        /// 読み込み準備開始
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError: Error) {
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError: Error) {
        }

        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation: WKNavigation!) {
        }

        /// JavaScriptを実行する
        private func evaluateJavaScript(_ content: Any?) {
            guard let script: NSScriptMessage = NSScriptMessage(rawValue: content) else {
                return
            }

            switch script {
            case .closeWebView:
                dismiss(animated: true)
            case .reloadExtension:
                break
            case .completeLoading:
                break
            case .invokeNativeShare(let content):
                let session: Alamofire.Session = Alamofire.Session()
                Task(priority: .utility, operation: {
                    guard let data: Data = try? await session.download(content.imageUrl).serializingData().value,
                          let image: UIImage = UIImage(data: data)
                    else {
                        return
                    }
                    let hashTag: String = (["Salmonia3"] + content.hashtags).map({ "#\($0)" }).joined(separator: " ")
                    let controller: UIActivityViewController = UIActivityViewController(activityItems: [CustomShareItem(content: content), image, hashTag], applicationActivities: nil)
                    self.popover(controller, animated: true)
                })
            case .invokeNativeShareUrl(let content):
                let hashTag: String = ["Salmonia3", LocalizedType.MemoryPlayer_Title.localized].map({ "#\($0)" }).joined(separator: " ")
                let controller: UIActivityViewController = UIActivityViewController(activityItems: [CustomShareItem(content: content), content.url, hashTag], applicationActivities: nil)
                    self.popover(controller, animated: true)
            case .copyToClipboard(let content):
                UIPasteboard.general.string = content
            case .downloadImages(let content):
                Task(priority: .utility, operation: {
                    let _ = await content.asyncMap({ imageURL in
                        let session: Alamofire.Session = Alamofire.Session()
                        guard let data: Data = try? await session.download(imageURL).serializingData().value,
                              let image: UIImage = UIImage(data: data)
                        else {
                            return
                        }
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    })
                    let alert: UIAlertController = UIAlertController(
                        title: LocalizedType.Common_Download.localized,
                        message: LocalizedType.CoopHistory_SaveToPhotoLibrary.localized,
                        preferredStyle: .alert)
                    let action: UIAlertAction = UIAlertAction(title: LocalizedType.Common_Close.localized, style: .default)
                    alert.addAction(action)
                    present(alert, animated: true)
                })
            case .sourceCamera:
                let reader: UIHostingController = UIHostingController(rootView: QRReaderView().edgesIgnoringSafeArea(.all))
                reader.modalPresentationStyle = .formSheet
                UIApplication.shared.presentedViewController?.present(reader, animated: true)
            default:
                break
            }
        }

        /// ビューが切り替わったときにトークンを再生成するかどうかをチェックする
        override public func viewDidLayoutSubviews() {
        }
    }
}

struct SplatNetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(content: {
            SplatNetView(contentId: .SP3)
                .preferredColorScheme(.dark)
        })
    }
}

extension View {
    /// イカリング2, イカリング3を開く
    public func openInAppBrowser(isPresented: Binding<Bool>, contentId: ContentId) -> some View {
        self.fullScreenCover(isPresented: isPresented, content: {
            NavigationView(content: {
                SplatNetView(contentId: contentId)
                    .preferredColorScheme(.dark)
                    .toolBarBackground()
            })
        })
    }

    /// ナビゲーションバーの色を変更する(iOS16以上のみ効く)
    func toolBarBackground() -> some View {
        if #available(iOS 16.0, *) {
            return self
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.red, for: .navigationBar)
        } else {
            return self
        }
    }
}
