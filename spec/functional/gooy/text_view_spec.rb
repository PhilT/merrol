module Gooy
  describe TextView do
    subject { TextView.new 'source' }
    it { subject.object.must_be_instance_of Gtk::SourceView }


    it 'sets the style scheme of the source buffer' do
      subject.theme_path 'lib/merrol/config/styles'
      subject.theme 'railscastsimp'
      subject.object.buffer.style_scheme.id.must_equal 'railscastsimp'
    end
  end
end

