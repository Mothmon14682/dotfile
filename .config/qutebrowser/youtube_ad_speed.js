(() => {
    function isAdPlaying() {
        return document.querySelector('.ad-showing') !== null;
    }

    function trySkipAd() {
        const skipButton = document.querySelector('.ytp-skip-ad-button');
        if (skipButton && skipButton.offsetParent !== null && !skipButton.disabled) {
            skipButton.click();
            return true;
        }
        return false;
    }

    function updateSpeed() {
        const video = document.querySelector('video');
        if (!video) return;

        if (isAdPlaying()) {
            video.muted = true;
            video.currentTime = video.duration - 1;
        }    
    }

    const intervalId = setInterval(() => {
        if (document.querySelector('video')) {
            updateSpeed();
            trySkipAd()
        }
    }, 200);
})();

