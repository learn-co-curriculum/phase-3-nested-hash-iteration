# Enumerables: Iterating Over Nested Hashes

## Learning Goals

- Iterate over a nested hash

## Iterating Over Nested Hashes

In Ruby, it's possible to use enumerable methods to iterate over key-value pairs
in hashes. For example:

```rb
jon_snow = {
  name: "Jon",
  email: "jon_snow@thewall.we"
}

jon_snow.each do |key, value|
  puts "Key: #{key}"
  puts "Value: #{value}"
end

# Key: name
# Value: Jon
# Key: email
# Value: jon_snow@thewall.we
```

What happens when we want to iterate over a nested hash like the one below?
Let's iterate over our nested hash one level at a time; iterating over the first
level of our hash would look like this:

```rb
contacts = {
  "Jon Snow" => {
    name: "Jon",
    email: "jon_snow@thewall.we",
    favorite_ice_cream_flavors: ["chocolate", "vanilla", "mint chip"],
    knows: nil
  },
  "Freddy Mercury" => {
    name: "Freddy",
    email: "freddy@mercury.com",
    favorite_ice_cream_flavors: ["strawberry", "cookie dough", "mint chip"]
  }
}

contacts.each do |person, data|
  puts "#{person}: #{data}"
end
```

This should return:

```txt
Jon Snow: {
  :name=>"Jon",
  :email=>"jon_snow@thewall.we",
  :favorite_ice_cream_flavors=>["chocolate", "vanilla", "mint chip"],
  :knows=>nil
}
Freddy Mercury: {
  :name=>"Freddy",
  :email=>"freddy@mercury.com",
  :favorite_ice_cream_flavors=>["strawberry", "cookie dough", "mint chip"]
}
```

On the first level, the **keys** are our contacts' names, "Jon Snow" and "Freddy
Mercury", and our **values** are the hashes that contain a series of key/value
pairs describing them.

Let's iterate over the second level of our `contacts` hash. In order to access
the key/value pairs of the second tier (i.e. the name, email, and other data
about each contact), we need to iterate _down into_ that level. So, we pick up
where we left off with the previous iteration and we keep going:

```rb
contacts.each do |person, data|
  #at this level, "person" is Jon Snow or Freddy Mercury and "data" is a hash of
  #key/value pairs to iterate over the "data" hash, we can use the following line:

  data.each do |attribute, value|
    puts "#{attribute}: #{value}"
  end
end
```

That should output the following:

```txt
name: Jon
email: jon_snow@thewall.we
favorite_ice_cream_flavors: ["chocolate", "vanilla", "mint chip"]
knows:
name: Freddy
email: freddy@mercury.com
favorite_ice_cream_flavors: ["strawberry", "cookie dough", "mint chip"]
```

Let's take it one step further and print out _just the favorite ice cream
flavors_. Once again, we'll need to iterate down into that level of the hash,
then we can access the favorite ice cream array and print out the flavors:

```ruby
contacts.each do |person, data|
  #at this level, "person" is Jon Snow or Freddy and "data" is a hash of
  #key/value pairs to iterate over the "data" hash, we can use the following
  #line:

  data.each do |attribute, value|
    #at this level, "attribute" describes the key of :name, :email,
    #:favorite_ice_cream_flavors, or :knows we need to first check and see if
    #the key is :favorite_ice_cream_flavors, if it is, that means the VALUE is
    #an array that we can iterate over to print out each element

    if attribute == :favorite_ice_cream_flavors
      value.each do |flavor|
        # here, each index element in an ice cream flavor string
        puts "#{flavor}"
      end
    end
  end
end
```

This should output:

```txt
chocolate
vanilla
mint chip
strawberry
cookie dough
mint chip
```

Being able to access data from a nested hash like this gives us a lot of ways to
work with this complex data structure and derive insights. What if instead of
printing out the favorite ice creams of our contacts, we wanted to collect their
email addresses in an array? Well, we could do something like this:

```rb
emails = []

contacts.each do |person, data|
  data.each do |attribute, value|
    if attribute == :email
      emails << value
    end
  end
end

emails
```

## Code Along Exercise

Fork and clone this exercise to code along!

Let's do an exercise to get some practice iterating through nested arrays.
You'll be coding your solution in `contacts.rb`. You'll be manipulating the hash
that is returned by the `#contacts` method:

```rb
def contacts
  {
    "Jon Snow" => {
      name: "Jon",
      email: "jon_snow@thewall.we",
      favorite_ice_cream_flavors: ["chocolate", "vanilla"]
    },
    "Freddy Mercury" => {
      name: "Freddy",
      email: "freddy@mercury.com",
      favorite_ice_cream_flavors: ["strawberry", "cookie dough", "mint chip"]
    }
  }
end
```

Your good buddy Freddy Mercury has recently developed a strawberry allergy! You
need to delete `"strawberry"` from his list of favorite ice cream flavors in the
`remove_strawberry` method.

