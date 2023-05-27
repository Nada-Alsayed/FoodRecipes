//
//  MyResult.swift
//  Food_Recipes
//
//  Created by Moaz Khaled on 26/05/2023.
//

import Foundation

// MARK: - MyResult
class MyResult: Codable {
    let count: Int?
    let results: [Reciepe]?

    init(count: Int?, results: [Reciepe]?) {
        self.count = count
        self.results = results
    }
}

// MARK: - Result
class Reciepe: Codable {
    let show: Show?
    let sections: [Section]?
    let tags: [Tag]?
    let credits: [Credit]?
    let videoURL: String?
    let name: String?
    let thumbnailURL: String?
    let numServings: Int?
    let instructions: [Instruction]?
    let yields: String?
    let originalVideoURL: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case show, sections, tags, credits
        case videoURL = "video_url"
        case name
        case thumbnailURL = "thumbnail_url"
        case numServings = "num_servings"
        case instructions, yields
        case originalVideoURL
        case id
    }

    init(show: Show?, sections: [Section]?, tags: [Tag]?, credits: [Credit]?, videoURL: String?, name: String?, thumbnailURL: String?, numServings: Int?, instructions: [Instruction]?, yields: String?, originalVideoURL: String?, id: Int?) {
        self.show = show
        self.sections = sections
        self.tags = tags
        self.credits = credits
        self.videoURL = videoURL
        self.name = name
        self.thumbnailURL = thumbnailURL
        self.numServings = numServings
        self.instructions = instructions
        self.yields = yields
        self.originalVideoURL = originalVideoURL
        self.id = id
    }

}

// MARK: - Credit
class Credit: Codable {
    let name, type: String?

    init(name: String?, type: String?) {
        self.name = name
        self.type = type
    }
}

// MARK: - Instruction
class Instruction: Codable {
    let startTime: Int?
    let appliance: String?
    let endTime, temperature, id, position: Int?
    let displayText: String?

    enum CodingKeys: String, CodingKey {
        case startTime
        case appliance
        case endTime
        case temperature, id, position
        case displayText
    }

    init(startTime: Int?, appliance: String?, endTime: Int?, temperature: Int?, id: Int?, position: Int?, displayText: String?) {
        self.startTime = startTime
        self.appliance = appliance
        self.endTime = endTime
        self.temperature = temperature
        self.id = id
        self.position = position
        self.displayText = displayText
    }
}

// MARK: - Section
class Section: Codable {
    let position: Int?
    let components: [Component]?
    let name: String?

    init(position: Int?, components: [Component]?, name: String?) {
        self.position = position
        self.components = components
        self.name = name
    }
}

// MARK: - Component
class Component: Codable {
    let rawText, extraComment: String?
    let ingredient: Ingredient?
    let id, position: Int?
    let measurements: [Measurement]?

    enum CodingKeys: String, CodingKey {
        case rawText
        case extraComment
        case ingredient, id, position, measurements
    }

    init(rawText: String?, extraComment: String?, ingredient: Ingredient?, id: Int?, position: Int?, measurements: [Measurement]?) {
        self.rawText = rawText
        self.extraComment = extraComment
        self.ingredient = ingredient
        self.id = id
        self.position = position
        self.measurements = measurements
    }
}

// MARK: - Ingredient
class Ingredient: Codable {
    let displayPlural: String?
    let id: Int?
    let displaySingular: String?
    let updatedAt: Int?
    let name: String?
    let createdAt: Int?

    enum CodingKeys: String, CodingKey {
        case displayPlural
        case id
        case displaySingular
        case updatedAt
        case name
        case createdAt
    }

    init(displayPlural: String?, id: Int?, displaySingular: String?, updatedAt: Int?, name: String?, createdAt: Int?) {
        self.displayPlural = displayPlural
        self.id = id
        self.displaySingular = displaySingular
        self.updatedAt = updatedAt
        self.name = name
        self.createdAt = createdAt
    }
}

// MARK: - Measurement
class Measurement: Codable {
    let unit: Unit?
    let quantity: String?
    let id: Int?

    init(unit: Unit?, quantity: String?, id: Int?) {
        self.unit = unit
        self.quantity = quantity
        self.id = id
    }
}

// MARK: - Unit
class Unit: Codable {
    let name, displayPlural, displaySingular, abbreviation: String?
    let system: System?

    enum CodingKeys: String, CodingKey {
        case name
        case displayPlural
        case displaySingular
        case abbreviation, system
    }

    init(name: String?, displayPlural: String?, displaySingular: String?, abbreviation: String?, system: System?) {
        self.name = name
        self.displayPlural = displayPlural
        self.displaySingular = displaySingular
        self.abbreviation = abbreviation
        self.system = system
    }
}

enum System: String, Codable {
    case imperial = "imperial"
    case metric = "metric"
    case none = "none"
}

// MARK: - Show
class Show: Codable {
    let name: String?
    let id: Int?

    init(name: String?, id: Int?) {
        self.name = name
        self.id = id
    }
}

// MARK: - Tag
class Tag: Codable {
    let name: String?
    let id: Int?
    let displayName, type: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case displayName
        case type
    }

    init(name: String?, id: Int?, displayName: String?, type: String?) {
        self.name = name
        self.id = id
        self.displayName = displayName
        self.type = type
    }
}
