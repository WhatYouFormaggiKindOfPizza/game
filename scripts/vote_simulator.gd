class_name VoteSimulator
extends Node

var groups: Array[EntityGroup]
var voters: Array[String] = [] # Jacy są głosujący
var num_voters: int = 10000 # Ile jest głosujących łącznie
var num_entity: Array[int] = [] # Ile jest głosujących w każdej grupie
var percent_relationship: Array[float] = [] # Jakie jest poparcie w każdej grupie
var support_history = [] # Tab zawierająca łączną liczbę wyborców [King][w turze]

func init(entity_groups: Array[EntityGroup], kings: Array[King]) -> void:
	groups = entity_groups
	for i in groups.size():
		num_entity.append(0)
		percent_relationship.append(0)
	for entity in range(num_voters):
		var random_index = randi() % groups.size()
		var random_group = groups[random_index].group_name
		voters.append(random_group)
		num_entity[random_index] += 1
	for king in kings:
		support_history.append([])

#oblicza ile procent poparcia ma dany kandydat
func count_percent(king: King) -> void:
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

#Oblicza ile realnie wyborców ma dany kandydat
func compute_support(king: King) -> int:
	count_percent(king)
	var total_voters = 0

	for entity in num_entity.size():
		var group_voters = num_entity[entity]
		var group_percent = percent_relationship[entity] / 100.0  # zamieniamy % na ułamek
		total_voters += group_voters * group_percent

	return int(round(total_voters))

#zapisuje w tablicy support_history[[]] ile realnie wyborców miał [krol][w turze]
func update_support_history(kings: Array[King]) -> void:
	for k in kings:
		var support = compute_support(k)
		support_history[k.id].append(support)

#zwraca jakie poparcie mial krol king w turze turn
func show_support_history(king: King, turn: int) -> int:
	return support_history[king.id][turn]

#zwraca jakie procentowe poparcie mial krol king w turze turn
func show_support_history_percetages(king: King, turn: int) -> float:
	return float(support_history[king.id][turn])/float(num_voters) * 100

#zwraca roznice poparcia krola king w rundzie week
func show_week_supp_difrence(king: King, week: int) -> int:
	var supp_dif: int = support_history[king.id][week*7-1] - support_history[king.id][week*7 - 7]
	return supp_dif
