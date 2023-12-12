Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2780E276
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbjLLC6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:58:36 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC5D83;
        Mon, 11 Dec 2023 18:58:39 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1220B24E296;
        Tue, 12 Dec 2023 10:58:38 +0800 (CST)
Received: from EXMBX064.cuchost.com (172.16.6.64) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:58:38 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX064.cuchost.com
 (172.16.6.64) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:58:37 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 12 Dec 2023 10:58:37 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "conor@kernel.org" <conor@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "emil.renner.berthing@canonical.com" 
        <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH v1 16/16] riscv: dts: starfive: jh8100: Add clocks and
 resets nodes
Thread-Topic: [PATCH v1 16/16] riscv: dts: starfive: jh8100: Add clocks and
 resets nodes
Thread-Index: AQHaKDqra6wATad1nUKrJTE2u0DzTrCfKVUAgAXSX4A=
Date:   Tue, 12 Dec 2023 02:58:37 +0000
Message-ID: <62705afb652e416695aa26e3bdb2500e@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-17-jeeheng.sia@starfivetech.com>
 <4dd53599-5e80-4a00-a708-507c9c2e7b6b@linaro.org>
In-Reply-To: <4dd53599-5e80-4a00-a708-507c9c2e7b6b@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwg
RGVjZW1iZXIgOSwgMjAyMyAxOjU3IEFNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFA
c3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJr
ZWxleS5lZHU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBw
LnphYmVsQHBlbmd1dHJvbml4LmRlOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29t
OyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZv
b24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTYvMTZd
IHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBqaDgxMDA6IEFkZCBjbG9ja3MgYW5kIHJlc2V0cyBub2Rl
cw0KPiANCj4gT24gMDYvMTIvMjAyMyAxMjo1MCwgU2lhIEplZSBIZW5nIHdyb3RlOg0KPiA+IEFk
ZCBTWVNDUkcvU1lTQ1JHLU5FL1NZU0NSRy1OVy9TWVNDUkctU1cvQU9OQ1JHIGNsb2NrIGFuZCBy
ZXNldA0KPiA+IG5vZGVzIGZvciBKSDgxMDAgUklTQy1WIFNvQy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0K
PiANCj4gUmVhbGx5PyBMb29rcyBhdXRvbWF0ZWQuLi4gQ2FyZSB0byBwcm92aWRlIGFueSBsaW5r
cyB0byBlZmZlY3RzIG9mDQo+IGludGVybmFsIHJldmlldz8NCmh0dHBzOi8vZ2l0bGFiLnN0YXJm
aXZldGVjaC5jb20vamVlaGVuZy5zaWEvbGludXgvLS9jb21taXRzL0pIODEwMF9VcHN0cmVhbS8N
Cj4gDQo+ID4gLS0tDQo+ID4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg4MTAwLWNs
ay5kdHNpIHwgMTgwICsrKysrKysrKysrKysrKysrKysNCj4gPiAgYXJjaC9yaXNjdi9ib290L2R0
cy9zdGFyZml2ZS9qaDgxMDAuZHRzaSAgICAgfCAxMTUgKysrKysrKysrKysrDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMjk1IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg4MTAwLWNsay5kdHNpDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtY2xrLmR0c2kgYi9h
cmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1jbGsuZHRzaQ0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4yN2JhMjQ5ZjUyM2UNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgx
MDAtY2xrLmR0c2kNCj4gPiBAQCAtMCwwICsxLDE4MCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQNCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChD
KSAyMDIzIFN0YXJGaXZlIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqLw0KPiA+ICsNCj4g
PiArLyB7DQo+ID4gKwljbGtfb3NjOiBjbGtfb3NjIHsNCj4gDQo+IE5vIHVuZGVyc2NvcmVzIGlu
IG5vZGUgbmFtZXMuDQpOb3RlZC4NCj4gDQo+ID4gKwkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9j
ayI7DQo+ID4gKwkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiA+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9
IDwyNDAwMDAwMD47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAuZHRzaSBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvc3RhcmZpdmUvamg4MTAwLmR0c2kNCj4gPiBpbmRleCBmMjZhZmY1YzFkZGYu
Ljk4NjNjNjEzMjRhMCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJm
aXZlL2poODEwMC5kdHNpDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9q
aDgxMDAuZHRzaQ0KPiA+IEBAIC00LDYgKzQsOSBAQA0KPiA+ICAgKi8NCj4gPg0KPiA+ICAvZHRz
LXYxLzsNCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1j
cmcuaD4NCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Jlc2V0L3N0YXJmaXZlLGpoODEwMC1j
cmcuaD4NCj4gPiArI2luY2x1ZGUgImpoODEwMC1jbGsuZHRzaSINCj4gPg0KPiA+ICAvIHsNCj4g
PiAgCWNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg4MTAwIjsNCj4gPiBAQCAtMzU3LDYgKzM2MCwx
MDQgQEAgdWFydDQ6IHNlcmlhbEAxMjFhMDAwMCAgew0KPiA+ICAJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiA+ICAJCX07DQo+ID4NCj4gPiArCQlzeXNjcmdfbmU6IHN5c2NyZ19uZUAxMjMyMDAw
MCB7DQo+IA0KPiBjbG9jay1jb250cm9sbGVyQA0KPiANCj4gSnVzdCBvcGVuIHlvdXIgYmluZGlu
Z3MgYW5kIHRha2UgYSBsb29rIGhvdyBpdCBpcyBkb25lIHRoZXJlLi4uDQo+IA0KPiBUaGlzIGFw
cGxpZXMgZXZlcnl3aGVyZQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
