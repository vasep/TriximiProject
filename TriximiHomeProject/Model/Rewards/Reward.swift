//
//  RewardCode.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 14.2.21.
//
import Foundation

struct Reward : Codable {
	let id : String?
	let name : String?
	let points : Int?
	let fineprint : String?
	let effectiveDate : Int?
	let expiryDate : Int?
	let chain_id : String?
	let expired : Bool?
	let sort_by_id : String?
	let gifter : String?
	let image_url : String?
	let new_reward : String?
	let additional_fields : String?
	let app_text : String?
	let description : String?
	let title : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case points = "points"
		case fineprint = "fineprint"
		case effectiveDate = "effectiveDate"
		case expiryDate = "expiryDate"
		case chain_id = "chain_id"
		case expired = "expired"
		case sort_by_id = "sort_by_id"
		case gifter = "gifter"
		case image_url = "image_url"
		case new_reward = "new_reward"
		case additional_fields = "additional_fields"
		case app_text = "app_text"
		case description = "description"
		case title = "title"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		points = try values.decodeIfPresent(Int.self, forKey: .points)
		fineprint = try values.decodeIfPresent(String.self, forKey: .fineprint)
		effectiveDate = try values.decodeIfPresent(Int.self, forKey: .effectiveDate)
		expiryDate = try values.decodeIfPresent(Int.self, forKey: .expiryDate)
		chain_id = try values.decodeIfPresent(String.self, forKey: .chain_id)
		expired = try values.decodeIfPresent(Bool.self, forKey: .expired)
		sort_by_id = try values.decodeIfPresent(String.self, forKey: .sort_by_id)
		gifter = try values.decodeIfPresent(String.self, forKey: .gifter)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		new_reward = try values.decodeIfPresent(String.self, forKey: .new_reward)
		additional_fields = try values.decodeIfPresent(String.self, forKey: .additional_fields)
		app_text = try values.decodeIfPresent(String.self, forKey: .app_text)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}

}
