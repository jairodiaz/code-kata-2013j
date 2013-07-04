module SimpleImageEditor
  class ExitCommand < Command
    define_key 'X'
    def transform(image=nil, args=nil)
      nil
    end
  end

  SimpleImageEditor::CommandRunner.add_command ExitCommand
end
