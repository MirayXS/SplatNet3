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
    /// iOS13以上でのDeprecated対策
    public var window: UIWindow? {
        UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows.first
    }

    /// 現在表示されているViewの親View
    public var rootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first?
            .rootViewController
    }

    /// 現在表示されている最も上位のView
    public var presentedViewController: UIViewController? {
        if let current = rootViewController?.presentedViewController {
            if let presentedViewController = current.presentedViewController {
                return presentedViewController
            }
            return current
        }
        return rootViewController
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
        controller.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        controller.view.addSubview(progress)
        UIApplication.shared.presentedViewController?.present(controller, animated: true, completion: completion)
        UIApplication.shared.presentedViewController?.dismiss(animated: true)
    }

    public func authorize(sessionToken: String, contentId: ContentId) {
        let hosting: UIHostingController = UIHostingController(rootView: _SignInView(sessionToken: sessionToken))
        hosting.modalPresentationStyle = .overFullScreen
        hosting.modalTransitionStyle = .coverVertical
        hosting.overrideUserInterfaceStyle = .dark
        hosting.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
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

