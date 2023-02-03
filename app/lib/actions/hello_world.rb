module Actions
  class HelloWorld < ::Dynflow::Action
    def plan(who)
      plan_self who: who
    end

    def run
      puts "Hello #{input[:who]}"
    end
  end
end