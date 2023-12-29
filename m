Return-Path: <linux-kernel+bounces-13153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81649820070
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2884282606
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46662125C4;
	Fri, 29 Dec 2023 16:00:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE7125B5;
	Fri, 29 Dec 2023 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BTFxbLD32700466, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BTFxbLD32700466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 23:59:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 29 Dec 2023 23:59:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 29 Dec 2023 23:59:37 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::99d6:b187:8b72:6226]) by
 RTEXMBS03.realtek.com.tw ([fe80::99d6:b187:8b72:6226%2]) with mapi id
 15.01.2507.035; Fri, 29 Dec 2023 23:59:37 +0800
From: =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH v4 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Thread-Index: AQHaOVRaSxuj6qgqmUafYrHCuNSEx7C9ybkAgAKevmA=
Date: Fri, 29 Dec 2023 15:59:36 +0000
Message-ID: <7fece55c500145c6a09ee4c6cd2687cd@realtek.com>
References: <20231228060825.1380439-1-james.tai@realtek.com>
 <20231228060825.1380439-2-james.tai@realtek.com>
 <9c0fdb52-6312-4b3a-9ed8-ca8f38d1010d@linaro.org>
In-Reply-To: <9c0fdb52-6312-4b3a-9ed8-ca8f38d1010d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+PiBBZGQgdGhlIFlBTUwgZG9jdW1lbnRhdGlvbiBmb3IgUmVhbHRl
ayBESEMgKERpZ2l0YWwgSG9tZSBDZW50ZXIpIFNvQ3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
SmFtZXMgVGFpIDxqYW1lcy50YWlAcmVhbHRlay5jb20+DQo+DQo+VGhhbmsgeW91IGZvciB5b3Vy
IHBhdGNoLiBUaGVyZSBpcyBzb21ldGhpbmcgdG8gZGlzY3Vzcy9pbXByb3ZlLg0KPg0KPj4gKyAg
aW50ZXJydXB0czoNCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgbWF4SXRlbXM6IDMNCj4+
ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgQ29udGFpbnMgdGhlIEdJQyBTUEkgSVJRcyBt
YXBwZWQgdG8gdGhlIGV4dGVybmFsIGludGVycnVwdCBsaW5lcy4NCj4+ICsNCj4+ICtyZXF1aXJl
ZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJydXB0LWNv
bnRyb2xsZXINCj4+ICsgIC0gJyNpbnRlcnJ1cHQtY2VsbHMnDQo+PiArICAtICcjYWRkcmVzcy1j
ZWxscycNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KPj4gKw0KPj4gK2FsbE9mOg0KPg0KPklmIHRoZXJlIGlzIGdvaW5nIHRvIGJlIG5l
dyB2ZXJzaW9uL3Jlc2VuZCwgYWxsT2Y6IGJsb2NrIGdvZXMgYmVmb3JlDQo+YWRkaXRpb25hbFBy
b3BlcnRpZXM6Lg0KPg0KSSB3aWxsIG1vdmUgdGhlICdhbGxPZjogYmxvY2snIHRvIGdvIGJlZm9y
ZSAnYWRkaXRpb25hbFByb3BlcnRpZScgaW4gbmV4dCBwYXRjaGVzLg0KDQo+PiArICAtICRyZWY6
IC9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyLnlhbWwjDQo+PiArICAtIGlmOg0KPj4gKyAg
ICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgICBl
bnVtOg0KPj4gKyAgICAgICAgICAgIC0gcmVhbHRlayxydGQxMzE5LWludGMtaXNvDQo+PiArICAg
IHRoZW46DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGludGVycnVwdHM6DQo+
PiArICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+DQo+V2h5IHRoZSBzZWNvbmQgaW50ZXJydXB0IGlz
IG9wdGlvbmFsPyBJdCdzIGEgU29DLCB0aGUgcGlucyBhcmUgbm90IGNvbmZpZ3VyYWJsZQ0KPnVz
dWFsbHkuIFNhbWUgcXVlc3Rpb24gZm9yIG90aGVyIGNhc2VzLg0KPg0KSSB0aG91Z2h0IGl0IHdh
cyBkZWZpbmVkIHRoaXMgd2F5IHRvIGFjY29tbW9kYXRlIGRpZmZlcmVudCBTb0NzLg0KSSB3aWxs
IHJlbW92ZSB0aGUgJ21pbkl0ZW1zJy4gU2hvdWxkIHRoZSBjb3JyZWN0IHZlcnNpb24gbG9vayBs
aWtlIHRoZSBmb2xsb3dpbmc/DQoNCmFsbE9mOg0KICAtICRyZWY6IC9zY2hlbWFzL2ludGVycnVw
dC1jb250cm9sbGVyLnlhbWwjDQogIC0gaWY6DQogICAgICBwcm9wZXJ0aWVzOg0KICAgICAgICBj
b21wYXRpYmxlOg0KICAgICAgICAgIGVudW06DQogICAgICAgICAgICAtIHJlYWx0ZWsscnRkMTMx
OS1pbnRjLWlzbw0KICAgIHRoZW46DQogICAgICBwcm9wZXJ0aWVzOg0KICAgICAgICBpbnRlcnJ1
cHRzOg0KICAgICAgICAgIGl0ZW1zOg0KICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogaXNvbGF0
aW9uIGlycXMNCiAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IHJ0YyBpcnENCi4uLg0KLi4uDQoN
ClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K

