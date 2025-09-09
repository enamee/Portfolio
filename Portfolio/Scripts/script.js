const mobileNavToggleButton = document.querySelector('.mobile-nav-toggle');
const nav = document.querySelector('.nav');
const navList = document.querySelector('.nav-list');

mobileNavToggleButton.addEventListener('click', () => {
    nav.classList.toggle('active');
});

document.querySelectorAll('.nav a').forEach(link => {
    link.addEventListener('click', () => {
        document.querySelector('.nav').classList.toggle('active');
    });
});

// Parallax effect
window.addEventListener("scroll", function () {
    const img = document.querySelector(".about-image");
    const rect = img.getBoundingClientRect();
    const offset = rect.top * 0.2; // adjust speed (0.1–0.5 works well)
    img.style.transform = `translateY(${offset}px) rotate(2deg)`; // slight tilt
});