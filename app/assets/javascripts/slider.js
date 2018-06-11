nm_initSlider = function(sliderID) {
  // Initialize Slick slider,
  // allowing it to work with
  // Turbolinks (Ajax) restoration visits (back/forward browser nav.)


  // Cancel if Slick not detected
  if (!'slick' in jQuery()) return


  // Define variables

  var isFullscreenClass = 'nm-slider-is-fullscreen'
  var toggleClass = 'nm-slider-fullscreen-toggle'
  var $slider = jQuery('#' + sliderID)
  if (!window['nm_SlickSlider']) nm_SlickSlider = {} // Persists across Ajax reloads

  // Define functions

  var closeOnEscape = function(event) {
    if (event.key !== 'Escape') return
    removeEscapeListener()
    window[sliderID].parentNode.classList.remove(isFullscreenClass)
    refreshSlider()
  }

  var removeEscapeListener = function() {
    window.removeEventListener('keydown', closeOnEscape)
  }

  var refreshSlider = function() {
    window[sliderID].slick.refresh()
  }


  // Manage reruns of this script

  // If this script aleady ran for this slider
  if (sliderID in nm_SlickSlider) {
    // Replace the initialized but broken slider with a fresh one
    $slider.replaceWith(nm_SlickSlider[sliderID].clone())
    // Reselect the newly replaced slider
    $slider = jQuery('#' + sliderID)
  }
  // If this script has not run yet for this slider
  else {
    // Remember the uninitialized slider HTML
    nm_SlickSlider[sliderID] = $slider.clone()
  }


  // Activate fullscreen toggle

  jQuery('.' + toggleClass).click(function() {
    // Toggle fullscreen class
    if (this.parentNode.classList.toggle(isFullscreenClass)) {
      // If opened fullscreen
      window.addEventListener('keydown', closeOnEscape)
    }
    else {
      // If closed fullscreen
      removeEscapeListener()
    }
    refreshSlider()
  })


  // Initialize the slider
  $slider.slick()
}
