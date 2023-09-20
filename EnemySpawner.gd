extends Node

var Enemy = preload("res://Enemy.tscn")

var wave = 0;
var enemyList = []
var spawnpoints = [[20, 80], [50, 120],[90, 170],[500, 50]]

func _ready():
	nextWave()
	pass # Replace with function body.

func _process(delta):
	var i = 0
	for enemy in enemyList:
		if not enemy || enemy.get_meta("dead") == true:
			enemyList.remove_at(i)
		i = i + 1;
	
	if len(enemyList) == 0:
		nextWave()

func spawnEnemies(count):
	var i = 0;
	while i < count:
		print("spawn enemy")
		var enemyInstance = Enemy.instantiate()
		enemyInstance.name = "Enemy" + str(randf())
		enemyInstance.position = Vector2(spawnpoints.pick_random()[0] + i, spawnpoints.pick_random()[1] + i)
		get_parent().call_deferred("add_child", enemyInstance)
		enemyList.append(enemyInstance)
		i = i+1;
	
func startWave():
	print("start wave")
	if wave == 0:
		spawnEnemies(1)
	else:
		spawnEnemies(wave * 3)


func nextWave():
	wave = wave+1;
	startWave()
