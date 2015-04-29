module CounterCache
  extend ActiveSupport::Concern
  
  included do
    def self.counter_cache(options)

        name = options[:name]
        counter_field = options[:field]

        after_create do |document|
          document.send(name).inc(counter_field, 1)
        end

        after_destroy do |document|
          document.send(name).inc(counter_field, -1) unless document.destroyed?
        end

      end
  end
end
