module Dbchecker
  module DSL

    def check_nil(*fields)
      raise 'Empty fields' if fields.empty?
      res = []

      fields.each do |field|
        bad = table.select(:id).where(field => nil)
        total = bad.map(&:id)

        unless total.empty?
          self.log "There are #{total.size} invalid rows in #{table} because #{field} is nil"
          self.log "IDs: #{total}"
        end
        res.push total
      end

      res
    end

    def check_references(*fields)
      raise 'Empty fields' if fields.empty?
      res = []

      fields.each do |field|
        field_name = "#{field}_id"
        references = table.select(:id).all.map{|r| r.id }
        from = field.to_s.classify.constantize
        all = from.select(:id).all.map(&:id)
        total = references - all

        if total.size > 0
          self.log "There are #{total.size} invalid rows in #{table} because #{field_name} is not existant"
          self.log "IDs: #{total}"
        end
        res.push total
      end

      res
    end

    def check_negatives(*fields)
      raise 'Empty fields' if fields.empty?
      res = []

      fields.each do |field|
        total = table.select(:id).where("#{field} < 0")
        if total.size > 0
          self.log "There are #{total.size} invalid rows in #{table} because #{field} is negative"
          self.log "IDs: #{total}"
        end
        res.push total
      end

      res
    end

    def check_zero(*fields)
      raise 'Empty fields' if fields.empty?
      res = []

      fields.each do |field|
        total = table.select(:id).where("#{field} = 0")
        if total.size > 0
          self.log "There are #{total.size} invalid rows in #{table} because #{field} is zero"
          self.log "IDs: #{total}"
        end
        res.push total
      end

      res
    end

    def check_equal(*fields)
      raise 'Empty fields' if fields.empty?
      raise 'Two fields required' if fields.size != 2
      first_field, second_field = fields[0], fields[1]

      total = table.select(:id).where("#{first_field} = #{second_field}")
      if total.size > 0
        self.log "There are #{total.size} invalid rows in #{table} because #{first_field} and #{second_field} are equal"
        self.log "IDs: #{total}"
      end

      total.map(&:id)
    end

    def check_duplicates(*fields)
      raise 'Empty fields' if fields.empty?
      fields_str = fields.join(', ')

      total = table.select(:id).group("#{fields_str}").having("COUNT(id) > ?", 1)
      unless total.empty?
        self.log "There are #{total.size} invalid rows in #{table} because #{fields_str} are duplicated"
        self.log "IDs: #{total}"
      end

      total.map(&:id)
    end

    def log(msg)
      puts msg unless Rails.env.test?
    end

  end
end
