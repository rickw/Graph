//
// Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program located at the root of the software package
// in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
//

// #internal

import Foundation

internal class Node <Type : ManagedNode> : NSObject {
	//
	//	:name:	object
	//
	internal let object: Type
	
	/**
		:name:	description
	*/
	internal override var description: String {
		return "[nodeClass: \(nodeClass), id: \(id), type: \(type), groups: \(groups), properties: \(properties), createdDate: \(createdDate)]"
	}
	
	//
	//	:name:	asJSON
	//
	internal var asJSON: JSON {
		var p: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
		for (k, v) in properties {
			switch v {
			case is Int,
				 is Double,
				 is Float,
				 is String,
				 is Bool,
				 is Array<AnyObject>,
				 is Dictionary<String, AnyObject>:
				p[k] = v
			default:
				p[k] = String(stringInterpolationSegment: v)
			}
		}
		var g: Array<String> = Array<String>()
		for v in groups {
			g.append(v)
		}
		let formatter = NSDateFormatter()
		formatter.dateStyle = .FullStyle
		formatter.timeStyle = .FullStyle
		let dictionary: Dictionary<String, AnyObject> = ["nodeClass": nodeClass, "id": id, "type": type, "groups": g, "properties": p, "createdDate": formatter.stringFromDate(createdDate)] as Dictionary<String, AnyObject>
		return JSON.parse(JSON.serialize(dictionary)!)!
	}
	
	//
	//	:name:	nodeClass
	//
	internal var nodeClass: NSNumber {
		return object.nodeClass
	}
	
	//
	//	:name:	type
	//
	internal var type: String {
		return object.type
	}
	
	//
	//	:name:	id
	//
	internal var id: String {
		let nodeURL: NSURL = object.objectID.URIRepresentation()
		let oID: String = nodeURL.lastPathComponent!
		return String(stringInterpolationSegment: nodeClass) + type + oID
	}
	
	//
	//	:name:	createdDate
	//
	internal var createdDate: NSDate {
		return object.createdDate
	}
	
	//
	//	:name:	groups
	//
	internal var groups: SortedSet<String> {
		let groups: SortedSet<String> = SortedSet<String>()
		for group in object.groupSet {
			let name: String = group.name
			groups.insert(name)
		}
		return groups
	}
	
	//
	//	:name:	properties
	//
	internal var properties: Dictionary<String, AnyObject> {
		var properties: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
		for property in object.propertySet {
			properties[property.name] = property.object
		}
		return properties
	}
	
	//
	//	:name:	init
	//
	internal init(object: Type) {
		self.object = object
	}
}