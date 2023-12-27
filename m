Return-Path: <linux-kernel+bounces-11977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14AB81EE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B74283898
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB544390;
	Wed, 27 Dec 2023 11:02:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156F44C60;
	Wed, 27 Dec 2023 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9C8707FDC;
	Wed, 27 Dec 2023 19:02:06 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Dec
 2023 19:02:06 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Dec
 2023 19:02:06 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 27 Dec 2023 19:02:05 +0800
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "kernel@esmil.dk"
	<kernel@esmil.dk>, "conor@kernel.org" <conor@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: RE: [RFC 16/16] riscv: dts: starfive: jh8100: Add clocks and resets
 nodes
Thread-Topic: [RFC 16/16] riscv: dts: starfive: jh8100: Add clocks and resets
 nodes
Thread-Index: AQHaN74UwHfI31bNP0eqUuemefaENrC7DBgAgAHpxDA=
Date: Wed, 27 Dec 2023 11:02:05 +0000
Message-ID: <86603ac21f3e4c28ba5d727245bc6657@EXMBX066.cuchost.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
 <20231226053848.25089-17-jeeheng.sia@starfivetech.com>
 <bc6b5c5e-9396-4740-af99-1eda4275526b@linaro.org>
In-Reply-To: <bc6b5c5e-9396-4740-af99-1eda4275526b@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAyNiwgMjAyMyA5OjM5IFBNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFA
c3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJr
ZWxleS5lZHU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBw
LnphYmVsQHBlbmd1dHJvbml4LmRlOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29t
OyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZv
b24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIDE2LzE2XSByaXNj
djogZHRzOiBzdGFyZml2ZTogamg4MTAwOiBBZGQgY2xvY2tzIGFuZCByZXNldHMgbm9kZXMNCj4g
DQo+IE9uIDI2LzEyLzIwMjMgMDY6MzgsIFNpYSBKZWUgSGVuZyB3cm90ZToNCj4gPiBBZGQgU1lT
Q1JHL1NZU0NSRy1ORS9TWVNDUkctTlcvU1lTQ1JHLVNXL0FPTkNSRyBjbG9jayBhbmQgcmVzZXQN
Cj4gPiBub2RlcyBmb3IgSkg4MTAwIFJJU0MtViBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaWEgSmVlIEhlbmcgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAt
LS0NCj4gDQo+IC4uLg0KPiANCj4gPiAgCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+
ICAJCWludGVycnVwdC1wYXJlbnQgPSA8JnBsaWM+Ow0KPiA+IEBAIC0zNTcsNiArNTYzLDk5IEBA
IHVhcnQ0OiBzZXJpYWxAMTIxYTAwMDAgIHsNCj4gPiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gPiAgCQl9Ow0KPiA+DQo+ID4gKwkJbmVjcmc6IG5lY3JnQDEyMzIwMDAwIHsNCj4gDQo+IFRo
aXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBkdXJpbmcgdGhlIHJldmlldyBwcm9jZXNzLg0KVGhh
bmsgeW91IGZvciB0aGUgZnJpZW5kbHkgcmVtaW5kZXIgYW5kIHlvdXIgdmFsdWFibGUgZmVlZGJh
Y2suDQpJIGFwcHJlY2lhdGUgeW91ciBndWlkYW5jZSBkdXJpbmcgdGhlIHJldmlldyBwcm9jZXNz
Lg0KWW91ciBpbnB1dCBpcyBjcnVjaWFsLCBhbmQgSSdtIGNvbW1pdHRlZCB0byBkZWxpdmVyaW5n
IGhpZ2gtcXVhbGl0eSBjb2RlLg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIHRpbWUgYW5kIGZlZWRi
YWNrLiANCj4gDQo+IEl0IHNlZW1zIG15IG9yIG90aGVyIHJldmlld2VyJ3MgcHJldmlvdXMgY29t
bWVudHMgd2VyZSBub3QgZnVsbHkNCj4gYWRkcmVzc2VkLiBNYXliZSB0aGUgZmVlZGJhY2sgZ290
IGxvc3QgYmV0d2VlbiB0aGUgcXVvdGVzLCBtYXliZSB5b3UNCj4ganVzdCBmb3Jnb3QgdG8gYXBw
bHkgaXQuIFBsZWFzZSBnbyBiYWNrIHRvIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uIGFuZA0KPiBl
aXRoZXIgaW1wbGVtZW50IGFsbCByZXF1ZXN0ZWQgY2hhbmdlcyBvciBrZWVwIGRpc2N1c3Npbmcg
dGhlbS4NCkkgZGlkbid0IGlnbm9yZSB5b3VyIGNvbW1lbnQuIEluc3RlYWQsIEkgbWlzaW50ZXJw
cmV0ZWQgaXQgYXMgc3VnZ2VzdGluZw0KdGhlIHVzZSBvZiBhIGRhc2ggaW5zdGVhZCBvZiBhbiB1
bmRlcnNjb3JlIGZvciB0aGUgbm9kZSdzIG5hbWUuIEkgd2lsbCBtYWtlDQp0aGUgbmVjZXNzYXJ5
IGFkanVzdG1lbnQgYW5kIGNoYW5nZSBpdCBiYWNrIHRvICdjbG9jay1jb250cm9sbGVyJy4NCj4g
DQo+IFRoYW5rIHlvdS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

