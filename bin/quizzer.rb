#!/usr/bin/env ruby

require 'quizzer'
require 'slop'

quizzer = Quizzer::Quizzer.new

opts = Slop.new help: true do
  banner 'Usage: quizzer [options]'

  on :q=, 'URL to the questions file'
  on :a=, 'URL to the answers file'
  on :o=, 'Generate output in the specified format (json or xml)'
  on :t=, 'Validate assessments in tests file'
  on :s, 'Show questions statistics'
end

begin
  opts.parse

  if ARGV.length == 0
    quizzer.server_mode
  elsif opts[:t]
    valid = quizzer.validate_assessments(opts[:t])
    puts valid ? 'All tests OK' : 'Tests failed'
  elsif opts[:a] && opts[:q]
    assessment = quizzer.calculate_grades(opts[:q], opts[:a])

    format = opts[:o] ? opts[:o] : 'json'

    quizzer.show_grades(assessment.grades, format)

    if opts[:s]
      quizzer.show_statistics(assessment.get_statistics, format)
    end
  elsif
    puts opts
  end
rescue Slop::Error => e
  puts e.message
  puts opts
end