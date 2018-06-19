nm_initSlider = function(sliderID) {
  // Initialize Slick slider,
  // allowing it to work with
  // Turbolinks (Ajax) restoration visits (back/forward browser nav.)


  // Cancel if Slick not detected
  if (!'slick' in jQuery()) return


  // Define variables

  var isFullscreenClass = 'nm-slider-is-fullscreen'
  var fullscreenToggleClass = 'nm-slider-fullscreen-toggle'
  var $slider = jQuery('#' + sliderID)
  if (!window['nm_SlickSlider']) nm_SlickSlider = {} // Persists across Ajax reloads

  // Define functions

  var closeOnEscape = function(event) {
    if (event.key !== 'Escape') return
    removeEscapeListener()
    window[sliderID].parentNode.classList.remove(isFullscreenClass)
    repositionSlider()
  }

  var removeEscapeListener = function() {
    window.removeEventListener('keydown', closeOnEscape)
  }

  var repositionSlider = function() {
    window[sliderID].slick.setPosition()
  }


  // Manage reruns of this script

  // If this script aleady ran for this slider
  if (sliderID in nm_SlickSlider) {
    // Replace the initialized but broken slider with a fresh one
    $slider.replaceWith(nm_SlickSlider[sliderID].html.clone())
    // Reselect the newly replaced slider
    $slider = jQuery('#' + sliderID)
  }
  // If this script has not run yet for this slider
  else {
    nm_SlickSlider[sliderID] = {
      // Remember the uninitialized slider HTML
      html: $slider.clone(),
      // Autoplay this slider when loaded first time
      autoplay: true,
      // Index of slide last used
      index: 0
    }
  }


  // Setup auto-stop of autoplay after one full run or on fullscreen trigger

  var slidesToAutoslide = $slider[0].childElementCount

  var stopSlider = function() {
    $slider
      .slick('slickPause')
      .off('afterChange', autoStopSlider)
    // Prevent autoplay on future Ajax page reloads
    nm_SlickSlider[sliderID].autoplay = false
  }

  var autoStopSlider = function() {
    slidesToAutoslide--
    if (!slidesToAutoslide) stopSlider()
  }


  // Activate fullscreen toggle

  jQuery('.' + fullscreenToggleClass)
    .click(function() {
      // Toggle fullscreen class
      if (this.parentNode.classList.toggle(isFullscreenClass)) {
        // If opened fullscreen
        window.addEventListener('keydown', closeOnEscape)
      }
      else {
        // If closed fullscreen
        removeEscapeListener()
      }
      repositionSlider()
    })
    .click(stopSlider)


  // Initialize the slider

  $slider.slick({
    dots: true, // Dot navigation
    touchThreshold: 15, // Make more sensitive to swipes (default 5)
		autoplay: nm_SlickSlider[sliderID].autoplay, // Autoplay only on first Ajax load
		autoplaySpeed: 6000
  })

  // Add class to classless div that gets created by Slick
  $slider.find('.nm-photo-slider-item').parent().addClass('nm-slick-slide-inner')

  // Show the same slide as before the Ajax page reload
  $slider.slick('slickGoTo', nm_SlickSlider[sliderID].index, true)
    // Remember the current slide to show it after an Ajax page reload
    .on('afterChange', function(event, slick, currentSlide) {
      nm_SlickSlider[sliderID].index = currentSlide
    })
    // Auto-stop autoplay after one complete loop
    .on('afterChange', autoStopSlider)
    // Stop autoplay when manually navigating the slider
    .find('.slick-arrow, .slick-dots button').blur(stopSlider)

}
