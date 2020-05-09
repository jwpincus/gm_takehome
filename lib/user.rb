class User
    attr_reader :age, :sex, :nationality

    def initialize(age:, sex:, nationality:)
        @age = age
        @sex = sex
        @nationality = nationality
    end


    def context
        self.instance_variables.map do |attribute|
        [ attribute, self.instance_variable_get(attribute) ]
        end.to_h
    end

end