def to_csv(lang_hash, sort_key=nil)
  headers = lang_hash.to_a[0][1].keys
  format = "%-14s" + "\t%s"*headers.size
  puts format % ["lang", *headers]
  lang_hash.each do |lang, vals|
    puts format % [lang, *(vals.values)]
  end
end
