//
//  SignInView.swift
//  SplatNet3
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @EnvironmentObject var session: SP3Session
    @Environment(\.dismiss) var dismiss
    let code: String
    let verifier: String
    let contentId: ContentId

    func makeBody(request: SPProgress) -> some View {
        switch request.progress {
        case .PROGRESS:
            return ProgressView()
                .frame(width: 24, height: 24, alignment: .center)
                .asAnyView()
        case .SUCCESS:
            return Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 24, height: 24, alignment: .center)
                .asAnyView()
        case .FAILURE:
            return Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 24, height: 24, alignment: .center)
                .asAnyView()
        }
    }

    var body: some View {
        GroupBox(content: {
            VStack(content: {
                ForEach(session.requests, content: { request in
                    HStack(content: {
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 60, height: 24, alignment: .center)
                            .foregroundColor(request.color)
                            .overlay(content: {
                                Text(request.type.rawValue)
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.body)
                            })
                        Text(request.path.rawValue)
                            .font(.body)
                            .frame(width: 220, height: nil, alignment: .leading)
                            .lineLimit(1)
                            .foregroundColor(.white)
                        makeBody(request: request)
                    })
                })
            })
            .frame(width: 320)
        })
        .animation(.default, value: session.requests.count)
        .onDisappear(perform: {
            session.requests.removeAll()
        })
        .onAppear(perform: {
            Task(priority: .utility, operation: {
                do {
                    try await session.getCookie(code: code, verifier: verifier, contentId: contentId)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        UIApplication.shared.rootViewController?.dismiss(animated: true)
                    })
                } catch(let error) {
                    SwiftyLogger.error(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        UIApplication.shared.rootViewController?.dismiss(animated: true)
                    })
                }
            })
        })
    }
}

struct _SignInView: View {
    @StateObject var session: SP3Session = SP3Session()
    @Environment(\.dismiss) var dismiss
    let sessionToken: String
    let contentId: ContentId

    init(sessionToken: String, contentId: ContentId = .SP3) {
        self.sessionToken = sessionToken
        self.contentId = contentId
    }

    func makeBody(request: SPProgress) -> some View {
        switch request.progress {
        case .PROGRESS:
            return ProgressView()
                .frame(width: 24, height: 24, alignment: .center)
                .asAnyView()
        case .SUCCESS:
            return Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 24, height: 24, alignment: .center)
                .asAnyView()
        case .FAILURE:
            return Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 24, height: 24, alignment: .center)
                .asAnyView()
        }
    }

    var body: some View {
        GroupBox(content: {
            VStack(content: {
                ForEach(session.requests, content: { request in
                    HStack(content: {
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 60, height: 24, alignment: .center)
                            .foregroundColor(request.color)
                            .overlay(content: {
                                Text(request.type.rawValue)
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.body)
                            })
                        Text(request.path.rawValue)
                            .font(.body)
                            .frame(width: 220, height: nil, alignment: .leading)
                            .lineLimit(1)
                            .foregroundColor(.white)
                        makeBody(request: request)
                    })
                })
            })
            .frame(width: 320)
        })
        .animation(.default, value: session.requests.count)
        .onAppear(perform: {
            Task(priority: .utility, operation: {
                do {
                    try await session.refresh(sessionToken: sessionToken, contentId: contentId)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        UIApplication.shared.rootViewController?.dismiss(animated: true)
                    })
                } catch(let error) {
                    SwiftyLogger.error(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        UIApplication.shared.rootViewController?.dismiss(animated: true)
                    })
                }
            })
        })
    }
}


//struct SignInView_Previews: PreviewProvider {
//    static let session: SPSession = SPSession()
//    static var previews: some View {
//        SignInView(code: "", verifier: "", contentId: .SP3)
//    }
//}

