class User
    attr_reader :age, :sex, :nationality

    def initialize(age:, sex:, nationality:)
        @age = age
        @sex = sex
        @nationality = nationality
    end
end