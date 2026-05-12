// Session timeout warning
(function() {
    const SESSION_TIMEOUT_MINUTES = 10;
    const WARNING_BEFORE_MINUTES = 2; // Warn 2 minutes before timeout
    const CHECK_INTERVAL_SECONDS = 30; // Check every 30 seconds
    
    let lastActivity = Date.now();
    let warningShown = false;
    
    // Track user activity
    const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
    events.forEach(event => {
        document.addEventListener(event, () => {
            lastActivity = Date.now();
            if (warningShown) {
                hideWarning();
            }
        }, true);
    });
    
    function showWarning() {
        if (warningShown) return;
        warningShown = true;
        
        const modal = document.createElement('div');
        modal.className = 'modal fade show';
        modal.style.display = 'block';
        modal.style.backgroundColor = 'rgba(0,0,0,0.5)';
        modal.innerHTML = `
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Session Timeout Warning</h5>
                    </div>
                    <div class="modal-body">
                        <p>Your session will expire in ${WARNING_BEFORE_MINUTES} minutes due to inactivity.</p>
                        <p>Click "Stay Logged In" to continue your session.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="extendSession()">Stay Logged In</button>
                        <a href="/Account/Logout" class="btn btn-secondary">Logout</a>
                    </div>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    }
    
    function hideWarning() {
        warningShown = false;
        const modal = document.querySelector('.modal.show');
        if (modal) {
            modal.remove();
        }
    }
    
    window.extendSession = function() {
        lastActivity = Date.now();
        hideWarning();
        // Optionally ping the server to extend session
        fetch('/Account/KeepAlive', { method: 'POST' }).catch(() => {});
    };
    
    // Check for timeout
    setInterval(() => {
        const inactiveMinutes = (Date.now() - lastActivity) / 1000 / 60;
        const timeUntilTimeout = SESSION_TIMEOUT_MINUTES - inactiveMinutes;
        
        if (timeUntilTimeout <= WARNING_BEFORE_MINUTES && timeUntilTimeout > 0 && !warningShown) {
            showWarning();
        } else if (inactiveMinutes >= SESSION_TIMEOUT_MINUTES) {
            window.location.href = '/Account/Logout';
        }
    }, CHECK_INTERVAL_SECONDS * 1000);
})();

