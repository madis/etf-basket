require File.expand_path('config/environment.rb')

class Data < Thor
  desc 'import_etf SYMBOL NAME DATA_FILE', 'Import ETF constituents'
  def import_etf(symbol, name, data_file)
    puts "Creating new ETF with symbol=#{symbol} name=#{name} data from '#{data_file}'"
    constituents_before = EtfConstituent.count

    Etf.transaction do
      etf = Etf.create(name: name, symbol: symbol)
      constituents = YAML.load(File.read(data_file))
      puts "There were #{constituents.count} constituents in data file"

      constituents.each do |c|
        print '.'
        weight = parse_weight_string(c[:weight])
        constituent = etf.constituents.create(name: c[:company], symbol: c[:symbol], weight: weight)
        price = constituent.prices.create(amount: c[:price], currency: 'USD')
      end
    end
    puts "\nDone!"
    puts "Imported #{EtfConstituent.count - constituents_before} new etf constituents"
  end

  desc 'drop_etf SYMBOL', 'Drop ETF with given symbol along with its constituents and prices'
  def drop_etf(symbol)
    puts "Deleting #{symbol}"
    Etf.find_by(symbol: symbol).destroy
    puts "Done"
  end

  private

  def parse_weight_string(weight_string)
    if weight_string.end_with?('%')
      Float(weight_string[0..-2]) / 100
    elsif Float(weight_string) > 1
      Float(weight) / 100
    else
      Float(weight)
    end
  end
end
