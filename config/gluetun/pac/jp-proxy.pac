// PAC for the Japan HTTP proxy (gluetun-jp, 127.0.0.1:18888).
// Hosts in proxiedDomains (ChatGPT/OpenAI, Claude/Anthropic and their support
// services) go through the proxy; everything else uses the normal connection.
//
// There is intentionally no DIRECT fallback for the proxied domains:
// if gluetun-jp is stopped, matching requests fail rather than bypass the VPN,
// provided the client honors the system PAC configuration.

function isDomainOrSubdomain(host, domain) {
    return host === domain || dnsDomainIs(host, "." + domain);
}

function FindProxyForURL(url, host) {
    host = host.toLowerCase();

    var proxiedDomains = [
        // ChatGPT / OpenAI core services and content.
        "chatgpt.com",
        "openai.com",
        "chat.openai.com",
        "auth.openai.com",
        "auth0.openai.com",
        "setup.auth.openai.com",
        "desktop.chat.openai.com",
        "ws.chatgpt.com",
        "android.chat.openai.com",
        "ios.chat.openai.com",
        "oaiusercontent.com",
        "oaistatic.com",
        "oaistatsig.com",
        "openaimerge.com",
        "cdn.openaimerge.com",
        "forwarder.workos.com",
        "workos.imgix.net",
        "cdn.workos.com",
        "images.workoscdn.com",
        "challenges.cloudflare.com",

        // Claude / Anthropic services.
        "claude.ai",
        "anthropic.com",
        "api.anthropic.com",
        "statsig.anthropic.com",
        // Claude Code log intake (Datadog), observed in the gluetun-jp log.
        "http-intake.logs.us5.datadoghq.com",

        // Error reporting used by the services.
        "sentry.io"
    ];

    for (var i = 0; i < proxiedDomains.length; i++) {
        if (isDomainOrSubdomain(host, proxiedDomains[i])) {
            return "PROXY 127.0.0.1:18888";
        }
    }

    return "DIRECT";
}
