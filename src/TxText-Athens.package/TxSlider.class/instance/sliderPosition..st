accessing
sliderPosition: newValue

	sliderPosition := newValue min: 1.0 max: 0.0.
	
	self computeSliderBounds.
	self changed