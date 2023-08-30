Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5341378D2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbjH3EAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbjH3D7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:59:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2426CEA;
        Tue, 29 Aug 2023 20:59:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37U3x6xrD032293, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37U3x6xrD032293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 11:59:07 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 30 Aug 2023 11:59:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 30 Aug 2023 11:59:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 30 Aug 2023 11:59:31 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Thread-Topic: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Thread-Index: AQHZ1ONvA6JhKCipAECuqR11IG4J/a/5VrCAgAfQ43CAAAOYAIABEHdg
Date:   Wed, 30 Aug 2023 03:59:31 +0000
Message-ID: <249af57804f3405f80f28879e31637b3@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <af247603-6a8d-7c05-4342-c6f615a7f508@kernel.org>
 <2df3dc449c894e50b126a1b6941eb4d7@realtek.com>
 <c70c08b4-be67-14da-be25-5473ffd0ca7d@kernel.org>
In-Reply-To: <c70c08b4-be67-14da-be25-5473ffd0ca7d@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hhbndvbywNCg0KPiA+Pj4gKyNkZWZpbmUgVFlQRV9DX0VOX1NXSVRDSCBCSVQoMjkpDQo+
ID4+PiArI2RlZmluZSBUWVBFX0NfVFhSWF9TRUwgKEJJVCgyOCkgfCBCSVQoMjcpKSAjZGVmaW5l
DQo+ID4+PiArVFlQRV9DX1NXSVRDSF9NQVNLIChUWVBFX0NfRU5fU1dJVENIIHwgVFlQRV9DX1RY
UlhfU0VMKQ0KPiAjZGVmaW5lDQo+ID4+PiArVFlQRV9DX0VOQUJMRV9DQzEgVFlQRV9DX0VOX1NX
SVRDSCAjZGVmaW5lDQo+IFRZUEVfQ19FTkFCTEVfQ0MyDQo+ID4+PiArKFRZUEVfQ19FTl9TV0lU
Q0ggfCBUWVBFX0NfVFhSWF9TRUwpICNkZWZpbmUgVFlQRV9DX0RJU0FCTEVfQ0MNCj4gPj4+ICt+
VFlQRV9DX1NXSVRDSF9NQVNLDQo+ID4+PiArDQo+ID4+PiArICAgICB2YWxfY2MgPSByZWFkbChy
ZWcpOw0KPiA+Pg0KPiA+PiBJJ2QgbGlrZSB5b3UgdG8gdXNlIHJlZ21hcCBpbnRlcmZhY2UgdG8g
YWNjZXNzIHRoZSByZWdpc3RlciBieSB1c2luZw0KPiA+PiByZWdtYXBfcmVhZCwgcmVnbWFwX3dy
aXRlLiBZb3UgY2FuIGNyZWF0ZSB0aGUgcmVnbWFwIGluc3RhbmNlIHZpYQ0KPiA+PiBkZXZtX3Jl
Z21hcF9pbml0X21taW8oKSBvbiBwcm9iZSBpbnN0ZWFkIG9mIHVzaW5nICd0eXBlX2MtPnJlZ19i
YXNlJw0KPiA+PiBhdCB0aGUgbXVsdGlwZSBwb2ludC4NCj4gPj4NCj4gPj4gRm9yIGV4YW1wbGUs
DQo+ID4+ICAgICAgICAgc3RydWN0IHJlZ21hcF9jb25maWcgcnRrX3JlZ21hcF9jb25maWcgPSB7
DQo+ID4+ICAgICAgICAgICAgICAgICAucmVnX2JpdHMgPSAzMiwNCj4gPj4gICAgICAgICAgICAg
ICAgIC52YWxfYml0cyA9IDMyLA0KPiA+PiAgICAgICAgIH07DQo+ID4+DQo+ID4+ICAgICAgICAg
dm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+Pg0KPiA+PiAgICAgICAgIGJhc2UgPSBkZXZtX3BsYXRm
b3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLA0KPiAmcmVzKTsNCj4gPj4gICAg
ICAgICBpZiAoSVNfRVJSKGJhc2UpKQ0KPiA+PiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9F
UlIoYmFzZSk7DQo+ID4+DQo+ID4+ICAgICAgICAgcmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9t
bWlvKGRldiwgYmFzZSwNCj4gPj4gJnJ0a19yZWdtYXBfY29uZmlnKTsNCj4gPj4NCj4gPj4gICAg
ICAgICAtLS0NCj4gPj4NCj4gPj4gICAgICAgICBBbmQgdGhlbiBqdXN0IGNhbGwgcmVnbWFwX3Jl
YWQgd2l0aG91dCBhbnkgY2FsY3VsYXRpb24gYmV0d2Vlbg0KPiA+PiAgICAgICAgIGJhc2UgYWRk
cmVzcyBhbmQgc3BlY2lmaWMgcmVnaXN0ZXIuDQo+ID4+DQo+ID4+ICAgICAgICAgcmVnbWFwX3Jl
YWQocmVnbWFwLCBVU0JfVFlQRUNfQ1RSTF9DQzFfMCkNCj4gPj4NCj4gPg0KPiA+IEkgc3R1ZGll
ZCBtbWlvJ3MgcmVnbWFwLg0KPiA+DQo+ID4gSXQgb25seSBjaGFuZ2VkIG9uZSBlbmNvZGluZyBt
ZXRob2QuIEFuZCBzaW1wbGlmaWVzIHRoZSBjYWxjdWxhdGlvbg0KPiBiZXR3ZWVuIHRoZSBiYXNl
IGFkZHJlc3MgYW5kIHRoZSBzcGVjaWZpYyByZWdpc3Rlci4NCj4gDQo+IFRoZSByZWdtYXAgcHJv
dmlkZXMgdGhlIGNvbnNpc3RlbnQgaW50ZXJmYWNlIHRvIGFjY2VzcyByZWdpc3RlciByZWdhcmRs
ZXNzIG9mDQo+IG1taW8vaTJjL3NwaSBhbmQgc28gb24uIEl0IGlzIHRoZSBhZHZhbnRhZ2Ugb2Yg
cmVnbWFwLg0KPiANCj4gQW5kIHJlZ21hcCBwcm92aWRlcyB0aGUgbGlrZSByZWdpc3RlciBkdW1w
IHZpYSBkZWJ1Z2ZzLCBpcyBhYmxlIHRvIHNwZWNpZnkgdGhlDQo+IGtpbmQgb2YgcmVnaXN0ZXIg
bGlrZSB3cml0YWJsZSwgcmVhZGFibGUsIHZvbGF0aWxlIHR5cGUuDQo+IEl0IGlzIHBvc3NpYmxl
IHRvIHNwZWNpZnkgdGhlIG1vcmUgZGV0YWlsZWQgcmVnaXN0ZXIgaW5mb3JtYXRpb24gaW4gZGV2
aWNlIGRyaXZlcg0KPiBpbiBvcmRlciB0byBpbXByb3ZlIHRoZSByZWFkYWJpbGl0eS4gSXQgYWxs
b3dzIHlvdSB0byBleHByZXNzIG1vcmUgZGV0YWlsIG9mIHRoaXMNCj4gZGV2aWNlIHRoYW4ganVz
dCB3b3JraW5nLg0KDQpUaGVzZSBhcmUgYWxsIGFkdmFudGFnZXMgb2YgcmVnbWFwLCBJIGFncmVl
Lg0KSSBoYXZlbid0IGRlbHZlZCBpbnRvIHJlZ21hcCB5ZXQuDQoNCj4gDQo+ID4gSWYgdGhlIHJl
Z2lzdGVyIGlzIDMyLWJpdCBhbGlnbmVkLCBvdGhlciBvcGVyYXRpb25zIGxvb2sgdGhlIHNhbWUg
YXMNCj4gcmVhZGwvd3JpdGVsLg0KPiA+IEkgdGhpbmsgcmVnbWFwIGlzIG1vcmUgc2ltcGxpZmll
ZCBpZiB0aGUgcmVhZCByZWdpc3RlcnMgYXJlIG5vdCAzMi1iaXQgYWxpZ25lZCwNCj4gZS5nLiBu
dm1lbSByZWFkL3dyaXRlLg0KPiANCj4gSSdtIHNvcnJ5LiBJIGRvbid0IHVuZGVyc3RhbmQgb2Yg
d2hhdCBpcyBhY2N1cmF0ZSBtZWFuaW5nLg0KPiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4geW91
ciBvcGluaW9uIG1vcmUgZGV0YWlsZWQgd2l0aCBleGFtcGxlIG9mIHRoaXMNCj4gcGF0Y2g/DQoN
ClNvcnJ5LCBJIG1pc3VuZGVyc3Rvb2QgcmVnbWFwLCBJIHRob3VnaHQgaGUgY291bGQgcmVhZCBy
ZWdpc3RlciBsaWtlIHJlYWQgb3RwIHRhYmxlcyBieSBudm1lbSByZWdhcmRsZXNzIG9mIGhpcyBi
aXRuZXNzIGFuZCBzaXplLg0KU28gbXkgYW5zd2VyIHNob3VsZCBiZSBpbmNvcnJlY3QuDQoNClRo
YW5rLA0KU3RhbmxleQ0K
