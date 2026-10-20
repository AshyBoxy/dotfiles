// ==UserScript==
// @name    Tab Group Colors
// ==/UserScript==

// import * as sUtil from "chrome://userchromejs/content/utils.sys.mjs";
import { Observers } from "resource://services-common/observers.sys.mjs";

const addColors = [
    "test",
    "test2"
];
const _debug = true;

const observeTopic = "browser-delayed-startup-finished";
/** @type string[] */
let firstColors;


function log(...message) {
    console.log("tab group colors:", ...message);
}

function debug(...message) {
    if (!_debug) return;
    log(...message);
}


log("loaded");

Observers.add(observeTopic, (subject, data) => {
    debug(`got ${observeTopic}:`, { subject, data });

    /** @type Document */
    const document = subject.document;
    const customElements = subject.customElements;
    const tabGroupMenu = customElements.get("tabgroup-menu");
    debug(tabGroupMenu);

    let first = false;
    if (!firstColors) {
        firstColors = tabGroupMenu.COLORS;
        debug("found first colors:", firstColors);
        first = true;
    }

    if (document.documentElement.style.getPropertyValue("--tab-group-colors-vanilla-count") === "")
        document.documentElement.style.setProperty("--tab-group-colors-vanilla-count", firstColors.length.toString());

    if (tabGroupMenu.COLORS.toString() === firstColors.toString()) {
        // probably a second window
        if (!first) debug("colors is not changed on non first run?");

        tabGroupMenu.COLORS = [...tabGroupMenu.COLORS, ...addColors];
        debug("set colors to:", tabGroupMenu.COLORS);
    } else {
        debug("already modified");
    }

    let tabGroupMenus = document.getElementsByTagName("tabgroup-menu");
    if (tabGroupMenus.length > 0) {
        debug("reintializing existing tab group menus");
        for (let i = 0; i < tabGroupMenus.length; i++) {
            const menu = tabGroupMenus[i];
            if (menu.___tabGroupColorsModified) {
                debug(`already reinitialized menu ${i}`);
                continue;
            }
            menu.___tabGroupColorsModified = true;

            debug(`reinitializing menu ${i}`);
            menu._initialized = false;

            /*            menu.___tabGroupColorsOriginalConnectedCallback = menu.connectedCallback;
                        menu.connectedCallback = function () {
                            this.___tabGroupColorsOriginalConnectedCallback();
                            // mess with the html
                            /** @type Element */
            /*                const swatchesContainer = menu.querySelector(".tab-group-editor-swatches");
                            debug("found swatches container", swatchesContainer);
                            debug("looking for swatch label for", `tab-group-editor-swatch-${firstColors[firstColors.length - 1]}`);
                            for (const swatch of swatchesContainer.children) {
                                debug("found child:", swatch);
                                if (!swatch.nodeName.toLowerCase().includes("label")) {
                                    debug("not a label");
                                    continue;
                                }
                                if (swatch.attributes.for.value !== `tab-group-editor-swatch-${firstColors[firstColors.length - 1]}`) {
                                    debug("not the label we're looking for:", swatch.attributes.for.value);
                                    continue;
                                };

                                // swatch.insertAdjacentHTML("afterend", "<br/>");
                                swatch.classList.add("tab-group-colors-last-vanilla");
                                debug("added class and stopping");

                                break;
                            }
                        };*/

            menu.connectedCallback();


        }
    }
});

// const observe = (subject, topic, data) => {
//     log("observed:", { subject, topic, data });
// }

// Services.obs.addObserver({ observe }, "*");