Iterate over the `contacts` hash and when you reach the key
`:favorite_ice_cream_flavors`, remove `"strawberry"` from the Array of Freddy's
favorite ice cream flavors.

There are at least two ways you can accomplish this, and for this code along,
we'll work with the second way.

1. You can directly iterate over the hash that is the value of the
   `"Freddy Mercury"` key by calling an enumerator method in
   `contacts["Freddy Mercury"]`.

2. You can set a iterate through the hash and check for `Freddy Mercury` only;
   when you reach the appropriate level, check to see if the key `==` ("is equal
   to") `:favorite_ice_cream_flavors`. If it is, check to see if the array of
   flavors contains `"strawberry"`. If it does, then delete it from the array.

### Step 1: Iterate over the first level

Inside the `#remove_strawberry` method, let's take our first dive into the
contacts hash. Then we'll use `binding.pry` to see where we are.

We are going to first iterate over the top level of the hash where the keys
should be the person and the values should be a hash of details about the
person.

**Note on variable naming:** This process will be remarkably easier if you name
your variables to accurately reflect the data they represent. For now, when the
value we're iterating over is another hash, we will explicitly add a `_hash` to
the end of the variable name (like `contact_details_hash` below).

Add this code inside the `#remove_strawberry` method:

```rb
contacts.each do |person, contact_details_hash|
  binding.pry
end
```

We can enter the Pry session in one of two ways: by running `learn test` or by
running `ruby contacts.rb`. We'll use `learn test`.

Run `learn test` in the terminal and, at the Pry prompt, check that our defined
variables (`person` and `contact_details_hash`) match our expectations.

```rb
person
# => "Jon Snow"

contact_details_hash
# => {:name=>"Jon", :email=>"jon_snow@thewall.we", :favorite_ice_cream_flavors=>["chocolate", "vanilla"]}
```

Excellent! They do!

Type `exit` while in Pry to continue. The `binding.pry` breakpoint should
trigger a second time because we have _two_ contacts. You can verify that we're
in the second loop through our hash by checking the values of `person` and
`contact_details_hash` at the Pry prompt.

Typing `exit` now will end the loop and exit Pry since we've finished
iterating through our contacts. It will also display the results of the test,
which we haven't passed just yet.

### Step 2. Iterate over the second level

Update your code to match the following:

```rb
def remove_strawberry(contacts)
  contacts.each do |person, contact_details_hash|
    if person == "Freddy Mercury"
      contact_details_hash.each do |attribute, data|
        binding.pry
      end
    end
  end
end
```

Again, let's jump into our `binding.pry` using `learn test`. We can verify that
we've found the record for Freddy Mercury by checking the values of our
variables:

```rb
attribute
# => :name

data
# => "Freddy"
```

> Remember, if you get stuck and can't enter text in Pry, hit `q` to continue!

Before we move on, you will need to exit `pry` again so you can see the results
of the new code we'll be writing in Step 3. We are now inside the loop through
the attributes. Because there are three of them, we will need to run `exit`
three times to finish the loop and exit `pry`. Alternatively, you can run
`exit-program` or `!!!` at any time to exit out of `pry` entirely.

### Step 3. Locate the element we're looking for

Update your code to match the following:

```rb
def remove_strawberry(contacts)
  contacts.each do |person, contact_details_hash|
    if person == "Freddy Mercury"
      contact_details_hash.each do |attribute, data|
        if attribute == :favorite_ice_cream_flavors
          binding.pry
        end
      end
    end
  end
end
```

This time we are still iterating through the attributes but we've added a
conditional so the `pry` will only hit when the attribute is equal to
`:favorite_ice_cream_flavors`. If we check the value of `data` in our binding,
we should see the array containing Freddy's favorite flavors.

#### Step 4. Update the hash

Lastly, we will use the `#delete_if` array method to iterate through the ice
cream array and remove any element that matches "strawberry". Recall that `data`
is the array containing Freddy's favorite ice cream flavors. `#delete_if` will
iterate through the array, check each element to see if it is equal to
"strawberry", and delete the element if the block returns `true`. [Learn
more about `#delete_if` in the ruby docs.][delete_if docs].

[delete_if docs]: https://docs.ruby-lang.org/en/2.7.0/Hash.html#method-i-delete_if

The full method should now be:

```rb
def remove_strawberry(contacts)
  contacts.each do |person, contact_details_hash|
    if person == "Freddy Mercury"
      contact_details_hash.each do |attribute, data|
        if attribute == :favorite_ice_cream_flavors
          data.delete_if {|ice_cream| ice_cream == "strawberry"}
        end
      end
    end
  end
end
```

Congrats! You made it. Test that your method works by running `ruby contacts.rb`
in the terminal. It should output the hash without strawberry ice cream. Also,
be sure to run the specs to make sure they pass.
