# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r1 = Role.create({name: "Regular", description: "Can read items"})
# r2 = Role.create({name: "Seller", description: "Can read and create items. Can update and destroy own items"})
r3 = Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})

u1 = User.create({fname: "Sally", lname: "Sliger", email: "sally@example.com", password: "aaaaaaaa", password_confirmation: "aaaaaaaa", role_id: r1.id})
u2 = User.create({fname: "Sue", lname: "Blue", email: "sue@example.com", password: "aaaaaaaa", password_confirmation: "aaaaaaaa", role_id: r1.id})
u3 = User.create({fname: "Kev", lname: "Simmons", email: "kev@example.com", password: "aaaaaaaa", password_confirmation: "aaaaaaaa", role_id: r1.id})
u4 = User.create({fname: "Jack", lname: "Black", email: "jack@example.com", password: "aaaaaaaa", password_confirmation: "aaaaaaaa", role_id: r3.id})

s1 = School.new({ name: 'Belvoir Christian Academy', email: 'info@bcalions.org', url: 'http://bcalions.org', city: 'Chattanooga', state: 'TN', zip: '37412'})
s2 = School.new({ name: 'Brainerd Baptist Academy', email: 'info@brainerdbapt.org', url: 'http://brainerdbapt.org', city: 'Chattanooga', state: 'TN', zip: '37411'})

c1 = Category.create({ name: 'Boys Tops', description: 'Shirts, Jackets, Vests, Coats, etc.'})
c2 = Category.create({ name: 'Girls Tops', description: 'Shirts, Jackets, Vests, Coats, etc.'})
c3 = Category.create({ name: 'Boys Bottoms', description: 'Pants, Shorts, etc'})
c4 = Category.create({ name: 'Girls Bottoms', description: 'Shirts, Jackets, Vests, Coats, etc.'})

co1 = Condition.create({ description: 'Excellent' })
co2 = Condition.create({ description: 'Good' })
co3 = Condition.create({ description: 'Fair' })
co4 = Condition.create({ description: 'Poor' })

i1 = Item.create({name: "Rayban Sunglasses", description: "Stylish shades", price: 99.99, user_id: u2.id, school_id: s1.id, category_id: c1.id, condition_id: c1.id})
i2 = Item.create({name: "Gucci watch", description: "Expensive timepiece", price: 199.99, user_id: u2.id, school_id: s1.id, category_id: c1.id, condition_id: c1.id})
i3 = Item.create({name: "Henri Lloyd Pullover", description: "Classy knitwear", price: 299.99, user_id: u3.id, school_id: s1.id, category_id: c1.id, condition_id: c1.id})
i4 = Item.create({name: "Porsche socks", description: "Cosy footwear", price: 399.99, user_id: u3.id, school_id: s1.id, category_id: c1.id, condition_id: c1.id})

