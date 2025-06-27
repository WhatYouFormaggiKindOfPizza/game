class_name VoteSimulator
extends Node

var groups: Array[EntityGroup]
var voters: Array[String] = [] # Jacy są głosujący
var num_voters: int = 10000 # Ile jest głosujących łącznie
var num_entity: Array[int] = [] # Ile jest głosujących w każdej grupie
var percent_relationship: Array[float] = [] # Jakie jest poparcie w każdej grupie
var support_history = [] # Tab zawierająca łączną liczbę wyborców [Candidate][w turze]

func init(entity_groups: Array[EntityGroup], candidates: Array[Candidate]) -> void:
	groups = entity_groups
	for i in groups.size():
		num_entity.append(0)
		percent_relationship.append(0)
	for entity in range(num_voters):
		var random_index = randi() % groups.size()
		var random_group = groups[random_index].group_name
		voters.append(random_group)
		num_entity[random_index] += 1
	for candidate in candidates:
		support_history.append([])

#oblicza ile procent poparcia ma dany kandydat
func count_percent(candidate: Candidate) -> void:
	for group in groups:
		var total_group_rel = 0
		var candidate_rel = 0
		for support in group.relationships:
			total_group_rel += support.get_value()
			if support.candidate.id == candidate.id:
				candidate_rel = support.get_value()
		var percent = 0
		if total_group_rel != 0:
			percent = float(candidate_rel) / float(total_group_rel) * 100.0
		var index = groups.find(group)
		percent_relationship[index] = percent

#Oblicza ile realnie wyborców ma dany kandydat
func compute_support(candidate: Candidate) -> int:
	count_percent(candidate)
	var total_voters = 0

	for entity in num_entity.size():
		var group_voters = num_entity[entity]
		var group_percent = percent_relationship[entity] / 100.0  # zamieniamy % na ułamek
		total_voters += group_voters * group_percent

	return int(round(total_voters))

#zapisuje w tablicy support_history[[]] ile realnie wyborców miał [krol][w turze]
func update_support_history(candidates: Array[Candidate]) -> void:
	for c in candidates:
		var support = compute_support(c)
		support_history[c.id].append(support)

#zwraca jakie poparcie mial krol candidate w turze turn
func show_support_history(candidate: Candidate, turn: int) -> int:
	return support_history[candidate.id][turn]

#zwraca jakie procentowe poparcie mial krol candidate w turze turn
func show_support_history_percetages(candidate: Candidate, turn: int) -> float:
	return float(support_history[candidate.id][turn])/float(num_voters) * 100

#zwraca roznice poparcia krola candidate w rundzie week
func show_week_supp_difrence(candidate: Candidate, week: int) -> int:
	var supp_dif: int = support_history[candidate.id][week*7-1] - support_history[candidate.id][week*7 - 7]
	return supp_dif
