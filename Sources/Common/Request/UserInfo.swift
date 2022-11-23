//
//  UserInfo.swift
//  SplatNet2
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Foundation

public class UserInfo: SPCredential {
    /// ニックネーム
    let nickname: String
    /// メンバーシップ加入しているか
    let membership: Bool
    /// フレンドコード
    let friendCode: String
    /// 画像URL
    let thumbnailURL: URL

    override init(sessionToken: SessionToken.Response, gameServiceToken: GameServiceToken.Response, gameWebToken: GameWebToken.Response, bulletToken: BulletToken.Response) {
        self.nickname = gameServiceToken.result.user.name
        self.membership = gameServiceToken.result.user.links.nintendoAccount.membership.active
        self.friendCode = gameServiceToken.result.user.links.friendCode.id
        self.thumbnailURL = URL(unsafeString: gameServiceToken.result.user.imageUri)
        super.init(sessionToken: sessionToken, gameServiceToken: gameServiceToken, gameWebToken: gameWebToken, bulletToken: bulletToken)
    }

    override init(sessionToken: SessionToken.Response, gameServiceToken: GameServiceToken.Response, gameWebToken: GameWebToken.Response, iksmSession: IksmSession.Response) {
        self.nickname = gameServiceToken.result.user.name
        self.membership = gameServiceToken.result.user.links.nintendoAccount.membership.active
        self.friendCode = gameServiceToken.result.user.links.friendCode.id
        self.thumbnailURL = URL(unsafeString: gameServiceToken.result.user.imageUri)
        super.init(sessionToken: sessionToken, gameServiceToken: gameServiceToken, gameWebToken: gameWebToken, iksmSession: iksmSession)
    }

    enum CodingKeys: String, CodingKey {
        case nickname
        case membership
        case friendCode
        case thumbnailURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.membership = try container.decode(Bool.self, forKey: .membership)
        self.friendCode = try container.decode(String.self, forKey: .friendCode)
        self.thumbnailURL = URL(unsafeString: try container.decode(String.self, forKey: .thumbnailURL))
        try super.init(from: decoder)
    }
}

extension UserInfo: Identifiable, Hashable, Equatable {
    public static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.id == rhs.id
    }

    public static func != (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.id != rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var id: String { nsaid }
}