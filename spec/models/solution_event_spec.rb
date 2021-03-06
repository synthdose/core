# == Schema Information
#
# Table name: solution_events
#
#  id          :integer          not null, primary key
#  solution_id :integer          not null
#  type        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_solution_events_on_solution_id  (solution_id)
#  index_solution_events_on_type         (type)
#

require 'spec_helper'

describe SolutionEvent do
  
  let!(:solution) { create :solution }
  
  it "should require a solution" do
    event = SolutionEvent::Started.create()
    event.errors.should have_key :solution
  end

  it "should require a type" do
    event = SolutionEvent.create(solution: solution)
    event.errors.should have_key :type
  end

  describe "started" do

    let(:event) { create(:started_event, solution: solution) }

    it "should be able to be added to Solution's events" do

      lambda {
        solution.solution_events << event
      }
      .should change(solution.solution_events, :count).by(1)
    end
  end

end
