class_name Tower extends Node2D

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health: Health = $Health
@onready var health_bar: ProgressBar = $HealthBar

@export var faction: Util.Faction
@export var current_lane: Util.Lane
