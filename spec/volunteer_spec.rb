require('spec_helper')

describe('.all') do
  it("returns an empty array when there are no volunteers") do
    expect(Volunteer.all).to(eq([]))
  end
end
