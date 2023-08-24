Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40F786BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjHXJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbjHXJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:25:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA150E7F;
        Thu, 24 Aug 2023 02:24:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37O9NQdzC010181, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37O9NQdzC010181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 17:23:26 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 24 Aug 2023 17:23:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Aug 2023 17:23:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 17:23:48 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC Type-C
Thread-Topic: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC
 Type-C
Thread-Index: AQHZ1ONxPQNQ8ikjYkmsM4V64Zamr6/17aQAgAMBw+D//4itAIAAj2Mw//+WrQCAAIcBcA==
Date:   Thu, 24 Aug 2023 09:23:48 +0000
Message-ID: <7e34f4bfd15244ac95e68ee2372ac0de@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <20230822102846.4683-2-stanley_chang@realtek.com>
 <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
 <ca406c19e59145fd9e7e035ea5ad3eeb@realtek.com>
 <50ce8e71-613e-1ef5-0c23-67a2f6f78949@linaro.org>
 <1390ad28e50f493fa72209fe29b7f3f4@realtek.com>
 <5894c8db-4b85-e7dd-e894-33aa8a448153@linaro.org>
In-Reply-To: <5894c8db-4b85-e7dd-e894-33aa8a448153@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+
IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjQsIDIwMjMgNDo0MyBQTQ0KPiBUbzogU3RhbmxleSBD
aGFuZ1vmmIzogrLlvrddIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPjsgTXl1bmdKb28gSGFt
DQo+IDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQo+IENjOiBDaGFud29vIENob2kgPGN3MDAu
Y2hvaUBzYW1zdW5nLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBL
cnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+
OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxIDIvMl0gZHQtYmluZGluZ3M6IGV4dGNvbjogQWRkIFJlYWx0ZWsgREhDIFJURCBT
b0MNCj4gVHlwZS1DDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4gT24g
MjQvMDgvMjAyMyAwOToyMywgU3RhbmxleSBDaGFuZ1vmmIzogrLlvrddIHdyb3RlOg0KPiA+IEhp
IEtyenlzenRvZiwNCj4gPg0KPiA+Pj4+PiArDQo+ID4+Pj4+ICt0aXRsZTogUmVhbHRlayBESEMg
UlREIFNvQ3MgVVNCIFR5cGUtQyBkZXRlY3Rpb24NCj4gPj4+Pg0KPiA+Pj4+IFR5cGUtYyB1c3Vh
bGx5IGdvIHRvIHVzYiBkaXJlY3RvcnkuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBiaW5kaW5nIGlzIG5v
dCBmb3IgYSB0eXBlLWMgY29udHJvbGxlci4NCj4gPj4+IEl0IGlzIGFuIGV4dGNvbiBkZXZpY2Ug
Zm9yIHR5cGUtYyBjb25uZWN0b3IgZGV0ZWN0aW9uLg0KPiA+Pj4gU28gSSBwdXQgaXQgYXQgZXh0
Y29uIGRpcmVjdG9yeS4NCj4gPj4NCj4gPj4gSWYgdGhpcyBpcyBub3QgYSB0eXBlLWMgY29udHJv
bGxlciwgdGhlbiB3aGF0IGlzIGl0PyBFeHBsYWluIG1lDQo+ID4+IHBsZWFzZSB3aGF0IGlzIGFu
ICJleHRjb24gZGV2aWNlIiB3aXRob3V0IHVzaW5nIGFueSBMaW51eCBzdWJzeXN0ZW0NCj4gbmFt
aW5nLg0KPiA+DQo+ID4gU29ycnkuICJleHRjb24gZGV2aWNlIiBtYXkgYmUgdGhlIHdyb25nIG5h
bWUgSSdtIHVzaW5nLg0KPiA+DQo+ID4gQXMgZmFyIGFzIEkga25vdywgdHlwZS1jIGNvbnRyb2xs
ZXIgc3VwcG9ydHMgUEQgZGV0ZWN0aW9uLCByb2xlIGRldGVjdGlvbiwgcm9sZQ0KPiBzd2FwIGFu
ZCBjYyBjb25maWd1cmF0aW9uLg0KPiA+IEJ1dCBpbiBvdXIgU29DLCB0eXBlIGMgbW9kdWxlIG9u
bHkgc3VwcG9ydHMgcm9sZSBkZXRlY3Rpb24uDQo+ID4gU28gSSBkb24ndCB0aGluayBpdCdzIGEg
dHlwZS1jIGNvbnRyb2xsZXIuDQo+IA0KPiBTbyBtb2R1bGUgaGFuZGxpbmcgc29tZSBwYXJ0cyBv
ZiAiVHlwZS1DIiBpcyBub3QgYSAiVHlwZS1DIGNvbnRyb2xsZXIiDQo+IGJ1dCBpZiBzdWNoIG1v
ZHVsZSBoYW5kbGVzIGEgYml0IG1vcmUsIGl0IGJlY29tZXMgVHlwZS1DPw0KDQpEdWUgdG8gaGFy
ZHdhcmUgZnVuY3Rpb24gbGltaXRhdGlvbiwgaXQgY2FuJ3QgaGFuZGxlIHRoZSBmdWxsIGZ1bmN0
aW9uIG9mIHR5cGUtYy4NCg0KPiA+DQo+ID4gSSBmb3VuZCBhIHNpbWlsYXIgZHJpdmVyIGF0DQo+
ID4gZHJpdmVycy9leHRjb24vZXh0Y29uLXVzYmMtY3Jvcy1lYy5jDQo+ID4gSXQgYmVsb25ncyB0
byBFeHRlcm5hbCBDb25uZWN0b3IsIHdoaWNoIGNhbiBkZXRlY3QgVVNCIFR5cGUgQyBjYWJsZXMu
DQo+IA0KPiBUaGF0J3MgYSBkcml2ZXIsIG5vdCBhIGJpbmRpbmcuLi4NCj4gDQo+ID4NCj4gPiBT
byBvdXIgZHJpdmVyIGlzIGFuIGV4dGVybmFsIGNvbm5lY3RvciBkcml2ZXIuDQo+IA0KPiBEcml2
ZXIgeWVzLCBub3QgYmluZGluZy4NCj4gDQo+ID4NCj4gPj4+DQo+ID4+PiBBbmQgSSB3aWxsIGFk
ZCDigJxjb25uZWN0b3LigJ0gdG8gdGhlIHRpdGxlLg0KPiA+Pj4gdGl0bGU6IFJlYWx0ZWsgREhD
IFJURCBTb0NzIFVTQiBUeXBlLUMgQ29ubmVjdG9yIGRldGVjdGlvbg0KPiA+Pg0KPiA+PiBTbyB1
c2IuLi4NCj4gPg0KPiA+IEkgcmVmZXIgdG8gdGhpcyBiaW5kaW5nLCBhbmQgaXQgaXMgaW4gZm9s
ZGVyIGJpbmRpbmdzL2V4dGNvbi4NCj4gPiBkb2NzL2RldmljZXRyZWUvYmluZGluZ3MvZXh0Y29u
L2V4dGNvbi11c2JjLWNyb3MtZWMueWFtbA0KPiA+IFRpdGxlOiBDaHJvbWVPUyBFQyBVU0IgVHlw
ZS1DIENhYmxlIGFuZCBBY2Nlc3NvcnkgRGV0ZWN0aW9uDQo+IA0KPiBTbyBtYXliZSBpdCBzaG91
bGQgYmUgbW92ZWQgYXMgd2VsbD8NCj4gDQo+IGV4dGNvbiBpcyBhIExpbnV4IGZyYW1ld29yay4g
SWYgeW91IHRoaW5rIGV4dGNvbiBpcyBhIHR5cGUgb2YgaGFyZHdhcmUsIHRoZW4NCj4gcGxlYXNl
IHRlbGwgbWUgd2hhdCBpdCBpcyBleGFjdGx5LiBQbGVhc2UgZGVmaW5lIGl0LiBBbmQgdGhlbiBJ
IHdvbmRlciB3aHkgdGhlDQo+IG5hbWUgImV4dGNvbiIgaXMgYW55aG93IGNvbm5lY3RlZCB0byBU
eXBlLUMgVVNCLg0KPiANCg0KV2VsbCwgZnJvbSBteSBwb2ludCBvZiB2aWV3LiBleHRjb24gc3Rh
bmRzIGZvciBFeHRlcm5hbCBDb25uZWN0b3IuDQpIRE1JIGNvbm5lY3RvciwgbWljcm8gVVNCIGNv
bm5lY3RvciwgdHlwZS1jIGNvbm5lY3RvciBhcmUgYWxsIGEga2luZCBvZiBoYXJkd2FyZSwgdGhl
eSBhcmUgZXh0ZXJuYWwgY29ubmVjdG9ycy4NCkkgdGhpbmsgdGhlIFR5cGUtQyBjb25uZWN0b3Ig
aXMgYSBraW5kIG9mIGV4dGNvbi4NCk9mIGNvdXJzZSwgSSBhZ3JlZSB0aGF0IFR5cGUtQyBpcyBw
YXJ0IG9mIFVTQi4NCg0KU28gdGhpcyBiaW5kaW5nIGNhbiBiZSB1c2Igb3IgZXh0Y29uLCBJIGRv
bid0IHRoaW5rIGl0IGlzIHN0cmljdGx5IHJlc3RyaWN0ZWQuDQoNClRoYW5rcywNClN0YW5sZXkN
Cg0K
