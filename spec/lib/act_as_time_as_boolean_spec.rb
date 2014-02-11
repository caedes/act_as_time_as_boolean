require_relative '../spec_helper'

class SimpleTimeAsBooleanModel
  include ActAsTimeAsBoolean

  attr_accessor :active_at

  time_as_boolean :active
end

class TimeAsBooleanWithOppositeModel
  include ActAsTimeAsBoolean

  attr_accessor :active_at

  def initialize(options = {})
    @active_at = options[:active_at] || nil
  end

  time_as_boolean :active, opposite: :inactive
end

# Awesome mock to test scope
class ActiveRecord
end

class ActiveRecord::Base
  def self.scope(name, body, &block)
    define_singleton_method name do
      # Nothing to do here, just a mock
    end
  end

  def save!
  end
end

class InheritedModel < ActiveRecord::Base
  include ActAsTimeAsBoolean

  attr_accessor :active_at

  time_as_boolean :active
end

class InheritedModelWithOpposite < ActiveRecord::Base
  include ActAsTimeAsBoolean

  attr_accessor :active_at

  time_as_boolean :active, opposite: :inactive
end

describe ActAsTimeAsBoolean do
  it 'defines time_as_boolean class method' do
    SimpleTimeAsBooleanModel.singleton_methods.should include(:time_as_boolean)
  end

  describe 'calling time_as_boolean' do
    describe 'without param' do
      it 'raises an ArgumentError' do
        expect do
          class NoParamTimeAsBooleanModel
            include ActAsTimeAsBoolean

            time_as_boolean
          end
        end.to raise_error(ArgumentError)
      end
    end

    describe 'with :active param' do
      subject { SimpleTimeAsBooleanModel.new.methods }

      it 'defines active method' do
        subject.should include(:active)
      end
      it 'defines active? method' do
        subject.should include(:active?)
      end
      it 'defines active= method' do
        subject.should include(:active=)
      end
    end

    describe 'with :active and opposite param' do
      subject { TimeAsBooleanWithOppositeModel.new.methods }

      it 'defines active method' do
        subject.should include(:active)
      end
      it 'defines active? method' do
        subject.should include(:active?)
      end
      it 'defines active= method' do
        subject.should include(:active=)
      end
      it 'defines inactive method' do
        subject.should include(:inactive)
      end
      it 'defines inactive? method' do
        subject.should include(:inactive?)
      end
    end

    describe 'on a rails app' do
      describe 'with :active param' do
        subject { InheritedModel.new }

        it 'define active scope' do
          subject.class.methods.should include(:active)
        end

        it 'defines active! method' do
          subject.methods.should include(:active!)
        end
      end

      describe 'with :active and opposite param' do
        subject { InheritedModelWithOpposite.new }

        it 'define active scope' do
          subject.class.methods.should include(:active)
        end

        it 'define inactive scope' do
          subject.class.methods.should include(:inactive)
        end

        it 'defines inactive! method' do
          subject.methods.should include(:inactive!)
        end
      end
    end
  end

  describe 'using ActAsTimeAsBoolean' do
    describe 'with an active instance' do
      let(:time) { Time.now }
      subject { TimeAsBooleanWithOppositeModel.new active_at: time }

      describe 'calling active' do
        it { subject.active.should be_true }
      end

      describe 'calling active?' do
        it { subject.active?.should be_true }
      end

      describe 'calling active=' do
        describe 'with true' do
          before { subject.active = true }

          it { subject.active_at.should == time }
        end

        describe 'with false' do
          before { subject.active = false }

          it { subject.active_at.should be_nil }
        end

        describe "with '1'" do
          before { subject.active = '1' }

          it { subject.active_at.should == time }
        end

        describe "with '0'" do
          before { subject.active = '0' }

          it { subject.active_at.should be_nil }
        end
      end

      describe 'calling inactive' do
        it { subject.inactive.should be_false }
      end

      describe 'calling inactive?' do
        it { subject.inactive?.should be_false }
      end
    end

    describe 'with an inactive instance' do
      subject { TimeAsBooleanWithOppositeModel.new }

      describe 'calling active' do
        it { subject.active.should be_false }
      end

      describe 'calling active?' do
        it { subject.active?.should be_false }
      end

      describe 'calling active=' do
        [true, '1'].each do |value|
          describe "with #{value}" do
            before { subject.active = value }

            it { subject.active_at.class.should == Time }
          end
        end

        [false, '0'].each do |value|
          describe "with #{value}" do
            before { subject.active = value }

            it { subject.active_at.should be_nil }
          end
        end
      end

      describe 'calling inactive' do
        it { subject.inactive.should be_true }
      end

      describe 'calling inactive?' do
        it { subject.inactive?.should be_true }
      end
    end

    describe 'with an ActiveRecord inherited instance' do
      subject { InheritedModel.new }

      describe 'calling active!' do
        before { subject.active! }

        it { subject.active?.should be_true }
      end
    end

    describe 'with an ActiveRecord inherited with opposite instance' do
      subject { InheritedModelWithOpposite.new }

      describe 'calling active!' do
        before { subject.active! }

        it { subject.active?.should be_true }
      end

      describe 'calling inactive!' do
        before { subject.inactive! }

        it { subject.active?.should be_false }
      end
    end
  end
end
