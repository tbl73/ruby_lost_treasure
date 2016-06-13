#function to allow users to add fruit to their supplies
def gathering
	choice = gets.chomp.downcase
	while choice != "exit"
		if (choice == "supplies") || (choice == "book") || (choice == "list")
			options(choice)
			puts "Enter a fruit or type exit.".to_yaml
		elsif @fruit_list.include? choice
			@supplies.push(choice)
			puts "You collected #{choice}. Choose another fruit or type exit.".to_yaml
		else
			puts "That doesn't grow in this jungle - try something else.".to_yaml
		end
		choice = gets.chomp.downcase	
	end
	#call the next portion of the story
	river(@story_hash)
end

def options(choice)
	case choice
		when "supplies"
			supply_list
		when "book"
			book
		when "list"
			action_list
	end	
	sleep(2)		
end

def supply_list
	puts ""
	puts "These supplies are in my pack:"

	@supplies.each do |item|
		puts item
	end
end

def book
	puts ""
	#display name of book pages
	@book.each do |key, value|
		puts key.to_yaml
	end
	#get user choice of which book page to look at
	puts "Which page would you like to see?".to_yaml
	choice = gets.chomp.downcase
	#display user chosen page
	puts @book[choice]
end

def action_list
	#puts "drop"
	puts "Type \"give\" to give an item to someone.".to_yaml
	#puts "look"
end

def give(item)
	@supplies.delete(item)
end

#puzzle for distracting monkeys
def monkeys
	#set two variables to false and then test against them
	action = false
	gift = false
	fruit = ""

	#until both variables are set to true by comparison, keep looping
	until action == true && gift == true
		input = gets.chomp.downcase
		input_array = input.split(" ")
		
		if (input == "supplies") || (input == "list") || (input == "book")
			options(input)
		else
			input_array.each do |item|
				if item == "give"
					action = true
				elsif (@supplies.include? item) 
					give(item)
					if (@fruit_list.include? item)
					gift = true
					end
				end
			end
		end
		puts "The monkeys keep throwing things at you.  What can you do?".to_yaml
	end
	#go to the next step in the story
	temple2(@story_hash)
end

def door_puzzle
	#array of correct solution
	right_colors = %w(red red red yellow blue black)
	user_colors = []
	puts "Type the color names in the correct order, pressing enter after each color.".to_yaml
	6.times do
	 print "Color name: "
	 color = gets.chomp.downcase
	 user_colors.push(color)
	end
	if right_colors == user_colors
		clear
		puts "You hear a loud click, and when you try to push the door open, it starts to move.".to_yaml
		puts ""
		treasure_room(@story_hash)
	else
		puts "Nothing happens.  Perhaps you have the wrong order.  You try again...".to_yaml
		sleep(1)
		door_puzzle
	end
end
