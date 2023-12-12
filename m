Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF280E88E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbjLLKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:03:54 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA395;
        Tue, 12 Dec 2023 02:03:54 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9052324DC33;
        Tue, 12 Dec 2023 18:03:46 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 18:03:46 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 12 Dec 2023 18:03:46 +0800
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
Thread-Index: AQHaKDqra6wATad1nUKrJTE2u0DzTrCfKVUAgAXSX4D//9xUAIAAnDaw
Date:   Tue, 12 Dec 2023 10:03:46 +0000
Message-ID: <6628627a60a4490ba887d9a89add3330@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-17-jeeheng.sia@starfivetech.com>
 <4dd53599-5e80-4a00-a708-507c9c2e7b6b@linaro.org>
 <62705afb652e416695aa26e3bdb2500e@EXMBX066.cuchost.com>
 <e8c60424-21c7-4f64-9e47-8c4183510162@linaro.org>
In-Reply-To: <e8c60424-21c7-4f64-9e47-8c4183510162@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [175.136.135.142]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAxMiwgMjAyMyA0OjQ0IFBNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFA
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
cw0KPiANCj4gT24gMTIvMTIvMjAyMyAwMzo1OCwgSmVlSGVuZyBTaWEgd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6IFNh
dHVyZGF5LCBEZWNlbWJlciA5LCAyMDIzIDE6NTcgQU0NCj4gPj4gVG86IEplZUhlbmcgU2lhIDxq
ZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsga2VybmVsQGVzbWlsLmRrOyBjb25vckBrZXJu
ZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZzsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207
IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gPj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNi
b3lkQGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGVtaWwucmVubmVyLmJlcnRo
aW5nQGNhbm9uaWNhbC5jb207IEhhbCBGZW5nDQo+ID4+IDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2gu
Y29tPjsgWGluZ3l1IFd1IDx4aW5neXUud3VAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4gQ2M6IGxp
bnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3Jn
OyBMZXlmb29uDQo+IFRhbg0KPiA+PiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxNi8xNl0gcmlzY3Y6IGR0czogc3RhcmZpdmU6IGpo
ODEwMDogQWRkIGNsb2NrcyBhbmQgcmVzZXRzIG5vZGVzDQo+ID4+DQo+ID4+IE9uIDA2LzEyLzIw
MjMgMTI6NTAsIFNpYSBKZWUgSGVuZyB3cm90ZToNCj4gPj4+IEFkZCBTWVNDUkcvU1lTQ1JHLU5F
L1NZU0NSRy1OVy9TWVNDUkctU1cvQU9OQ1JHIGNsb2NrIGFuZCByZXNldA0KPiA+Pj4gbm9kZXMg
Zm9yIEpIODEwMCBSSVNDLVYgU29DLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNpYSBK
ZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4+IFJldmlld2VkLWJ5
OiBMZXkgRm9vbiBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4+DQo+ID4+
IFJlYWxseT8gTG9va3MgYXV0b21hdGVkLi4uIENhcmUgdG8gcHJvdmlkZSBhbnkgbGlua3MgdG8g
ZWZmZWN0cyBvZg0KPiA+PiBpbnRlcm5hbCByZXZpZXc/DQo+ID4gaHR0cHM6Ly9naXRsYWIuc3Rh
cmZpdmV0ZWNoLmNvbS9qZWVoZW5nLnNpYS9saW51eC8tL2NvbW1pdHMvSkg4MTAwX1Vwc3RyZWFt
Lw0KPiA+Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9q
aDgxMDAtY2xrLmR0c2kgfCAxODAgKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gIGFyY2gvcmlz
Y3YvYm9vdC9kdHMvc3RhcmZpdmUvamg4MTAwLmR0c2kgICAgIHwgMTE1ICsrKysrKysrKysrKw0K
PiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMjk1IGluc2VydGlvbnMoKykNCj4gPj4+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtY2xrLmR0c2kN
Cj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9q
aDgxMDAtY2xrLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1jbGsu
ZHRzaQ0KPiA+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uMjdiYTI0OWY1MjNlDQo+ID4+PiAtLS0gL2Rldi9udWxsDQo+ID4+PiArKysgYi9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1jbGsuZHRzaQ0KPiA+Pj4gQEAgLTAsMCArMSwx
ODAgQEANCj4gPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQN
Cj4gPj4+ICsvKg0KPiA+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBTdGFyRml2ZSBUZWNobm9s
b2d5IENvLiwgTHRkLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gKw0KPiA+Pj4gKy8gew0KPiA+Pj4gKwlj
bGtfb3NjOiBjbGtfb3NjIHsNCj4gPj4NCj4gPj4gTm8gdW5kZXJzY29yZXMgaW4gbm9kZSBuYW1l
cy4NCj4gPiBOb3RlZC4NCj4gPj4NCj4gPj4+ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2si
Ow0KPiA+Pj4gKwkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiA+Pj4gKwkJY2xvY2stZnJlcXVlbmN5
ID0gPDI0MDAwMDAwPjsNCj4gPj4+ICsJfTsNCj4gPj4+ICsNCj4gPj4NCj4gPj4gLi4uDQo+ID4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAu
ZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg4MTAwLmR0c2kNCj4gPj4+IGlu
ZGV4IGYyNmFmZjVjMWRkZi4uOTg2M2M2MTMyNGEwIDEwMDY0NA0KPiA+Pj4gLS0tIGEvYXJjaC9y
aXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAuZHRzaQ0KPiA+Pj4gKysrIGIvYXJjaC9yaXNj
di9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAuZHRzaQ0KPiA+Pj4gQEAgLTQsNiArNCw5IEBADQo+
ID4+PiAgICovDQo+ID4+Pg0KPiA+Pj4gIC9kdHMtdjEvOw0KPiA+Pj4gKyNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9jbG9jay9zdGFyZml2ZSxqaDgxMDAtY3JnLmg+DQo+ID4+PiArI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL3Jlc2V0L3N0YXJmaXZlLGpoODEwMC1jcmcuaD4NCj4gPj4+ICsjaW5jbHVkZSAi
amg4MTAwLWNsay5kdHNpIg0KPiA+Pj4NCj4gPj4+ICAvIHsNCj4gPj4+ICAJY29tcGF0aWJsZSA9
ICJzdGFyZml2ZSxqaDgxMDAiOw0KPiA+Pj4gQEAgLTM1Nyw2ICszNjAsMTA0IEBAIHVhcnQ0OiBz
ZXJpYWxAMTIxYTAwMDAgIHsNCj4gPj4+ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+Pj4g
IAkJfTsNCj4gPj4+DQo+ID4+PiArCQlzeXNjcmdfbmU6IHN5c2NyZ19uZUAxMjMyMDAwMCB7DQo+
ID4+DQo+ID4+IGNsb2NrLWNvbnRyb2xsZXJADQo+ID4+DQo+ID4+IEp1c3Qgb3BlbiB5b3VyIGJp
bmRpbmdzIGFuZCB0YWtlIGEgbG9vayBob3cgaXQgaXMgZG9uZSB0aGVyZS4uLg0KPiA+Pg0KPiA+
PiBUaGlzIGFwcGxpZXMgZXZlcnl3aGVyZQ0KPiANCj4gSSBhc3N1bWUgeW91IGRpZCBub3QgaWdu
b3JlIGFsbCB0aGUgb3RoZXIgY29tbWVudHMgeW91IGRpZCBub3QgcmVzcG9uZCB0by4NCkFyciwg
bXkgYmFkLiBXaWxsIGZpeCBpdC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Cg==
