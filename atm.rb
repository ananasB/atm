require_relative( './lib/atm')
require 'yaml'

config = YAML.load_file(ARGV.first || 'config.yml')

atm = Atm.new(config)
atm.start