Return-Path: <linux-kernel+bounces-10846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F37981DD50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDE9281C08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A464B;
	Mon, 25 Dec 2023 00:19:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40B7E;
	Mon, 25 Dec 2023 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BP0JADt83527188, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BP0JADt83527188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Dec 2023 08:19:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 25 Dec 2023 08:19:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 08:19:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 25 Dec 2023 08:19:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
        Kalle Valo
	<kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"
Thread-Topic: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify"
 -> "notify"
Thread-Index: AQHaM09teBRraq9bkEuzuVAKvhnc67C0cglAgABAZoCABHZpYA==
Date: Mon, 25 Dec 2023 00:19:10 +0000
Message-ID: <c43fe18df3cb488e9a3bdf38221e0a1b@realtek.com>
References: <20231220141831.10063-1-colin.i.king@gmail.com>
 <2839b824a2a04aab9514ce89b3735e52@realtek.com>
 <75cd2090-857e-4082-bbc1-e3726235bda1@gmail.com>
In-Reply-To: <75cd2090-857e-4082-bbc1-e3726235bda1@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gS2luZyAoZ21h
aWwpIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDIy
LCAyMDIzIDg6MDkgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsg
S2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXVtuZXh0XSB3aWZpOiBydHc4
OTogbWFjOiBGaXggc3BlbGxpbmcgbWlzdGFrZXMgIm5vdGZpZnkiIC0+ICJub3RpZnkiDQo+IA0K
PiBPbiAyMi8xMi8yMDIzIDAwOjE5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4NCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8
Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAy
MCwgMjAyMyAxMDoxOSBQTQ0KPiA+PiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+OyBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+ID4+IENjOiBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFtQQVRDSF1bbmV4dF0gd2lm
aTogcnR3ODk6IG1hYzogRml4IHNwZWxsaW5nIG1pc3Rha2VzICJub3RmaWZ5IiAtPiAibm90aWZ5
Ig0KPiA+Pg0KPiA+PiBUaGVyZSBhcmUgdHdvIHNwZWxsaW5nIG1pc3Rha2VzIGluIHJ0dzg5X2Vy
ciBlcnJvciBtZXNzYWdlcy4gRml4IHRoZXNlDQo+ID4+IGFuZCBhbHNvIGFkZCBzcGFjZSBiZXR3
ZWVuIFtFUlJdIGFuZCBtZXNzYWdlIHRleHQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IENv
bGluIElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KPiA+DQo+ID4gQWNrZWQtYnk6
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0
aGUgY29ycmVjdG5lc3MuIENvdWxkIEkga25vdyB0aGUgdG9vbCB5b3UgdXNlZCB0byBmaW5kIG91
dCB0aGVzZQ0KPiA+IHR5cG8/DQo+IA0KPiBTdXJlLA0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29t
L0NvbGluSWFuS2luZy9rZXJuZWxzY2FuDQo+IA0KPiBJdCBuZWVkcyB0aGUgYW1lcmljYW4gZGlj
dGlvbmFyeSwgaW5zdGFsbGVkIGluIC91c3Ivc2hhcmUvZGljdCBlLmcuDQo+IGFwdC1nZXQgaW5z
dGFsbCB3YW1lcmljYW4NCj4gDQo+IGFuZCB0aGVuIHNwZWxsY2hlY2sgd2l0aDoNCj4gDQo+IC4v
a2VybmVsc2NhbiAtayBwYXRoLXRvLWNvZGUteW91LXdhbnQtdG8tc2Nhbg0KDQpUaGFua3MgZm9y
IHRoZSB0b29sLiA6LSkNCkkgd2lsbCB0cnkgdG8gc2NhbiBteSBkcml2ZXIgYmVmb3JlIHNlbmRp
bmcgb3V0IHBhdGNoZXMuIA0KDQpQaW5nLUtlDQoNCg0K

