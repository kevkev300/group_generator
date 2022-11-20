require "group_generator"

RSpec.describe GroupGenerator do
  let(:generator) { described_class.new(names, group_size) }

  describe '#group!' do
    let(:group_method) { generator.group! }
    let(:group_size) { 1 }

    context 'when no names is given' do
      let(:names) { [] }

      it 'returns an error' do
        expect { group_method }.to raise_error(GroupGenerator::NoNamesGivenError)
      end
    end

    context 'when 12 names are given' do
      let(:names) { (1..12).map { |i| "Name#{i}" } }

      context 'when grouping number is 3' do
        let(:group_size) { 3 }

        it 'creates 4 groups each with 3 members and with all names in it' do
          group_method
          groups = generator.groups
          expect(groups.count).to eq(4)
          expect(groups.map(&:count).count(3)).to eq(4)
          expect(groups.flatten.uniq.count).to eq(12)
          names.each do |name|
            expect(groups.flatten.uniq.count(name)).to eq(1)
          end
        end
      end
    end

    context 'when 11 names are given' do
      let(:names) { (1..11).map { |i| "Name#{i}" } }

      context 'when grouping number is 3' do
        let(:group_size) { 3 }

        it 'creates 4 groups each with 3 members and one with 2' do
          group_method
          groups = generator.groups
          expect(groups.count).to eq(4)
          names_count = groups.map(&:count)
          expect(names_count.count(3)).to eq(3)
          expect(names_count.count(2)).to eq(1)
        end
      end
    end
  end
end
