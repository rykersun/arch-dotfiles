# Apt helix-lsp installation

## rust-analyzer

```bash
wget https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz && gzip -d rust-analyzer-x86_64-unknown-linux-gnu.gz && chmod +x rust-analyzer-x86_64-unknown-linux-gnu && mv rust-analyzer-x86_64-unknown-linux-gnu rust-analyzer && sudo mv rust-analyzer /usr/local/bin
```

## clang

```bash
sudo apt-get install clangd-12 build-essential
```

```bash
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
```

## python-lsp-server

```bash
sudo apt install python3 python3-pip
```

```bash
sudo pip3 install "python-lsp-server[all]"
```
