// Provide minimal fallbacks for older/HTTP-only browsers.
(function () {
    if (typeof window === "undefined") {
        return;
    }

    // Ensure window.crypto exists (older browsers expose msCrypto)
    if (!window.crypto) {
        window.crypto = window.msCrypto || {};
    }

    // Polyfill crypto.randomUUID when missing (e.g., non-secure context)
    if (window.crypto && typeof window.crypto.randomUUID !== "function") {
        window.crypto.randomUUID = function () {
            // RFC4122 version 4 compliant-ish UUID generator
            return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function (c) {
                const r = (window.crypto.getRandomValues
                    ? window.crypto.getRandomValues(new Uint8Array(1))[0] & 15
                    : Math.floor(Math.random() * 16)) | 0;
                const v = c === "x" ? r : (r & 0x3) | 0x8;
                return v.toString(16);
            });
        };
    }
})();

