class_name VoteSimulator
extends Node

var groups: Array[EntityGroup]
var voters = [] # Jacy są głosujący
var num_voters = 10 # Ile jest głosujących łącznie
var num_entity = [] # Ile jest głosujących w każdej grupie
var percent_relationship = [] # Jakie jest poparcie w każdej grupie

func init(entity_groups: Array[EntityGroup]):
	groups = entity_groups
	for i in groups.size():
		num_entity.append(0)
		percent_relationship.append(0)
	for entity in range(num_voters):
		var random_index = randi() % groups.size()
		var random_group = groups[random_index].group_name
		voters.append(random_group)
		num_entity[random_index] += 1

func count_percent(king: King):
	for group in groups:
		var total_group_rel = 0
		var king_rel = 0
		for relation in group.relationships:
			total_group_rel += relation["relationship"]
			if relation["king"].id == king.id:
				king_rel = relation["relationship"]
		var percent = 0
		if total_group_rel != 0:
			percent = float(king_rel) / float(total_group_rel) * 100.0
		var index = groups.find(group)
		percent_relationship[index] = percent

func count_support(king: King):
	count_percent(king)
	var total_voters = 0

	for entity in num_entity.size():
		var group_voters = num_entity[entity]
		var group_percent = percent_relationship[entity] / 100.0  # zamieniamy % na ułamek
		total_voters += int(round(group_voters * group_percent))

	return total_voters
