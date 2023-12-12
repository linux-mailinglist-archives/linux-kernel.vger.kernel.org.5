Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D095680E246
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbjLLCtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjLLCtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:49:19 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67BACD;
        Mon, 11 Dec 2023 18:49:24 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8C0BB24E29B;
        Tue, 12 Dec 2023 10:49:23 +0800 (CST)
Received: from EXMBX164.cuchost.com (172.16.7.74) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:49:23 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX164.cuchost.com
 (172.16.7.74) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:49:23 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 12 Dec 2023 10:49:22 +0800
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
Subject: RE: [PATCH v1 09/16] dt-bindings: clock: Add StarFive JH8100
 System-North-East clock and reset generator
Thread-Topic: [PATCH v1 09/16] dt-bindings: clock: Add StarFive JH8100
 System-North-East clock and reset generator
Thread-Index: AQHaKDqKoxq6vdsfnUiyb3daJsHDa7CfKIsAgAXSlMA=
Date:   Tue, 12 Dec 2023 02:49:22 +0000
Message-ID: <43ea276b13764412996f5a742ae5875d@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-10-jeeheng.sia@starfivetech.com>
 <2e84e91d-ab5a-430c-9871-c2780acdc20d@linaro.org>
In-Reply-To: <2e84e91d-ab5a-430c-9871-c2780acdc20d@linaro.org>
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
RGVjZW1iZXIgOSwgMjAyMyAxOjU0IEFNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFA
c3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJr
ZWxleS5lZHU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBw
LnphYmVsQHBlbmd1dHJvbml4LmRlOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29t
OyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZv
b24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDkvMTZd
IGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIFN0YXJGaXZlIEpIODEwMCBTeXN0ZW0tTm9ydGgtRWFz
dCBjbG9jayBhbmQgcmVzZXQgZ2VuZXJhdG9yDQo+IA0KPiBPbiAwNi8xMi8yMDIzIDEyOjQ5LCBT
aWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4gQWRkIGJpbmRpbmdzIGZvciB0aGUgU3lzdGVtLU5vcnRo
LUVhc3QgY2xvY2sgYW5kIHJlc2V0IGdlbmVyYXRvcg0KPiA+IChTWVNDUkctTkUpIG9uIEpIODEw
MCBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaWEgSmVlIEhlbmcgPGplZWhlbmcuc2lh
QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9v
bi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Nsb2NrL3N0YXJmaXZl
LGpoODEwMC1zeXNjcmctbmUueWFtbCAgICAgIHwgMTU4ICsrKysrKysrKysrKysrKysNCj4gPiAg
Li4uL2R0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1jcmcuaCAgIHwgMTc5ICsrKysr
KysrKysrKysrKysrKw0KPiA+ICAuLi4vZHQtYmluZGluZ3MvcmVzZXQvc3RhcmZpdmUsamg4MTAw
LWNyZy5oICAgfCAgNjEgKysrKysrDQo+IA0KPiBBbGwgbXkgcHJldmlvdXMgY29tbWVudHMgYXJl
IGFwcGxpY2FibGUuDQpOb3RlZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Cg==
