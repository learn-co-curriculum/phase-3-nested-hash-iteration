# Iterating Over Nested Hashes

##Objectives
1. Iterate over a nested hash


-

At this point you should be familiar with iterating over hashes that have one level—a series of key/value pairs on a single tier. For example: 

```ruby
jon_snow = {
  name: "Jon",
  email: "jon_snow@thewall.we"
}
```

What happens when we want to iterate over a multidimensional hash like the one below? Let's iterate over our nested hash one level at a time; iterating over the first level of our hash would look like this: 

```ruby
contacts = {
  "Jon Snow" => {
    name: "Jon",
    email: "jon_snow@thewall.we", 
    favorite_icecream_flavors: ["chocolate", "vanilla", "mint chip"]
  },
  "Freddy Mercury" => {
    name: "Freddy",
    email: "freddy@mercury.com",
    favorite_icecream_flavors: ["strawberry", "cookie dough", "mint chip"]
  }
}

contacts.each do |person, data|
  puts "#{person}: #{data}"
end
```

This should return: 

```ruby
Jon Snow:      
{ :name=>"Jon", 
  :email=>"jon_snow@thewall.we", 
  :favorite_icecream_flavors=>["chocolate", "vanilla", "mint chip"],
  :knows=>nil
}

Freddy Mercury: 
{ :name=>"Freddy", 
:email=>"freddy@mercury.com", 
:favorite_icecream_flavors=>["strawberry", "cookie dough", "mint chip"]
}
```

On the first level, the keys are our contacts' names, "Jon Snow" and "Freddy", and our values are the hashes that contain a series of key/value pairs describing them. 

Let's iterate over the second level of our `contacts` hash. In order to access the key/value pairs of the second tier (i.e. the name, email, and other data about each contact), we need to iterate *down into* that level. So, we pick up where we left off with the previous iteration and we keep going: 

```ruby
contacts.each do |person, data|
  #at this level, "person" is Jon Snow or Freddy and "data" is a hash of key/value pairs
  #to iterate over the "data" hash, we can use the following line: 
  
  data.each do |attribute, value|
    puts "#{attribute}: #{value}"
  end
end
```

That should output the following: 

```ruby

name: Jon
email: jon_snow@thewall.we
favorite_icecream_flavors: ["chocolate", "vanilla", "mint chip"]
knows: nil

name: Freddy
email: freddy@mercury.com
favorite_icecream_flavors: ["strawberry", "cookie dough", "mint chip"]

```

Let's take is one step further and print out *just the favorite ice cream flavors*. Once again, we'll need to iterate down into that level of the hash, then we can access the favorite ice cream array and print out the flavors: 

```ruby
contacts.each do |person, data|
  #at this level, "person" is Jon Snow or Freddy and "data" is a hash of key/value pairs
  #to iterate over the "data" hash, we can use the following line: 
  
  data.each do |attribute, value|
    #at this level, "attribute" is describes the key of :name, :email, :favorite_icecream_flavors, or :knows
    #we need to first check and see if the key is :favorite_icecream_flavors,
    #if it is, that means the VALUE is an array that we can iterate over to print out each element
    
    if attribute == :favorite_icecream_flavors
      value.each do |flavor|
        # here, each index element in an ice cream flavor string
        puts "#{flavor}"
      end
    end
  end
end
```

This should output: 

```ruby
chocolate
vanilla
mint chip
strawberry
cookie dough
mint chip
```

Now it's your turn! You're going to iterate through the levels of this hash to operate on one of the ice cream flavor arrays. 

**Reminder:** *Iterating through nested hashes is hard, and (we're pretty sure) you are not psychic. Meaning, you can't necessarily predict with perfect clarity what the key/value pair is at a certain level of the hash.* ***Use `binding.pry`*** *when you are iterating in upcoming labs to make sure you understand what the key/value pair is that you are iterating over.* 
