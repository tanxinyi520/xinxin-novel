const fs = require('fs');
const path = 'h:/编程项目/小说软件/欣欣小说/electron_app/index.html';

// 读取文件内容
let content = fs.readFileSync(path, 'utf8');

// 查找所有DOMContentLoaded事件监听器
const regex = /\s*\/\/.*?\n|document\.addEventListener\('DOMContentLoaded',\s*\(\)\s*=>\s*\{[\s\S]*?\}\s*\);/g;
const matches = content.match(regex);

if (matches) {
  // 提取并合并所有DOMContentLoaded事件监听器中的代码
  let combinedCode = '';
  matches.forEach(match => {
    // 跳过注释行
    if (match.startsWith('    //')) {
      return;
    }
    // 提取监听器内的代码
    const code = match
      .replace(/document\.addEventListener\('DOMContentLoaded',\s*\(\)\s*=>\s*\{/, '')
      .replace(/\}\s*\);/, '')
      .trim();
    combinedCode += code + '\n';
  });

  // 创建合并后的DOMContentLoaded事件监听器
  const combinedListener = `    // 页面加载完成后执行的所有初始化操作
    document.addEventListener('DOMContentLoaded', () => {
      console.log('DOM加载完成，开始初始化页面功能');
      ${combinedCode}
    });`;

  // 移除所有旧的DOMContentLoaded事件监听器
  content = content.replace(regex, '');

  // 在</script>标签前添加合并后的事件监听器
  content = content.replace(/<\/script>\s*<\/body>/, `${combinedListener}\n  </script>\n</body>`);

  // 写入优化后的内容到文件
  fs.writeFileSync(path, content, 'utf8');
  console.log('成功合并所有DOMContentLoaded事件监听器！');
} else {
  console.log('未找到DOMContentLoaded事件监听器。');
}