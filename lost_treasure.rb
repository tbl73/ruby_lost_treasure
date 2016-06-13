#the text of the story
require_relative 'story_text'
require_relative 'puzzles.rb'
require 'yaml'
YAML::ENGINE.yamler = 'psych'

@invalid = "That wasn't a valid choice, please try again."

@directions =  "If you want to look at your supplies at any time, type \"supplies\".\n To look at the book pages, type \"book\".\n To see a list of actions, type \"list\"." 

@supplies = %w(water flashlight nuts)
@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)

#function to clear the screen
def clear
	system 'cls'
	puts ""
end

def invalid
	puts @invalid.to_yaml
	sleep(2)
end

def beginning(story, book)
#show text of story
	clear
	puts story["start"].to_yaml
	puts book["page1"]
	puts story["start2"].to_yaml
	puts book["sketch"]
	puts story["start3"].to_yaml

	choice = gets.chomp.downcase

	#display different paths depending on user input
	#if user types yes, continue story
	if choice == "yes" || choice == "y"
		clear
		puts story["start_yes"].to_yaml
		puts ""
		puts @directions.to_yaml
		puts ""
		puts story["jungle"].to_yaml
		gathering
	#if user types no, display ending
	elsif choice == "no" || choice == "n"
		clear
		puts story["start_no"].to_yaml
	#if user types something else, try again
	else
		clear
		invalid
		beginning(@story_hash, @book)
	end

end

def river(story)
	clear
	puts story["river"].to_yaml
	choice = gets.chomp.downcase
		case choice
			when "boat"
				random(@story_hash)
			when "bridge"
				clear
				puts story["bridge"].to_yaml
				puts ""
				puts story["temple1"].to_yaml
				monkeys
			when "supplies", "book", "list"
				options(choice)
				river(@story_hash)
			else
				invalid
				river(@story_hash)
		end
end

#boat crossing has randomized outcomes
def random(story)
	clear
	alternate = rand(1..3)
	case alternate
		when 1
			puts story["boat1"].to_yaml
		when 2
			puts story["boat2"].to_yaml
			puts story["temple1"].to_yaml
			monkeys
		when 3
			puts story["boat3"].to_yaml
	end
end

#next step in the story - user chooses different hall for different outcomes
def temple2(story)
	clear
	puts story["temple2"].to_yaml
	puts ""
	choice = gets.chomp.downcase
	puts ""
	case choice
		when "left"
			puts story["temple_hall_left"].to_yaml
		when "center"
			puts story["temple_hall_center"].to_yaml
		when "right"
			puts story["temple_hall_right"].to_yaml
			hall2(@story_hash)
		when "supplies", "book", "list"
			options(choice)
			temple2(@story_hash)
		else
			invalid
			temple2(@story_hash)
	end
end

def hall2(story)
	clear
	puts story["hall2"].to_yaml

	choice = gets.chomp.downcase

	case choice
		when "right"
			puts story["hall2_right"].to_yaml
		when "left"
			puts story["hall2_left"].to_yaml
			door_puzzle
		when "supplies", "book", "list"
			options(choice)
			hall2(@story_hash)
		else
			invalid
			hall2(@story_hash)
	end
end

def treasure_room(story)
	puts story ["treasure_room"].to_yaml
end

clear
puts "	The Lost Treasure of Z\n	A Choose Your Own Adventure Game"
sleep(1)
beginning(@story_hash, @book)