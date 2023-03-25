//
//  UIApplication.swift
//  
//
//  Created by devonly on 2022/11/23.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication {
//    /// UIKitのコンポーネントをSwiftUIに変換して表示する
//    public func present<Content: View>(
//        isPresented: Binding<Bool>,
//        isModalInPresentation: Bool = false,
//        modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
//        modalPresentationStyle: UIModalPresentationStyle = .overFullScreen,
//        @ViewBuilder content: @escaping () -> Content
//    ) -> Void {
//        guard let window: UIWindow = lastWindow
//        else {
//            return
//        }
//
//        if isPresented.wrappedValue {
//            window.isHidden = true
//            let hosting: UIHostingController = UIHostingController(rootView: content())
//            hosting.modalPresentationStyle = .overFullScreen
//            hosting.isModalInPresentation = isModalInPresentation
//            hosting.modalPresentationStyle = modalPresentationStyle
//            hosting.modalTransitionStyle = modalTransitionStyle
//            hosting.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
//            UIApplication.shared.presentedViewController?.present(hosting, animated: true, completion: nil)
//        }
//    }

    /// UIWindow
    public var window: UIWindow? {
        UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows.first
    }

    /// UIWindow
    public var firstWindow: UIWindow? {
        UIApplication.shared.foregroundScene?.windows.first
    }

    /// UIWindow
    public var lastWindow: UIWindow? {
        UIApplication.shared.foregroundScene?.windows.last
    }

    /// UIWindowScene
    public var foregroundScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first(where: { $0.activationState == .foregroundActive })
    }

    /// 現在表示されているViewの親View
    public var rootViewController: UIViewController? {
        firstWindow?.rootViewController
    }

    /// 現在表示されている最も上位のView
    public var presentedViewController: UIViewController? {
        guard let window: UIWindow = firstWindow
        else {
            return nil
        }
        // 秘密のおまじない
        window.makeKeyAndVisible()

        guard let rootViewController = window.rootViewController
        else {
            return nil
        }

        var topViewController: UIViewController? = rootViewController
        while let newTopViewController: UIViewController = topViewController?.presentedViewController {
            topViewController = newTopViewController
        }
        return topViewController
    }

    /// ロード画面を表示して処理を実行する
    public func startAnimating(completion: @escaping () -> Void) {
        let controller: UIViewController = UIViewController(nibName: nil, bundle: nil)

        let progress: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        progress.overrideUserInterfaceStyle = .dark
        progress.hidesWhenStopped = true
        progress.startAnimating()
        progress.center = controller.view.center
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        controller.overrideUserInterfaceStyle = .dark
        controller.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        controller.view.addSubview(progress)
        UIApplication.shared.presentedViewController?.present(controller, animated: true, completion: completion)
        UIApplication.shared.presentedViewController?.dismiss(animated: true)
    }

    public func startAnimatingWithAsync(completion: @escaping @Sendable () async throws -> Void) async throws -> Void {
        let controller: UIViewController = UIViewController(nibName: nil, bundle: nil)

        let progress: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        progress.overrideUserInterfaceStyle = .dark
        progress.hidesWhenStopped = true
        progress.startAnimating()
        progress.center = controller.view.center
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        controller.overrideUserInterfaceStyle = .dark
        controller.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        controller.view.addSubview(progress)
        UIApplication.shared.presentedViewController?.present(controller, animated: true)
        do {
            try await completion()
            UIApplication.shared.presentedViewController?.dismiss(animated: true)
        } catch(let error) {
            UIApplication.shared.presentedViewController?.dismiss(animated: true)
            throw error
        }
    }

    public func authorize(sessionToken: String, contentId: ContentId) {
        let hosting: UIHostingController = UIHostingController(rootView: _SignInView(sessionToken: sessionToken))
        hosting.modalPresentationStyle = .overFullScreen
        hosting.modalTransitionStyle = .coverVertical
        hosting.overrideUserInterfaceStyle = .dark
        hosting.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.presentedViewController?.present(hosting, animated: true)
        })
    }

    /// 一番上にジャンプする
    public func popToRootView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController,
           let navigationController = findNavigationController(rootViewController)
        {
            navigationController.popToRootViewController(animated: true)
        }
    }

    private func findNavigationController(_ viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }

        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }

        for childViewController in viewController.children {
            return findNavigationController(childViewController)
        }

        return nil
    }
}

extension UIViewController {
    public func popover(_ viewControllerToPresent: UIActivityViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popover = viewControllerToPresent.popoverPresentationController {
                popover.sourceView = viewControllerToPresent.view
                popover.barButtonItem = .none
                popover.sourceRect = viewControllerToPresent.accessibilityFrame
            }
        }
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}

