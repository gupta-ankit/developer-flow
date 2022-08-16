require 'csv'
require './to_csv'

#this is to find what the haters of a language want to work with next?
have = 'LanguageHaveWorkedWith'
want = 'LanguageWantToWorkWith'


lang = ENV['LANGUAGE']
replace = Hash.new(0)
haters = 0
users = 0

CSV.read("data/#{ENV['YEAR']}/survey_results_public.csv", headers: true).each do |row|
  next if row['MainBranch'] != 'I am a developer by profession'
    
  have_langs = row[have].split(";")
  want_langs = row[want].split(";")

  if (have_langs.include? lang)
   users += 1
   if row[want] != "NA" && !(want_langs.include? lang)
     haters += 1
     (want_langs - have_langs).each do |wl|
       replace[wl] += 1
     end
   end
  end
end

puts "#{(haters*100)/users.to_f}% developers (#{haters}/#{users}) want to no longer use #{lang}"
puts "Potential Replacements"
to_csv(replace.sort_by{|k,v| -v}.first(10).map{|lang, count| [lang, {count: count, "%": (count*100/users.to_f).round(2)}]})

