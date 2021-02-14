//
//  RewardCode.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 14.2.21.
//

import Foundation

import Foundation
struct RedeemModel : Codable {
    let status : Bool?
    let notice : Bool?
    let reward_code : Int?
    let reward_timer : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case notice = "notice"
        case reward_code = "reward_code"
        case reward_timer = "reward_timer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        notice = try values.decodeIfPresent(Bool.self, forKey: .notice)
        reward_code = try values.decodeIfPresent(Int.self, forKey: .reward_code)
        reward_timer = try values.decodeIfPresent(Int.self, forKey: .reward_timer)
    }

}
