// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
var sidebarScrollbox = document.querySelector("#sidebar .sidebar-scrollbox");
sidebarScrollbox.innerHTML = '<ol class="chapter"><li class="chapter-item expanded affix "><a href="index.html">Introduction</a></li><li class="chapter-item expanded affix "><li class="part-title">Linux 🐧</li><li class="chapter-item expanded "><div>Ubuntu</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="linux/ubuntu/oobe.html">OOBE</a></li><li class="chapter-item expanded "><div>Virtualization</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="linux/ubuntu/virt/type-1-vm.html">KVM</a></li></ol></li></ol></li><li class="chapter-item expanded "><div>RHEL/Fedora/CentOS</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="linux/fedora/oobe.html">OOBE</a></li><li class="chapter-item expanded "><a href="linux/fedora/ansible.html">Ansible</a></li></ol></li><li class="chapter-item expanded "><div>Arch Linux</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="linux/arch/minimal-oobe.html">Minimal OOBE</a></li><li class="chapter-item expanded "><a href="linux/arch/manjaro-oobe.html">Manjaro OOBE</a></li></ol></li><li class="chapter-item expanded "><div>Operations</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="linux/sys-ops.html">System Operations</a></li><li class="chapter-item expanded "><a href="linux/file-ops.html">File Operations</a></li><li class="chapter-item expanded "><a href="linux/net-ops.html">Network Operations</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">macOS 🍎</li><li class="chapter-item expanded "><a href="macos/oobe.html">OOBE</a></li><li class="chapter-item expanded "><div>Operations</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="macos/sys-ops.html">System Operations</a></li><li class="chapter-item expanded "><a href="macos/file-ops.html">File Operations</a></li><li class="chapter-item expanded "><a href="macos/net-ops.html">Network Operations</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">Windows 🪟</li><li class="chapter-item expanded "><a href="windows/scripts.html">Convenience Scripts</a></li><li class="chapter-item expanded "><div>Operations</div></li><li><ol class="section"><li class="chapter-item expanded "><a href="windows/sys-ops.html">System Operations</a></li><li class="chapter-item expanded "><a href="windows/file-ops.html">File Operations</a></li><li class="chapter-item expanded "><a href="windows/net-ops.html">Network Operations</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">Container and Orchestration 🚢</li><li class="chapter-item expanded "><a href="container/docker/index.html">Docker 🐋</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="container/docker/install.html">Installation</a></li><li class="chapter-item expanded "><a href="container/docker/operations.html">Operations</a></li><li class="chapter-item expanded "><a href="container/docker/Dockerfile.html">Dockerfile</a></li><li class="chapter-item expanded "><a href="container/docker/portainer.html">Portainer</a></li></ol></li><li class="chapter-item expanded "><a href="container/k8s/index.html">Kubernetes ☸️</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="container/k8s/install.html">Installation</a></li><li class="chapter-item expanded "><a href="container/k8s/helpers.html">Make Life Easier</a></li><li class="chapter-item expanded "><a href="container/k8s/operations.html">Operations</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">Miscellaneous CLIs 🖥️</li><li class="chapter-item expanded "><a href="misc-cli/ffmpeg.html">ffmpeg</a></li><li class="chapter-item expanded "><a href="misc-cli/ytb-dl.html">ytb-dl</a></li></ol>';
(function() {
    let current_page = document.location.href.toString();
    if (current_page.endsWith("/")) {
        current_page += "index.html";
    }
    var links = sidebarScrollbox.querySelectorAll("a");
    var l = links.length;
    for (var i = 0; i < l; ++i) {
        var link = links[i];
        var href = link.getAttribute("href");
        if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
            link.href = path_to_root + href;
        }
        // The "index" page is supposed to alias the first chapter in the book.
        if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
            link.classList.add("active");
            var parent = link.parentElement;
            while (parent) {
                if (parent.tagName === "LI" && parent.previousElementSibling) {
                    if (parent.previousElementSibling.classList.contains("chapter-item")) {
                        parent.previousElementSibling.classList.add("expanded");
                    }
                }
                parent = parent.parentElement;
            }
        }
    }
})();

// Track and set sidebar scroll position
sidebarScrollbox.addEventListener('click', function(e) {
    if (e.target.tagName === 'A') {
        sessionStorage.setItem('sidebar-scroll', sidebarScrollbox.scrollTop);
    }
}, { passive: true });
var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
sessionStorage.removeItem('sidebar-scroll');
if (sidebarScrollTop) {
    // preserve sidebar scroll position when navigating via links within sidebar
    sidebarScrollbox.scrollTop = sidebarScrollTop;
} else {
    // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
    var activeSection = document.querySelector('#sidebar .active');
    if (activeSection) {
        activeSection.scrollIntoView({ block: 'center' });
    }
}
