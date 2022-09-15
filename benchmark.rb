require 'benchmark/ips'
require "active_record"

class Benchmarks
  def initialize
    ActiveRecord::Base.establish_connection("postgres://postgres:postgres@localhost:5442/demo")
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  def count_benchmark
    Benchmark.ips do |x|
      x.config(:time => 1, :warmup => 1)
      x.report("database_count") { database_count }
      x.report("memory_count") { memory_count }

      x.compare!
    end
  end

  def sort_benchmark
    Benchmark.ips do |x|
      x.config(:time => 1, :warmup => 1)
      x.report("database_sort") { database_sort }
      x.report("memory_sort") { memory_sort }
      
      x.compare!
    end
  end

  def database_count
    User.count
  end

  def memory_count
    users = User.strict_loading.all

    users.size
  end

  def database_sort
    User.order(:username)
  end

  def memory_sort
    users = User.strict_loading.all

    users.sort_by(&:username)
  end
end

class User < ActiveRecord::Base ; end
