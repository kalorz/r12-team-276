require 'spec_helper'

describe Badge do
  let(:user) { mock :user, username: 'weszlem', xp: 10, level_percentage: 40, level: 4 }
  let(:badge) { described_class.new user }
  subject { badge }

  context 'with user' do
    let(:user) { mock :user, username: 'weszlem', xp: nil }
    subject { described_class.new user }

    its(:xp) { should be_zero }

    context 'first level' do
      it { should be_true }
    end
  end

  context '#get_template' do
    subject { badge.get_template }

    it { should match /html/ }
    it { should match Regexp.new('<%= username %>') }
  end

  context '#get_bindings' do
    let(:binding) { mock(Binding) }
    before { badge.stub! binding: binding }
    subject { badge.get_bindings }

    it { should eq binding }
  end

  context '#apply_data_to_template' do
    subject { badge.apply_data_to_template }

    it { should match /weszlem/ }
  end

  context '#render_to_string' do
    let(:imgkit) { mock(IMGKit) }
    before { IMGKit.stub! new: imgkit }

    context 'with argument' do
      let(:type) { :jpg }
      let(:image) { 'jpg image' }
      before do
        imgkit.should_receive(:to_img).with(:jpg).and_return(image)
      end
      subject { badge.render_to_string type }

      it { should eq image }
    end

    context 'without argument' do
      let(:image) { 'png image' }
      before do
        imgkit.should_receive(:to_img).with(:png).and_return(image)
      end
      subject { badge.render_to_string }

      it { should eq image }
    end
  end

  context '#render' do
    context 'with arguments' do
      subject { badge.render to_file, file_path }
      let(:to_file) { true }
      let(:file_path) { nil }

      it { should be_false }

      context 'with file_path' do
        let(:file_path) { 'path' }

        before do
          badge.should_receive(:render_to_file).with(file_path).and_return(true)
        end

        it { should be_true }
      end

      context 'to_file = false' do
        let(:to_file) { false }

        before do
          badge.should_receive(:render_to_string).and_return(true)
        end

        it { should be_true }
      end
    end

    context 'without arguments' do
      subject { badge.render }


    end

  end
end
