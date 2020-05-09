class User
    attr_reader :age, :sex, :nationality

    def initialize(age:, sex:, nationality:)
        require 'pry'; binding.pry
        @age = age
        @sex = sex
        @nationality = nationality
    end
end