module Spec2
  class HighRunner
    getter reporter, runner, root
    getter! current_runner
    def initialize(@root)
    end

    def contexts
      [root]
    end

    def configure_reporter(@reporter)
    end

    def configure_runner(@runner)
    end

    def run
      reporter_class = self.reporter
      unless reporter_class
        raise ReporterIsNotConfigured.new(
          "Please configure reporter with Spec2.configure_reporter(reporter)",
        )
      end

      runner_class = self.runner
      unless runner_class
        raise RunnerIsNotConfigured.new(
          "Please configure runner with Spec2.configure_runner(runner)",
        )
      end

      reporter = reporter_class.new
      @current_runner = runner_class.new

      current_runner.run_context(reporter, root)
      reporter.report
    end

    delegate current_context, current_runner
  end
end
