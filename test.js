// 测试JavaScript文件
console.log('测试JavaScript文件被加载');

// 初始化小说卡片点击事件
function initNovelCardClick() {
  console.log('初始化小说卡片点击事件');
  // 处理标准小说卡片 (首页、分类页、发现页)
  const bookCards = document.querySelectorAll('.book-card');
  console.log('找到的小说卡片数量:', bookCards.length);
  
  bookCards.forEach(card => {
    card.addEventListener('click', function() {
      console.log('小说卡片被点击');
      let title, author, cover;
      
      // 尝试不同的选择器，适应不同页面的结构
      const titleElement = this.querySelector('h3, h4, h5');
      const authorElement = this.querySelector('p');
      const coverElement = this.querySelector('img');
      
      console.log('标题元素:', titleElement);
      console.log('作者元素:', authorElement);
      console.log('封面元素:', coverElement);
      
      if (titleElement && authorElement && coverElement) {
        title = titleElement.textContent;
        author = authorElement.textContent;
        cover = coverElement.src;
        
        console.log('导航到小说详情:', title, author, cover);
        navigateToNovelDetail(title, author, cover);
      } else {
        console.log('找不到必要的元素');
      }
    });
  });
}

// 导航到小说详情页面
function navigateToNovelDetail(title, author, cover) {
  console.log('导航到小说详情页面:', title, author, cover);
  const pages = document.querySelectorAll('.page');
  pages.forEach(page => page.classList.remove('active'));
  
  const novelDetailPage = document.getElementById('novelDetail');
  console.log('小说详情页面元素:', novelDetailPage);
  if (novelDetailPage) {
    novelDetailPage.classList.add('active');
    console.log('添加小说详情页面active类');
    
    // 更新小说详情信息
    const novelTitle = document.getElementById('novelTitle');
    const novelAuthor = document.getElementById('novelAuthor');
    const novelCover = document.getElementById('novelCover');
    console.log('小说标题元素:', novelTitle);
    console.log('小说作者元素:', novelAuthor);
    console.log('小说封面元素:', novelCover);
    
    if (novelTitle) novelTitle.textContent = title;
    if (novelAuthor) novelAuthor.textContent = '作者：' + author;
    if (novelCover) novelCover.src = cover;
  } else {
    console.log('找不到小说详情页面');
  }
}

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', function() {
  console.log('DOM加载完成，开始初始化页面功能');
  initNovelCardClick();
});