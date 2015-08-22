module DummyMovesMapper
  class SummariesRepository
    def initialize(client)
      @client = client
    end

    def find_by_date(date)
      get_summaries(date: parse_day(date))
    end

    def find_by_week(date)
      get_summaries(date: parse_week(date))
    end

    def find_by_month(date)
      get_summaries(date: parse_month(date))
    end

    def find_by_date_range(start_date, end_date)
      get_summaries(from: parse_day(start_date), to: parse_day(end_date))
    end

    def find_by_past_days(days)
      get_summaries(pastDays: days)
    end

    private

    def get_summaries(options)
      @client.get(uri_template.expand(options))
    end

    def uri_template
      Addressable::Template.new("user/summary/daily{/date}{?from,to,pastDays,updatedSince,timeZone}")
    end

    def parse_month(date)
      date.strftime("%Y%m")
    end

    def parse_week(date)
      date.strftime("%Y-W%W")
    end

    def parse_day(date)
      date.strftime("%Y%m%d")
    end
  end
end
