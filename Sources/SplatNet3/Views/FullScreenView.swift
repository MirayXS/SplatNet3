//
//  FullScreenView.swift
//  
//
//  Created by devonly on 2022/11/26.
//

import SwiftUI

struct CoopResultDownloadView: View {
    @EnvironmentObject var session: SP3Session
    @Environment(\.dismiss) var dismiss
    @State private var value: Float = .zero
    @State private var total: Float = 1
    @State private var task: Task<(), Error>?

    func download() {
        self.task = Task {
            do {
                try await session.getCoopStageScheduleQuery()
                let results: [CoopResult] = try await session.getAllCoopHistoryDetailQuery(completion: { value, total in
                    withAnimation(.default) {
                        self.value = value
                        self.total = total
                    }
                })
                if results.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        dismiss()
                    })
                }
    
                if session.useSalmonStats {
                    try await session.uploadAllCoopResultDetailQuery(results: results, completion: { value, total in
                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    dismiss()
                })
            } catch(let error) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    dismiss()
                })
            }
        }
    }

    func cancel() {
        self.task?.cancel()
    }

    @ViewBuilder
    func makeBody(request: SPProgress) -> some View {
        switch request.progress {
        case .PROGRESS:
            ProgressView()
                .frame(width: 24, height: 24, alignment: .center)
                .opacity(1.0)
        case .SUCCESS:
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 24, height: 24, alignment: .center)
        case .FAILURE:
            Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 24, height: 24, alignment: .center)
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
                        makeBody(request: request)
                    })
                })
                ProgressView("", value: value, total: total)
            })
            .frame(width: 320)
        })
        .animation(.default, value: session.requests.count)
        .onDisappear(perform: {
            self.session.requests.removeAll()
            self.task?.cancel()
        })
        .onAppear(perform: {
            download()
        })
    }
}

public struct CoopResultUploadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var value: Float = .zero
    @State private var total: Float = 1
    let session: SP3Session
    let results: [CoopResult]

    public init(session: SP3Session, results: [CoopResult]) {
        self.session = session
        self.results = results
    }

    @ViewBuilder
    func makeBody(request: SPProgress) -> some View {
        switch request.progress {
        case .PROGRESS:
            ProgressView()
                .frame(width: 24, height: 24, alignment: .center)
                .opacity(1.0)
        case .SUCCESS:
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 24, height: 24, alignment: .center)
        case .FAILURE:
            Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 24, height: 24, alignment: .center)
        }
    }

    public var body: some View {
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
                ProgressView("", value: value, total: total)
            })
            .frame(width: 320)
        })
        .animation(.default, value: session.requests.count)
        .onDisappear(perform: {
            self.session.requests.removeAll()
        })
        .onAppear(perform: {
            Task(priority: .background, operation: {
                do {
                    try await session.uploadAllCoopResultDetailQuery(results: results, completion: { value, total in
                        withAnimation(.default) {
                            self.value = value
                            self.total = total
                        }
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        dismiss()
                    })
                } catch(let error) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        dismiss()
                    })
                }
            })
        })
    }
}
