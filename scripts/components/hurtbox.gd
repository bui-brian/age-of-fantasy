class_name Hurtbox extends Area2D

signal tower_attacked

@export var health: Health

func receive_hit(damage: int) -> void:
	if not health:
		return
	
	health.current_health -= damage # health_changed or health_depleted signal emits

func tower_hit(damage: int) -> void:
	if owner is not Tower:
		return
	
	if owner.faction == Util.Faction.PLAYER:
		GameState.set_player_health(GameState.player_total_health - damage)
	elif owner.faction == Util.Faction.ENEMY:
		GameState.set_enemy_health(GameState.enemy_total_health - damage)
	
	tower_attacked.emit()
