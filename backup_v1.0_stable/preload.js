const { contextBridge, ipcRenderer } = require('electron');

// 暴露安全的API到渲染进程的window对象
contextBridge.exposeInMainWorld('electronAPI', {
  // 发送消息到主进程
  sendMessage: (channel, data) => {
    // 定义允许的通道，防止不安全的通道被使用
    const validChannels = ['app-message', 'window-control'];
    if (validChannels.includes(channel)) {
      ipcRenderer.send(channel, data);
    }
  },
  
  // 从主进程接收消息
  receiveMessage: (channel, callback) => {
    const validChannels = ['app-reply', 'window-maximized', 'window-unmaximized'];
    if (validChannels.includes(channel)) {
      // 删除已有的监听器，避免重复监听
      ipcRenderer.removeAllListeners(channel);
      // 添加新的监听器
      ipcRenderer.on(channel, (event, ...args) => callback(...args));
    }
  },
  
  // 打开开发者工具
  openDevTools: () => {
    ipcRenderer.send('app-message', 'open-dev-tools');
  },
  
  // 获取应用版本信息
  getAppVersion: () => {
    return process.env.npm_package_version || '1.0.0';
  },
  
  // 窗口控制方法
  windowControl: {
    minimize: () => {
      ipcRenderer.send('window-control', 'minimize');
    },
    maximize: () => {
      ipcRenderer.send('window-control', 'maximize');
    },
    close: () => {
      ipcRenderer.send('window-control', 'close');
    }
  }
});

// 暴露一些Node.js API到渲染进程（谨慎使用）
contextBridge.exposeInMainWorld('nodeAPI', {
  // 可以在这里暴露一些安全的Node.js API
  platform: process.platform
});