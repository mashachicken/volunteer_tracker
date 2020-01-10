require('spec_helper')

describe('.all') do
  it("returns an empty array when there are no volunteers") do
    expect(Volunteer.all).to(eq([]))
  end
end

describe('#save') do
  it("saves a volunteer") do
    volunteer = Volunteer.new({:name => "Masha", :id => nil})
    volunteer.save()
    volunteer2 = Volunteer.new({:name => "Another Volunteer", :id => nil})
    volunteer2.save()
    expect(Volunteer.all).to(eq([volunteer, volunteer2]))
  end
  describe('.clear') do
  it("clears all volunteers") do
    volunteer = Volunteer.new({:name => "Masha", :id => nil})
    volunteer.save()
    volunteer2 = Volunteer.new({:name => "Another Volunteer", :id => nil})
    volunteer2.save()
    Volunteer.clear
    expect(Volunteer.all).to(eq([]))
  end
end
describe('.find') do
  it("finds a volunreer by id") do
    volunreer = Volunteer.new({:name => "Maha", :id => nil})
    volunreer.save()
    volunreer2 = Volunteer.new({:name => "Another Volunteer", :id => nil})
    volunreer2.save()
    expect(Volunteer.find(volunreer.id)).to(eq(volunreer))
  end
end
end
