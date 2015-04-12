require 'sensu-plugin/check/cli'
require 'sensu-plugin/metric/cli'

module Metric
  require 'socket'

  class Graphite < Sensu::Plugin::Metric::CLI::Graphite
    def prefix
      @prefix ||= parse_prefix
    end

    private

    # TODO: allow metrics to extend
    def parse_prefix
      hostname = Socket.gethostname
      underscores = hostname.gsub('.', '_')

      config[:prefix].gsub(/%[hH]/, '%H' => hostname,
                                    '%h' => underscores)
    end
  end
end

class Check < Sensu::Plugin::Check::CLI
end
