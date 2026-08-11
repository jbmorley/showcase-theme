function formatLocal(dt) {
    const date = new Date(dt);
    const base = new Intl.DateTimeFormat(undefined, {
        year: 'numeric', month: 'short', day: 'numeric',
        hour: 'numeric', minute: '2-digit'
    }).format(date);
    const zone = new Intl.DateTimeFormat('en-US', {
        timeZoneName: 'short'
    }).formatToParts(date).find(p => p.type === 'timeZoneName').value;
    return `${base} ${zone}`;
}

class LocalTime extends HTMLTimeElement {
    connectedCallback() {
        const date = new Date(this.dateTime);
        const textContent = formatLocal(date);
        this.textContent = textContent;
    }
}

customElements.define('local-time', LocalTime, { extends: 'time' });

// Check if the browser correctly promotes `is=`.
const supportsCustomizedBuiltins =
    document.createElement('time', { is: 'local-time' }) instanceof LocalTime;

if (!supportsCustomizedBuiltins) {
    function upgrade(el) {
        if (el.dataset.localized) return;
        el.dataset.localized = 'true';
        el.textContent = formatLocal(el.dateTime);
    }

    document.querySelectorAll('time[datetime]').forEach(upgrade);

    new MutationObserver(mutations => {
        for (const m of mutations) {
            for (const node of m.addedNodes) {
                if (node.nodeType !== 1) continue;
                if (node.matches?.('time[datetime]')) upgrade(node);
                node.querySelectorAll?.('time[datetime]').forEach(upgrade);
            }
            if (m.type === 'attributes' && m.target.matches('time[datetime]')) {
                delete m.target.dataset.localized;
                upgrade(m.target);
            }
        }
    }).observe(document.body, {
        childList: true,
        subtree: true,
        attributes: true,
        attributeFilter: ['datetime']
    });
}
