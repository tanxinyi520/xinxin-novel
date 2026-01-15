const { app, BrowserWindow, Menu, ipcMain } = require('electron');
const path = require('path');
const url = require('url');

// 保持对window对象的全局引用，如果不这样做，当JavaScript对象被垃圾回收时，window将会自动关闭
let mainWindow;

function createWindow() {
  // 创建浏览器窗口
  mainWindow = new BrowserWindow({
    width: 1024,
    height: 768,
    minWidth: 800,
    minHeight: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      preload: path.join(__dirname, 'preload.js'),
      devTools: true // 确保开发者工具可用
    },
    icon: path.join(__dirname, 'assets', 'icon.ico')
  });

  // 加载应用的index.html
  mainWindow.loadURL(url.format({
    pathname: path.join(__dirname, 'index.html'),
    protocol: 'file:',
    slashes: true
  }));

  // 允许在Electron应用中导航到其他HTML文件
  mainWindow.webContents.on('will-navigate', (event, url) => {
    console.log('导航事件:', url);
    // 允许所有本地文件导航
    if (url.startsWith('file://')) {
      // 不阻止导航，允许跳转到其他HTML文件
    }
  });

  // 注释掉自动打开开发者工具的代码，改为通过用户界面控制
  // mainWindow.webContents.openDevTools();

  // 创建应用菜单
  const menuTemplate = [
    {
      label: '文件',
      submenu: [
        {
          label: '退出',
          accelerator: 'Ctrl+Q',
          click() { app.quit(); }
        }
      ]
    },
    {
      label: '视图',
      submenu: [
        {
          label: '刷新',
          accelerator: 'Ctrl+R',
          click() { mainWindow.webContents.reload(); }
        }
      ]
    }
  ];

  const menu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(menu);

  // 当window被关闭时触发
  mainWindow.on('closed', () => {
    // 取消引用window对象，如果应用支持多窗口，通常会把多个window对象存储在一个数组中，这时需要删除相应的元素
    mainWindow = null;
  });

  // 窗口最大化事件，用于调整UI布局
  mainWindow.on('maximize', () => {
    mainWindow.webContents.send('window-maximized');
  });

  // 窗口取消最大化事件
  mainWindow.on('unmaximize', () => {
    mainWindow.webContents.send('window-unmaximized');
  });
}

// Electron会在初始化后并准备创建浏览器窗口时调用这个函数
app.on('ready', createWindow);

// 当所有窗口都关闭时退出应用
app.on('window-all-closed', () => {
  // 在macOS上，除非用户用Cmd+Q确定地退出，否则应用及其菜单栏会保持活动状态
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  // 在macOS上，当点击dock图标并且没有其他窗口打开时，通常会在应用中重新创建一个窗口
  if (mainWindow === null) {
    createWindow();
  }
});

// 处理从渲染进程发送的消息
ipcMain.on('app-message', (event, arg) => {
  console.log(arg); // 打印从渲染进程收到的消息
  if (arg === 'open-dev-tools') {
    mainWindow.webContents.openDevTools();
  }
  event.reply('app-reply', '消息已收到');
});

// 处理窗口控制命令
ipcMain.on('window-control', (event, command) => {
  switch (command) {
    case 'minimize':
      mainWindow.minimize();
      break;
    case 'maximize':
      if (mainWindow.isMaximized()) {
        mainWindow.unmaximize();
      } else {
        mainWindow.maximize();
      }
      break;
    case 'close':
      mainWindow.close();
      break;
  }
});