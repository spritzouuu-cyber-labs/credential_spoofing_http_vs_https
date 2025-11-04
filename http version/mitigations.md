# 🔒 MITIGATIONS — Preventing Plaintext Credential Exposure

> This document explains **why credentials appear in plaintext over HTTP**, how it happens at the packet level, and the **most effective and simple ways to prevent it**.  
> Intended for educational and secure lab use only.

---

## 🧩 Why credentials appear in plaintext

### **HTTP vs HTTPS:**
HTTP transmits all data (URL, headers, body) **unencrypted**.  
When a login form sends `username` and `password` via `POST` to `http://...`, the TCP packets contain the credentials **in cleartext** — anyone sniffing the network (e.g., Wireshark, a compromised router, or a malicious hotspot) can read them.

**HTTPS (HTTP + TLS)** encrypts the session between client and server using **Transport Layer Security (TLS)**.  
Once HTTPS is enabled, the body, headers, and cookies are encrypted and invisible to sniffers.

---

### 🧠 How it works at the packet level (short)

When you submit an HTTP form, the browser sends an HTTP **POST** over a TCP connection.  
That HTTP message (start-line, headers, and body) is transmitted as the **payload of TCP packets**.  
If no TLS is used, these payload bytes are sent *as-is* on the wire — they are not transformed or encrypted by the protocol stack.  
A network sniffer (Wireshark, tcpdump) that can access the interface carrying those packets can reconstruct the TCP stream and display the HTTP message with the username and password in cleartext.

In contrast, HTTPS wraps the HTTP message in a TLS session.  
TLS performs a handshake, negotiates encryption keys, and then all subsequent bytes (including the HTTP body) are encrypted before being placed in TCP packets.  
A sniffer will only see encrypted TLS records (random-looking bytes) and cannot read the HTTP body or headers (except for limited metadata such as destination IP and negotiated TLS version).

---

### 🌐 Relation to the OSI Model

To understand **why HTTP is unencrypted** and **how HTTPS protects it**, it helps to look at where each protocol sits in the **OSI model**.

| **Layer** | **Name** | **Examples** | **Relation to Encryption** |
|------------|-----------|--------------|-----------------------------|
| 7️⃣ | **Application** | HTTP, SMTP, FTP | Contains the actual content (e.g., login forms, passwords). HTTP lives here and does not encrypt by itself. |
| 6️⃣ | **Presentation** | TLS / SSL, JPEG, MIME | 🔐 TLS works here — it encrypts the application data before it is sent over the network. |
| 5️⃣ | **Session** | TLS Handshake, RPC | TLS also establishes and maintains the secure session (negotiating keys, ciphers, versions). |
| 4️⃣ | **Transport** | TCP, UDP | Transports the data segments; unaware of encryption. |
| 3️⃣ | **Network** | IP | Handles routing and addressing. Encryption does not occur here. |
| 2️⃣ | **Data Link** | Ethernet, Wi-Fi | Responsible for frames and physical addressing (MAC). |
| 1️⃣ | **Physical** | Copper, Fiber, Radio | Raw bits/signals on the medium. |

In short:
- **HTTP** runs directly over **TCP**, so its payload travels in cleartext.  
- **HTTPS** adds **TLS** between the Application and Transport layers, encrypting the HTTP data before it reaches TCP.  
- The result: network tools (like Wireshark) can still see IPs and ports, but not the content of the HTTP request (no more visible credentials).

> 🧠 **Analogy:**  
> HTTP = sending a postcard (anyone can read it).  
> HTTPS = sealing your message inside an envelope locked with a cryptographic key.

---

### 🧩 Other attack surfaces

Even with HTTPS, credentials can still be compromised through **malware**, **XSS**, or **improper logging** on the server.

---

## ⚠️ Main Risks
- Credential theft and account takeover (replay attacks).  
- Session hijacking if cookies aren’t secured.  
- Large-scale data leaks if login pages use HTTP.  
- Legal and compliance issues (e.g., GDPR, PCI-DSS).

---

## 🔐 The simplest and most effective mitigation — Enforce HTTPS