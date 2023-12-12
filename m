Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF980E245
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbjLLCtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjLLCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:49:28 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88EBC;
        Mon, 11 Dec 2023 18:49:34 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7496424E296;
        Tue, 12 Dec 2023 10:49:32 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:49:32 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:49:31 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 12 Dec 2023 10:49:31 +0800
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
Subject: RE: [PATCH v1 13/16] dt-bindings: clock: Add StarFive JH8100
 Always-On clock and reset generator
Thread-Topic: [PATCH v1 13/16] dt-bindings: clock: Add StarFive JH8100
 Always-On clock and reset generator
Thread-Index: AQHaKDqdVOSviGovnEqA3a01E14R87CfKN+AgAXSTAA=
Date:   Tue, 12 Dec 2023 02:49:31 +0000
Message-ID: <5fb9c92072314b5c8f9f641bdae35a34@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-14-jeeheng.sia@starfivetech.com>
 <b3004665-bc22-4619-a8cb-ec69ead7e08f@linaro.org>
In-Reply-To: <b3004665-bc22-4619-a8cb-ec69ead7e08f@linaro.org>
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
RGVjZW1iZXIgOSwgMjAyMyAxOjU1IEFNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFA
c3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJr
ZWxleS5lZHU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBw
LnphYmVsQHBlbmd1dHJvbml4LmRlOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29t
OyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZv
b24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTMvMTZd
IGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIFN0YXJGaXZlIEpIODEwMCBBbHdheXMtT24gY2xvY2sg
YW5kIHJlc2V0IGdlbmVyYXRvcg0KPiANCj4gT24gMDYvMTIvMjAyMyAxMjo0OSwgU2lhIEplZSBI
ZW5nIHdyb3RlOg0KPiA+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIEFsd2F5cy1PbiBjbG9jayBhbmQg
cmVzZXQgZ2VuZXJhdG9yDQo+ID4gKEFPTkNSRykgb24gSkg4MTAwIFNvQy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4N
Cj4gPiBSZXZpZXdlZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2gu
Y29tPg0KPiANCj4gQWxsIG15IHByZXZpb3VzIGNvbW1lbnRzIGFyZSBhcHBsaWNhYmxlLg0KTm90
ZWQuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
