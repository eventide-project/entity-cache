require_relative './interactive_init'

[:exclusive, :shared].each do |scope|

  subject = Controls::Subject.example(random: true)

  record = Controls::Record.example

  cache_1 = EntityCache.build(subject, scope: scope)
  cache_2 = EntityCache.build(subject, scope: scope)
  cache_3 = EntityCache.build(subject, scope: scope)

  puts "\nWriting cache record (scope is #{scope})\n\n"

  cache_1.put_record(record)

  puts "\nReading cache (scope is #{scope})\n\n"

  record_1 = cache_1.get(record.id)
  record_2 = cache_2.get(record.id)
  record_3 = nil

  thread = Thread.new do
    record_3 = cache_3.get(record.id)

    sleep
  end

  while record_3.nil? && !thread.stop?
    Thread.pass
  end

  thread.kill

  Thread.pass while thread.alive?
end
