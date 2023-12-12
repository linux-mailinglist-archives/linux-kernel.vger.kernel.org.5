Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D35B80E26C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbjLLCvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLCvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:51:18 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FB9C7;
        Mon, 11 Dec 2023 18:51:24 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3B9C78080;
        Tue, 12 Dec 2023 10:51:16 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:51:16 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:51:15 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 12 Dec 2023 10:51:15 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
Thread-Index: AQHaKDqra6wATad1nUKrJTE2u0DzTrCfE7aAgAAV1gCABdHvcA==
Date:   Tue, 12 Dec 2023 02:51:15 +0000
Message-ID: <d852894e10cb49e0ba4f991bf3378191@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-17-jeeheng.sia@starfivetech.com>
 <CAJM55Z9bik1QttBeFUCfM3N98HWURge7mgV7ohFBq+AsuvtROg@mail.gmail.com>
 <9880fbbf-c311-4b6b-a570-aafd61729446@linaro.org>
In-Reply-To: <9880fbbf-c311-4b6b-a570-aafd61729446@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwg
RGVjZW1iZXIgOSwgMjAyMyAxOjU4IEFNDQo+IFRvOiBFbWlsIFJlbm5lciBCZXJ0aGluZyA8ZW1p
bC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbT47IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNp
YUBzdGFyZml2ZXRlY2guY29tPjsga2VybmVsQGVzbWlsLmRrOw0KPiBjb25vckBrZXJuZWwub3Jn
OyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsg
cGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+IGFvdUBlZWNz
LmJlcmtlbGV5LmVkdTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lkQGtlcm5lbC5vcmc7
IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IEhhbCBGZW5nDQo+IDxoYWwuZmVuZ0BzdGFyZml2ZXRl
Y2guY29tPjsgWGluZ3l1IFd1IDx4aW5neXUud3VAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gQ2M6IGxp
bnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3Jn
OyBMZXlmb29uIFRhbg0KPiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MSAxNi8xNl0gcmlzY3Y6IGR0czogc3RhcmZpdmU6IGpoODEwMDogQWRk
IGNsb2NrcyBhbmQgcmVzZXRzIG5vZGVzDQo+IA0KPiBPbiAwOC8xMi8yMDIzIDE3OjM5LCBFbWls
IFJlbm5lciBCZXJ0aGluZyB3cm90ZToNCj4gPiBTaWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4+IEFk
ZCBTWVNDUkcvU1lTQ1JHLU5FL1NZU0NSRy1OVy9TWVNDUkctU1cvQU9OQ1JHIGNsb2NrIGFuZCBy
ZXNldA0KPiA+PiBub2RlcyBmb3IgSkg4MTAwIFJJU0MtViBTb0MuDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4g
Pj4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPj4gLS0tDQo+ID4+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1j
bGsuZHRzaSB8IDE4MCArKysrKysrKysrKysrKysrKysrDQo+ID4+ICBhcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL3N0YXJmaXZlL2poODEwMC5kdHNpICAgICB8IDExNSArKysrKysrKysrKysNCj4gPg0KPiA+
IFdoeSB0aGUgc3BsaXQgaGVyZT8gSSBtZWFuIHdoeSBjYW4ndCB0aGUgY2xvY2tzIGp1c3QgYmUg
aW4gdGhlIGpoODEwMC5kdHNpPw0KPiANCj4gVGhlcmUgc2hvdWxkIGJlLiBXaGF0J3MgdGhlIHBv
aW50PyBDbG9ja3MgYXJlIGludGVybmFsIHBhcnQgb2YgU29DIGFuZA0KPiBub3QgcmVhbGx5IHJl
LXVzYWJsZSBwaWVjZSBvZiBoYXJkd2FyZS4NCkNhbiBtb3ZlIGl0IGJhY2sgdG8gdGhlIFNvQy5k
dHNpDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
