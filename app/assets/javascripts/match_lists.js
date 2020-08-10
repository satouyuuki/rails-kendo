// function handleClick(event) {
//   console.log(this.x);
// }
window.addEventListener('DOMContentLoaded', (event) => {
  const cells = document.querySelectorAll('.match-table__list--cell2');
  const mask = document.querySelector('.mask');
  const closeModalBtn = document.querySelector('.m-card__close-btn');
  const maskCard = document.querySelector('.m-card');
  const cellLength = cells.length;
  /** テーブルをタップでモーダル出現 */
  for (i = 0; i < cellLength; i++) {
    const cell = cells[i];
    cell.addEventListener('click', (e) => {
      mask.classList.add('active');
      console.log(e);
    })
    // cell.addEventListener('click', {x: i, handleEvent: handleClick})
  }
  /** モーダルとじる */
  closeModalBtn.addEventListener('click', () => {
    mask.classList.remove('active');
  })
  mask.addEventListener('click', () => {
    mask.classList.remove('active');
  })
  maskCard.addEventListener('click', (e) => {
    e.stopPropagation();
  })
});
