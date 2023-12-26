Return-Path: <linux-kernel+bounces-11400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9981E5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BB61C21CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4B4C631;
	Tue, 26 Dec 2023 07:35:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD574C60B;
	Tue, 26 Dec 2023 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BQ7YxK02332767, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BQ7YxK02332767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Dec 2023 15:34:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 26 Dec 2023 15:34:57 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 15:34:57 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Tue, 26 Dec 2023 15:34:57 +0800
From: =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
Thread-Topic: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Thread-Index: AQHaNKykAxQglRQ65UeKSWnkfMw4BLC2ZpWAgATFNhA=
Date: Tue, 26 Dec 2023 07:34:57 +0000
Message-ID: <0d0510c2340e4e7f8048e56400a01b48@realtek.com>
References: <20231222075812.6540-1-tychang@realtek.com>
 <20231222075812.6540-3-tychang@realtek.com>
 <2a44fe91-b4a5-4842-8abc-f30c532f14e0@linaro.org>
In-Reply-To: <2a44fe91-b4a5-4842-8abc-f30c532f14e0@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj4uLi4NCj4NCj4+
ICtzdGF0aWMgaW50IHJ0ZF9ncGlvX2lycV9zZXRfdHlwZShzdHJ1Y3QgaXJxX2RhdGEgKmQsIHVu
c2lnbmVkIGludA0KPj4gK3R5cGUpIHsNCj4+ICsgICAgIHN0cnVjdCBncGlvX2NoaXAgKmdjID0g
aXJxX2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+PiArICAgICBzdHJ1Y3QgcnRkX2dwaW8g
KmRhdGEgPSBncGlvY2hpcF9nZXRfZGF0YShnYyk7DQo+PiArICAgICBpcnFfaHdfbnVtYmVyX3Qg
aHdpcnEgPSBpcnFkX3RvX2h3aXJxKGQpOw0KPj4gKyAgICAgdTMyIG1hc2sgPSBCSVQoaHdpcnEg
JSAzMik7DQo+PiArICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gKyAgICAgaW50IGRwX3Jl
Z19vZmZzZXQ7DQo+PiArICAgICBib29sIHBvbGFyaXR5Ow0KPj4gKyAgICAgdTMyIHZhbDsNCj4+
ICsNCj4+ICsgICAgIGRwX3JlZ19vZmZzZXQgPSBydGRfZ3Bpb19kcF9vZmZzZXQoZGF0YSwgaHdp
cnEpOw0KPj4gKw0KPj4gKyAgICAgc3dpdGNoICh0eXBlICYgSVJRX1RZUEVfU0VOU0VfTUFTSykg
ew0KPj4gKyAgICAgY2FzZSBJUlFfVFlQRV9FREdFX1JJU0lORzoNCj4+ICsgICAgICAgICAgICAg
cG9sYXJpdHkgPSAxOw0KPj4gKyAgICAgICAgICAgICBicmVhazsNCj4+ICsNCj4+ICsgICAgIGNh
c2UgSVJRX1RZUEVfRURHRV9GQUxMSU5HOg0KPj4gKyAgICAgICAgICAgICBwb2xhcml0eSA9IDA7
DQo+PiArICAgICAgICAgICAgIGJyZWFrOw0KPj4gKw0KPj4gKyAgICAgY2FzZSBJUlFfVFlQRV9F
REdFX0JPVEg6DQo+PiArICAgICAgICAgICAgIHBvbGFyaXR5ID0gMTsNCj4+ICsgICAgICAgICAg
ICAgYnJlYWs7DQo+PiArDQo+PiArICAgICBkZWZhdWx0Og0KPj4gKyAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIHJhd19zcGluX2xvY2tfaXJx
c2F2ZSgmZGF0YS0+bG9jaywgZmxhZ3MpOw0KPg0KPldoeSBhcmUgeW91IHVzaW5nIHJhdyBzcGlu
bG9jaz8gVGhpcyBxdWVzdGlvbiBhcHBsaWVzIHRvIGVudGlyZSBkcml2ZXIuDQo+DQoNCkkgdGhp
bmsgY29uc3VtZXIgZHJpdmVyIG1heSBvcGVyYXRlIEdQSU9zIHdpdGhpbiB0aGUgSVNSLCBzbyBp
dCBuZWVkcyBhIGxvY2suDQoNCj4+ICsNCj4+ICsgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQoZGF0
YS0+YmFzZSArIGRwX3JlZ19vZmZzZXQpOw0KPj4gKyAgICAgaWYgKHBvbGFyaXR5KQ0KPj4gKyAg
ICAgICAgICAgICB2YWwgfD0gbWFzazsNCj4+ICsgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAg
dmFsICY9IH5tYXNrOw0KPj4gKyAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBkYXRhLT5iYXNlICsg
ZHBfcmVnX29mZnNldCk7DQo+PiArDQo+PiArICAgICByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmZGF0YS0+bG9jaywgZmxhZ3MpOw0KPj4gKw0KPj4gKyAgICAgcmV0dXJuIDA7DQo+PiArfQ0K
Pg0KPi4uLg0KPg0KPn0NCj4+ICsNCj4+ICttb2R1bGVfaW5pdChydGRfZ3Bpb19pbml0KTsNCj4+
ICsNCj4+ICtzdGF0aWMgdm9pZCBfX2V4aXQgcnRkX2dwaW9fZXhpdCh2b2lkKSB7DQo+PiArICAg
ICBwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmcnRkX2dwaW9fcGxhdGZvcm1fZHJpdmVyKTsN
Cj4+ICt9DQo+PiArbW9kdWxlX2V4aXQocnRkX2dwaW9fZXhpdCk7DQo+DQo+V2h5IG5vdCB1c2lu
ZyBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyPw0KPg0KDQpJIHdpbGwgcmV2aXNlIGl0Lg0KDQpUaGFu
a3MsDQpUenV5aSBDaGFuZw0K

