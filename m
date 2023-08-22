Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDC783B03
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjHVHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjHVHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:34:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC9B133;
        Tue, 22 Aug 2023 00:34:28 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37M79e232008175, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37M79e232008175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 15:09:41 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 15:10:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 22 Aug 2023 15:10:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 22 Aug 2023 15:10:02 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC DWC3 USB
Thread-Topic: [PATCH v4 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC
 DWC3 USB
Thread-Index: AQHZz16KCOHUUw9ObkCEILwScSxkD6/0piMAgAFJm0A=
Date:   Tue, 22 Aug 2023 07:10:02 +0000
Message-ID: <a2dc3ff4fe714f4a8463e3be65cd362c@realtek.com>
References: <20230815095452.4146-1-stanley_chang@realtek.com>
 <20230815095452.4146-2-stanley_chang@realtek.com>
 <20230821192716.GA2128469-robh@kernel.org>
In-Reply-To: <20230821192716.GA2128469-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgdXNiQDk4MDEz
ZTAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gInJlYWx0ZWsscnRkMTMxOWQtZHdjMyIs
ICJyZWFsdGVrLHJ0ZC1kd2MzIjsNCj4gPiArICAgICAgICByZWcgPSA8MHg5ODAxM2UwMCAweDE0
MD4sIDwweDk4MDEzZjYwIDB4ND47DQo+IA0KPiBUaGVzZSBsb29rIGxpa2UgcmVnaXN0ZXJzIGlu
IHNvbWUgb3RoZXIgYmxvY2sgcmF0aGVyIHRoYW4gYSBzdGFuZGFsb25lIHdyYXBwZXINCj4gYmxv
Y2suIEFyZSB0aGVzZSBwYXJ0IG9mIHNvbWUgc3lzY29uIGJsb2NrPyBJZiBzbywgSSBkb24ndCB0
aGluayBhIHdyYXBwZXIgbm9kZQ0KPiBpcyB0aGUgcmlnaHQgYXBwcm9hY2ggaGVyZSwgYnV0IGEg
cGhhbmRsZSB0byB0aGUgc3lzY29uIHdvdWxkIGJlIGluc3RlYWQuDQo+IA0KVGhleSBhcmUgdGhl
IHNhbWUgYmxvY2sgb2YgcmVnaXN0ZXJzLg0KV2UgaGF2ZSB0aHJlZSBkd2MzIGNvbnRyb2xsZXJz
IGluIG9uZSBTb0MuIFRoZSByZWdpc3RlciB3cmFwcGVyIGlzIGxvY2F0ZWQgYXQNClVTQjEuIDB4
OTgwMTMyMDAgdG8gMHg5ODAxMzNmZg0KVVNCMi4gMHg5ODAxM2MwMCB0byAweDk4MDEzZGZmDQpV
U0IzLiAweDk4MDEzZTAwIHRvIDB4OTgwMTNmZmYNCg0KV2h5IGFyZSB0aGV5IHNwbGl0IGludG8g
dHdvIGJsb2Nrcz8NClNpbmNlIFVTQl9EQlVTX1BXUl9DVFJMX1JFRyBoYXMgYSBkaWZmZXJlbnQg
b2Zmc2V0IGF0IHVzYjEgKDB4MTY0KSB0aGFuIG90aGVyIFVTQnMgKDB4MTYwKS4NCldlIHNwbGl0
IHR3byBibG9ja3Mgb25lIDB4OTgwMTMyMDAgdG8gMHg5ODAxMzMzZiBhbmQgb25lIDB4OTgwMTMz
NjQgdG8gMHg5ODAxMzM2NywgdG8gc29sdmUgdGhpcyBxdWVzdGlvbi4NCg0KPiBGcm9tIHRoZSBy
ZWdpc3RlciBkZWZpbml0aW9ucywgbXVjaCBvZiBpdCBsb29rcyBwaHkgcmVsYXRlZCwgYnV0IHRo
aXMgaXMgbm90IHBhcnQNCj4gb2YgdGhlIHBoeXM/DQoNCkluIG91ciBoYXJkd2FyZSBkZXNpZ24s
IHRoZXNlIHBoeSBzZXR0aW5ncyBhcmUgbG9jYXRpb24gdGhlIHJlZ2lzdGVyIG9mIHdyYXBwZXIu
DQoNClRoYW5rcywNClN0YW5sZXkNCg0KPiANCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICByYW5n
ZXM7DQo+ID4gKw0KPiA+ICsgICAgICAgIHVzYkA5ODA1MDAwMCB7DQo+ID4gKyAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAic25wcyxkd2MzIjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDB4OTgw
NTAwMDAgMHg5MDAwPjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwwIDk0IDQ+Ow0K
PiA+ICsgICAgICAgICAgICBwaHlzID0gPCZ1c2IycGh5ICZ1c2IzcGh5PjsNCj4gPiArICAgICAg
ICAgICAgcGh5LW5hbWVzID0gInVzYjItcGh5IiwgInVzYjMtcGh5IjsNCj4gPiArICAgICAgICAg
ICAgZHJfbW9kZSA9ICJvdGciOw0KPiA+ICsgICAgICAgICAgICB1c2Itcm9sZS1zd2l0Y2g7DQo+
ID4gKyAgICAgICAgICAgIHJvbGUtc3dpdGNoLWRlZmF1bHQtbW9kZSA9ICJob3N0IjsNCj4gPiAr
ICAgICAgICAgICAgc25wcyxkaXNfdTJfc3VzcGh5X3F1aXJrOw0KPiA+ICsgICAgICAgICAgICBz
bnBzLHBhcmttb2RlLWRpc2FibGUtc3MtcXVpcms7DQo+ID4gKyAgICAgICAgICAgIHNucHMscGFy
a21vZGUtZGlzYWJsZS1ocy1xdWlyazsNCj4gPiArICAgICAgICAgICAgbWF4aW11bS1zcGVlZCA9
ICJoaWdoLXNwZWVkIjsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCj4gPiAtLQ0KDQo=
