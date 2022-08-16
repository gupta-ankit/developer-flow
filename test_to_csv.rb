require './to_csv'

def test_csv_generation
  lang_hash = {
    "ruby" => {love: 1, hate: 1, want: 2},
    "c++" => {love: 1, hate: 10, want: 10}
  }
  to_csv(lang_hash)
end

test_csv_generation
