require_relative './interactive_init'

[:exclusive, :shared].each do |scope|

  subject = Controls::Subject.example(random: true)

  record = Controls::Record.example

  cache1 = EntityCache.build(subject, scope: scope)
  cache2 = EntityCache.build(subject, scope: scope)
  cache3 = nil

  thread = Thread.new do
    cache3 = EntityCache.build(subject, scope: scope)

    sleep
  end

  while cache3.nil? && !thread.stop?
    Thread.pass
  end

  puts "\nWriting cache record (scope is #{scope})\n\n"

  cache1.put_record(record)

  puts "\nReading cache (scope is #{scope})\n\n"

  cache1.get(record.id)
  cache2.get(record.id)
  cache3.get(record.id)

  thread.kill

  Thread.pass while thread.alive?
end
