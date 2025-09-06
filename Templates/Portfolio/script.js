const mobileNavToggleButton = document.querySelector('.mobile-nav-toggle');
const nav = document.querySelector('.nav');
const navList = document.querySelector('.nav-list');

mobileNavToggleButton.addEventListener('click', () => {
    nav.classList.toggle('active');
});

