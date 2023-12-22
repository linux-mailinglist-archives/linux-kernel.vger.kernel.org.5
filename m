Return-Path: <linux-kernel+bounces-9203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7201E81C246
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD18282C00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79BAA53;
	Fri, 22 Dec 2023 00:19:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1638A;
	Fri, 22 Dec 2023 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM0JF9Z01723586, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM0JF9Z01723586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 08:19:15 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Dec 2023 08:19:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 22 Dec 2023 08:19:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 08:19:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"
Thread-Topic: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify"
 -> "notify"
Thread-Index: AQHaM09teBRraq9bkEuzuVAKvhnc67C0cglA
Date: Fri, 22 Dec 2023 00:19:15 +0000
Message-ID: <2839b824a2a04aab9514ce89b3735e52@realtek.com>
References: <20231220141831.10063-1-colin.i.king@gmail.com>
In-Reply-To: <20231220141831.10063-1-colin.i.king@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gSWFuIEtpbmcg
PGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjAs
IDIwMjMgMTA6MTkgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsg
S2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdW25leHRdIHdpZmk6IHJ0dzg5OiBt
YWM6IEZpeCBzcGVsbGluZyBtaXN0YWtlcyAibm90ZmlmeSIgLT4gIm5vdGlmeSINCj4gDQo+IFRo
ZXJlIGFyZSB0d28gc3BlbGxpbmcgbWlzdGFrZXMgaW4gcnR3ODlfZXJyIGVycm9yIG1lc3NhZ2Vz
LiBGaXggdGhlc2UNCj4gYW5kIGFsc28gYWRkIHNwYWNlIGJldHdlZW4gW0VSUl0gYW5kIG1lc3Nh
Z2UgdGV4dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5pLmtp
bmdAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQoNClRoYW5rcyBmb3IgdGhlIGNvcnJlY3RuZXNzLiBDb3VsZCBJIGtub3cgdGhlIHRvb2wg
eW91IHVzZWQgdG8gZmluZCBvdXQgdGhlc2UNCnR5cG8/IA0KDQpQaW5nLUtlDQoNCg0K

