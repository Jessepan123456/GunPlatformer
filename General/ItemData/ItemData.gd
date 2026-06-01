class_name ItemData extends Resource

enum ItemType{
	GUN,
	ITEM,
	TOOL,
}

@export var type : ItemType
@export var name : String
@export var icon : Texture2D
@export var scene : PackedScene
