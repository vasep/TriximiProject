//
//  RewardCode.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 14.2.21.
//
import Foundation

struct RewardsModel : Codable {
	let status : Bool?
	let balance : Balance?
	let rewards : [Reward]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case balance = "balance"
		case rewards = "rewards"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		balance = try values.decodeIfPresent(Balance.self, forKey: .balance)
		rewards = try values.decodeIfPresent([Reward].self, forKey: .rewards)
	}

}
