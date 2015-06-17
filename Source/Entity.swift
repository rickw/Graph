/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*
* Entity
*
* Represents Entity Nodes, which are person, places, or things -- nouns.
*/

import Foundation

@objc(Entity)
public class Entity: NSObject {
	internal let node: ManagedEntity
	
	/**
	* init
	* Initializes Entity with a given ManagedEntity.
	* @param        entity: ManagedEntity!
	*/
	internal init(entity: ManagedEntity!) {
		node = entity
	}
	
	/**
	* init
	* An initializer for the wrapped Model Object with a given type.
	* @param        type: String!
	*/
	public convenience init(type: String) {
		self.init(entity: ManagedEntity(type: type))
	}
	
	/**
	* nodeClass
	* Retrieves the nodeClass for the Model Object that is wrapped internally.
	* @return       String
	*/
	public var nodeClass: String {
		return node.nodeClass
	}
	
	/**
	* type
	* Retrieves the type for the Model Object that is wrapped internally.
	* @return       String
	*/
	public var type: String {
		return node.type
	}
	
	/**
	* id
	* Retrieves the ID for the Model Object that is wrapped internally.
	* @return       String? of the ID
	*/
	public var id: String {
		var nodeURL: NSURL = node.objectID.URIRepresentation()
		var oID: String = nodeURL.lastPathComponent!
		return nodeClass + type + oID
	}
	
	/**
	* createdDate
	* Retrieves the date the Model Object was created.
	* @return       NSDate?
	*/
	public var createdDate: NSDate {
		return node.createdDate
	}
	
	/**
	* properties[ ]
	* Allows for Dictionary style coding, which maps to the wrapped Model Object property values.
	* @param        name: String!
	* get           Returns the property name value.
	* set           Value for the property name.
	*/
	public subscript(name: String) -> AnyObject? {
		get {
			return node[name]
		}
		set(value) {
			node[name] = value
		}
	}
	
	/**
	* addGroup
	* Adds a Group name to the list of Groups if it does not exist.
	* @param        name: String!
	* @return       Bool of the result, true if added, false otherwise.
	*/
	public func addGroup(name: String) -> Bool {
		return node.addGroup(name)
	}
	
	/**
	* hasGroup
	* Checks whether the Node is a part of the Group name passed or not.
	* @param        name: String!
	* @return       Bool of the result, true if is a part, false otherwise.
	*/
	public func hasGroup(name: String) -> Bool {
		return node.hasGroup(name)
	}
	
	/**
	* removeGroup
	* Removes a Group name from the list of Groups if it exists.
	* @param        name: String!
	* @return       Bool of the result, true if exists, false otherwise.
	*/
	public func removeGroup(name: String!) -> Bool {
		return node.removeGroup(name)
	}
	
	/**
	* groups
	* Retrieves the Groups the Node is a part of.
	* @return       Array<String>
	*/
	public var groups: Array<String> {
		get {
			var groups: Array<String> = Array<String>()
			for group in node.groupSet {
				groups.append(group.name)
			}
			return groups
		}
		set(value) {
			assert(false, "[GraphKit Error: Groups is not allowed to be set.]")
		}
	}
	
	/**
	* properties
	* Retrieves the Properties the Node is a part of.
	* @return       Dictionary<String, AnyObject?>
	*/
	public var properties: Dictionary<String, AnyObject?> {
		get {
			var properties: Dictionary<String, AnyObject?> = Dictionary<String, AnyObject>()
			for property in node.propertySet {
				properties[property.name] = property.value
			}
			return properties
		}
		set(value) {
			assert(false, "[GraphKit Error: Properties is not allowed to be set.]")
		}
	}
	
	/**
    * actions
    * Retrieves an Array of Action Objects.
    * @return       Array<Action>
    */
    public var actions: Array<Action> {
        get {
            return actionsWhenSubject + actionsWhenObject
        }
        set(value) {
            assert(false, "[GraphKit Error: Actions may not be set.]")
        }
    }

    /**
    * actionsWhenSubject
    * Retrieves an Array of Action Objects when the Entity is a Subject of the Action.
    * @return       Array<Action>
    */
    public var actionsWhenSubject: Array<Action> {
        get {
            var nodes: Array<Action> = Array<Action>()
			for entry in node.actionSubjectSet {
				nodes.append(Action(action: entry as! ManagedAction))
			}
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: ActionWhenSubject may not be set.]")
        }
    }

    /**
    * actionsWhenObject
    * Retrieves an Array of Action Objects when the Entity is an Object of the Action.
    * @return       Array<Action>
    */
    public var actionsWhenObject: Array<Action> {
        get {
            var nodes: Array<Action> = Array<Action>()
			for entry in node.actionObjectSet {
				nodes.append(Action(action: entry as! ManagedAction))
			}
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: ActionWhenObject may not be set.]")
        }
    }

    /**
    * bonds
    * Retrieves an Array of Bond Objects.
    * @return       Array<Bond>
    */
    public var bonds: Array<Bond> {
        get {
            return bondsWhenSubject + bondsWhenObject
        }
        set(value) {
            assert(false, "[GraphKit Error: Bonds may not be set.]")
        }
    }

    /**
    * bondsWhenSubject
    * Retrieves an Array of Bond Objects when the Entity is a Subject of the Bond.
    * @return       Array<Bond>
    */
    public var bondsWhenSubject: Array<Bond> {
        get {
            var nodes: Array<Bond> = Array<Bond>()
			for entry in node.bondSubjectSet {
				nodes.append(Bond(bond: entry as! ManagedBond))
			}
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: BondWhenSubject may not be set.]")
        }
    }

    /**
    * bondsWhenObject
    * Retrieves an Array of Bond Objects when the Entity is an Object of the Bond.
    * @return       Array<Bond>
    */
    public var bondsWhenObject: Array<Bond> {
        get {
            var nodes: Array<Bond> = Array<Bond>()
			for entry in node.bondObjectSet {
				nodes.append(Bond(bond: entry as! ManagedBond))
			}
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: BondWhenObject may not be set.]")
        }
    }

    /**
    * delete
    * Marks the Model Object to be deleted from the Graph.
    */
    public func delete() {
		node.delete()
    }
}

extension Entity: Equatable, Printable {
	override public var description: String {
		return "{id: \(id), type: \(type), groups: \(groups), properties: \(properties), createdDate: \(createdDate)}"
	}
}

public func ==(lhs: Entity, rhs: Entity) -> Bool {
	return lhs.id == rhs.id
}