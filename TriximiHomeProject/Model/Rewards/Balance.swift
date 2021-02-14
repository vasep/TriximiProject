//
//  RewardCode.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 14.2.21.
//
import Foundation

struct Balance : Codable {
	let points : Int?
	let milestone_points : Int?

	enum CodingKeys: String, CodingKey {

		case points = "points"
		case milestone_points = "milestone_points"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		points = try values.decodeIfPresent(Int.self, forKey: .points)
		milestone_points = try values.decodeIfPresent(Int.self, forKey: .milestone_points)
	}

}
