# Performance comparing memory vs database
A very brief (and basic) comparison on speeds, usages on doing things in memory vs on the database

---

# Setup
Create 1000 'users' with randomly generated usernames

```ruby
require "./setup.rb"

puts User.all.map(&:inspect)
```

---

# Count/Size Benchmarking
Count benchmark in memory vs on a postgres database

```ruby
require "./benchmark.rb"

puts Benchmarks.new.count_benchmark
```

---

# Sorting Benchmarking

```ruby
require "./benchmark.rb"

puts Benchmarks.new.sort_benchmark
```