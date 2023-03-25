//
//  FullScreenModifier.swift
//
//
//  Created by devonly on 2022/11/23.
//

import SwiftUI
import Introspect

public extension View {
    /// モーダルをUIKit風に表示する
    func fullScreen<Content: View>(
        isPresented: Binding<Bool>,
        presentationStyle: UIModalPresentationStyle = .overFullScreen,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        backgroundColor: UIColor = .systemBackground,
        isModalInPresentation: Bool = true,
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.fullScreenCover(isPresented: isPresented, onDismiss: nil, content: {
                content()
                    .introspectViewController(customize: { controller in
                        controller.presentationController?.presentedView?.backgroundColor = backgroundColor
                    })
                    .onTapGesture(count: 1, perform: {
                        /// あんまりよろしくないけど一応これで閉じれる
                        UIApplication.shared.presentedViewController?.dismiss(animated: true)
                    })
            })
            .introspectViewController(customize: { controller in
//                print(controller)
            })
        }

    /// モーダルをUIKit風に表示する
    func sheet<Content: View>(
        isPresented: Binding<Bool>,
        presentationStyle: UIModalPresentationStyle = .overFullScreen,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        backgroundColor: UIColor = .systemBackground,
        isModalInPresentation: Bool = true,
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.sheet(isPresented: isPresented, onDismiss: nil, content: {
                content()
                    .introspectViewController(customize: { controller in
                        controller.view.backgroundColor = backgroundColor
                    })
            })
            .introspectViewController(customize: { controller in
//                print(controller)
            })
        }
}
