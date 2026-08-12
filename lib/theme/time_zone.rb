require "date"
require "time"

module Jekyll
  module TimeZoneFilter

    DEFAULT_TIME_ZONE = "UTC".freeze

    def with_time_zone(input, time_zone)
      time = time_zone_parse(input)
      return input if time.nil?
      zone = time_zone.to_s.strip
      zone = DEFAULT_TIME_ZONE if zone.empty?
      time_zone_apply(zone) { time.getutc.localtime }
    end

    private

    def time_zone_parse(input)
      case input
      when Time then input
      when DateTime then input.to_time
      when Date then time_zone_apply(DEFAULT_TIME_ZONE) { input.to_time }
      when String
        return nil if input.strip.empty?
        begin
          if Date._parse(input)[:offset].nil?
            time_zone_apply(DEFAULT_TIME_ZONE) { Time.parse(input) }
          else
            Time.parse(input)
          end
        rescue ArgumentError
          nil
        end
      end
    end

    def time_zone_apply(time_zone)
      original = ENV["TZ"]
      Jekyll.set_timezone(time_zone)
      yield
    ensure
      ENV["TZ"] = original
    end

  end
end

Liquid::Template.register_filter(Jekyll::TimeZoneFilter)
