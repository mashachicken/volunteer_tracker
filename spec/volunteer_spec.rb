require('spec_helper')

describe Volunteer do
  describe '#name' do
    it 'returns the name of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.name).to eq 'Jane'
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Volunteer.all).to eq []
    end
  end
  describe '#save' do
    it 'adds a volunteer to the database' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to eq [volunteer1]
    end
  end
end
  # describe('.clear') do
  #   it("clears all volunteers") do
  #     volunteer = Volunteer.new({:name => "Masha", :id => nil})
  #     volunteer.save()
  #     volunteer2 = Volunteer.new({:name => "Another Volunteer", :id => nil})
  #     volunteer2.save()
  #     Volunteer.clear
  #     expect(Volunteer.all).to(eq([]))
  #   end
  # end
  # describe('.find') do
  #   it("finds a volunreer by id") do
  #     volunreer = Volunteer.new({:name => "Maha", :id => nil})
  #     volunreer.save()
  #     volunreer2 = Volunteer.new({:name => "Another Volunteer", :id => nil})
  #     volunreer2.save()
  #     expect(Volunteer.find(volunreer.id)).to(eq(volunreer))
  #   end
  # end
