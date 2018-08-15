require 'spec_helper'

describe ActAsTimeAsBoolean do
  it 'defines time_as_boolean class method' do
    Article.singleton_methods.should include(:time_as_boolean)
  end

  describe 'calling time_as_boolean' do
    describe 'without param' do
      it 'raises an ArgumentError' do
        expect do
          class Article < ActiveRecord::Base
            include ActAsTimeAsBoolean

            time_as_boolean
          end
        end.to raise_error(ArgumentError)
      end
    end

    describe 'with :active param' do
      subject { Article.new.methods }

      it 'defines active method' do
        subject.should include(:active)
      end
      it 'defines active? method' do
        subject.should include(:active?)
      end
      it 'defines active= method' do
        subject.should include(:active=)
      end
      it 'defines active! method' do
        subject.should include(:active!)
      end
    end

    describe 'with :active and opposite param' do
      subject { ArticleWithOpposite.new.methods }

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
      it 'defines inactive! method' do
        subject.should include(:inactive!)
      end
    end

    describe 'scopes' do
      describe 'with :active param' do
        subject { Article }

        it 'define active scope' do
          subject.methods.should include(:active)
        end
      end

      describe 'with :active param and scope: false' do
        subject { ArticleWithScopeFalse }

        it 'define active scope' do
          subject.methods.should_not include(:active)
        end
      end

      describe 'with :active param and scope: :reactive' do
        subject { ArticleWithScope }

        it 'define active scope' do
          subject.methods.should include(:reactive)
        end
      end

      describe 'with :active and opposite param' do
        subject { ArticleWithOpposite }

        it 'define active scope' do
          subject.methods.should include(:active)
        end

        it 'define inactive scope' do
          subject.methods.should include(:inactive)
        end
      end
    end
  end

  describe 'using ActAsTimeAsBoolean' do
    describe 'with an active instance' do
      let(:time) { Time.now }
      subject { ArticleWithOpposite.new active_at: time }

      describe 'calling active' do
        it { subject.active.should be true }
      end

      describe 'calling active?' do
        it { subject.active?.should be true }
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
        it { subject.inactive.should be false }
      end

      describe 'calling inactive?' do
        it { subject.inactive?.should be false }
      end

      describe 'calling active!' do
        before { subject.active! }

        it { subject.active?.should be true }
      end

      describe 'calling inactive!' do
        before { subject.inactive! }

        it { subject.active?.should be false }
      end
    end

    describe 'with an inactive instance' do
      subject { ArticleWithOpposite.new }

      describe 'calling active' do
        it { subject.active.should be false }
      end

      describe 'calling active?' do
        it { subject.active?.should be false }
      end

      describe 'calling active=' do
        [true, '1'].each do |value|
          describe "with #{value}" do
            before { subject.active = value }

            it { subject.active_at.class.should == ActiveSupport::TimeWithZone }
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
        it { subject.inactive.should be true }
      end

      describe 'calling inactive?' do
        it { subject.inactive?.should be true }
      end

      describe 'calling active!' do
        before { subject.active! }

        it { subject.active?.should be true }
      end

      describe 'calling inactive!' do
        before { subject.inactive! }

        it { subject.active?.should be false }
      end
    end
  end
end
