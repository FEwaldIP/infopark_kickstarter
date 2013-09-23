require 'spec_helper'

describe AccordionWidget do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe '#valid_widget_classes_for' do
    it 'should allow only panels for :panels' do
      valid_widget_classes = subject.valid_widget_classes_for('panels')

      expect(valid_widget_classes).to be_an(Array)
      expect(valid_widget_classes).to have(1).item
      expect(valid_widget_classes).to include('AccordionPanelWidget')
    end
  end
end