extends Node
#class_name SignalBus

signal unhand_card(card: CardScene)
signal play_card(card: CardScene)
signal draw_card(card: CardScene)
signal enemy_act(enemy: Enemy)

# Player events
signal player_turn_ended
signal player_hand_drawn
signal player_hand_discarded
