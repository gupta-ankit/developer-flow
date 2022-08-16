require 'csv'
require './to_csv'

have = 'LanguageHaveWorkedWith'
want = 'LanguageWantToWorkWith'

want_count = Hash.new(0)
love_count = Hash.new(0)
hate_count = Hash.new(0)

langs = Hash.new do |hash, key|
   hash[key] = {love: 0, hate: 0, want: 0}
end

CSV.read("data/#{ENV['YEAR']}/survey_results_public.csv", headers: true).each do |row|
  next if row['MainBranch'] != 'I am a developer by profession'
  have_langs = row[have].split(";")
  want_langs = row[want].split(";")

  have_langs.each do |hl|
    if want_langs.include? hl || want_langs[0] == "NA"
      langs[hl][:love] += 1
    else
      langs[hl][:hate] += 1
    end
  end

  want_langs.each do |wl|
    langs[wl][:want] += 1
  end
end

langs.each do |l, vals|
  total = vals[:love] + vals[:hate]
  vals[:"love%"] = ((vals[:love] * 100 ) / total.to_f).round(2)
  vals[:"hate%"] = ((vals[:hate] * 100) / total.to_f).round(2)
end

puts "#{ENV['YEAR']}"
to_csv(langs)
