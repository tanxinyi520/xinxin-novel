const { app, BrowserWindow, Menu, dialog } = require('electron');
const path = require('path');
const url = require('url');

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1200,
        height: 800,
        minWidth: 1000,
        minHeight: 700,
        title: '欣欣小说',
        icon: path.join(__dirname, 'images/icon.ico'),
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false,
            enableRemoteModule: true
        }
    });

    mainWindow.loadURL(url.format({
        pathname: path.join(__dirname, '欣欣小说.html'),
        protocol: 'file:',
        slashes: true
    }));

    mainWindow.on('closed', function() {
        mainWindow = null;
    });

    const menu = Menu.buildFromTemplate([
        {
            label: '文件',
            submenu: [
                { label: '退出', click: () => app.quit() }
            ]
        },
        {
            label: '窗口',
            submenu: [
                { label: '刷新', click: () => mainWindow.reload() },
                { label: '开发者工具', click: () => mainWindow.webContents.openDevTools() }
            ]
        }
    ]);
    Menu.setApplicationMenu(menu);
}

app.on('ready', createWindow);

app.on('window-all-closed', function() {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', function() {
    if (mainWindow === null) {
        createWindow();
    }
});
