require File.expand_path('config/environment.rb')

class Data < Thor
  desc 'import_etf SYMBOL NAME DATA_FILE', 'Import ETF constituents'
  def import_etf(symbol, name, data_file)
    puts "Creating new ETF with symbol=#{symbol} name=#{name} data from '#{data_file}'"

    etf = Etf.create(name: name, symbol: symbol)
    constituents = YAML.load(File.read(data_file))
    puts "There were #{constituents.count} constituents in data file"
    constituents_before = EtfConstituent.count

    constituents.each do |c|
      print '.'
      constituent = etf.constituents.create(name: c[:company], symbol: c[:symbol], weight: c[:weight])
      price = constituent.prices.create(amount: c[:price], currency: 'USD')
    end
    puts "\nDone!"
    puts "#{}"
  end

  desc 'drop_etf SYMBOL', 'Drop ETF with given symbol along with its constituents and prices'
  def drop_etf(symbol)
    puts "Deleting #{symbol}"
    Etf.find_by(symbol: symbol).destroy
    puts "Done"
  end
end
