require 'csv'
require './to_csv'
require 'byebug'

#this is to find what the haters of a language want to work with next?
have = 'LanguageHaveWorkedWith'
want = 'LanguageWantToWorkWith'


lang = ENV['LANGUAGE']
source_langs = Hash.new(0)
newcomers = 0
users = 0

CSV.read("data/#{ENV['YEAR']}/survey_results_public.csv", headers: true).each do |row|
  next if row['MainBranch'] != 'I am a developer by profession'
    
  have_langs = row[have].split(";")
  want_langs = row[want].split(";")
  users += 1

  if (want_langs.include?(lang) && !(have_langs.include? lang))
   newcomers += 1
   have_langs.each do |hl|
    source_langs[hl] += 1
   end
  end
end

puts "#{(newcomers*100)/users.to_f}% developers (#{newcomers}/#{users}) would like to use #{lang}"
puts "Source"
to_csv(source_langs.sort_by{|k,v| -v}.first(10).map{|lang, count| [lang, {count: count, "%": (count*100/newcomers.to_f).round(2)}]})

