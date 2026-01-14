class_name Tower extends Node2D

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health: Health = $Health
@onready var health_bar: ProgressBar = $HealthBar

enum Faction {
	PLAYER,
	ENEMY,
}

enum Lane {
	TOP,
	MID,
	BOT
}

@export var faction: Faction
@export var current_lane: Lane
