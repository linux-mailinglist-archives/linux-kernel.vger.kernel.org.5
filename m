Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAF78C329
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjH2LRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjH2LQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:16:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29D93BC;
        Tue, 29 Aug 2023 04:16:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37TBG7VZ0018637, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37TBG7VZ0018637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Aug 2023 19:16:07 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 29 Aug 2023 19:15:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 29 Aug 2023 19:15:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 29 Aug 2023 19:15:49 +0800
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
Thread-Index: AQHZ1ONvA6JhKCipAECuqR11IG4J/a/5VrCAgAfQ43A=
Date:   Tue, 29 Aug 2023 11:15:49 +0000
Message-ID: <2df3dc449c894e50b126a1b6941eb4d7@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <af247603-6a8d-7c05-4342-c6f615a7f508@kernel.org>
In-Reply-To: <af247603-6a8d-7c05-4342-c6f615a7f508@kernel.org>
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

SGkgQ2hhbndvbywNCg0KPiA+ICtzdGF0aWMgaW50IHJ0ZDEyOXhfc3dpdGNoX3R5cGVfY19wbHVn
X2NvbmZpZyhzdHJ1Y3QgdHlwZV9jX2RhdGEgKnR5cGVfYywNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRyX21vZGUsIGludCBjYykNCj4gPiArew0K
PiA+ICsgICAgIHZvaWQgX19pb21lbSAqcmVnID0gdHlwZV9jLT5yZWdfYmFzZSArIFVTQl9UWVBF
Q19DVFJMX0NDMV8wOw0KPiA+ICsgICAgIGludCB2YWxfY2M7DQo+ID4gKw0KPiA+ICsjZGVmaW5l
IFRZUEVfQ19FTl9TV0lUQ0ggQklUKDI5KQ0KPiA+ICsjZGVmaW5lIFRZUEVfQ19UWFJYX1NFTCAo
QklUKDI4KSB8IEJJVCgyNykpDQo+ID4gKyNkZWZpbmUgVFlQRV9DX1NXSVRDSF9NQVNLIChUWVBF
X0NfRU5fU1dJVENIIHwgVFlQRV9DX1RYUlhfU0VMKQ0KPiA+ICsjZGVmaW5lIFRZUEVfQ19FTkFC
TEVfQ0MxIFRZUEVfQ19FTl9TV0lUQ0gNCj4gPiArI2RlZmluZSBUWVBFX0NfRU5BQkxFX0NDMiAo
VFlQRV9DX0VOX1NXSVRDSCB8IFRZUEVfQ19UWFJYX1NFTCkNCj4gPiArI2RlZmluZSBUWVBFX0Nf
RElTQUJMRV9DQyB+VFlQRV9DX1NXSVRDSF9NQVNLDQo+ID4gKw0KPiA+ICsgICAgIHZhbF9jYyA9
IHJlYWRsKHJlZyk7DQo+IA0KPiBJJ2QgbGlrZSB5b3UgdG8gdXNlIHJlZ21hcCBpbnRlcmZhY2Ug
dG8gYWNjZXNzIHRoZSByZWdpc3Rlcg0KPiBieSB1c2luZyByZWdtYXBfcmVhZCwgcmVnbWFwX3dy
aXRlLiBZb3UgY2FuIGNyZWF0ZSB0aGUgcmVnbWFwIGluc3RhbmNlDQo+IHZpYSBkZXZtX3JlZ21h
cF9pbml0X21taW8oKSBvbiBwcm9iZSBpbnN0ZWFkIG9mIHVzaW5nICd0eXBlX2MtPnJlZ19iYXNl
Jw0KPiBhdCB0aGUgbXVsdGlwZSBwb2ludC4NCj4gDQo+IEZvciBleGFtcGxlLA0KPiAgICAgICAg
IHN0cnVjdCByZWdtYXBfY29uZmlnIHJ0a19yZWdtYXBfY29uZmlnID0gew0KPiAgICAgICAgICAg
ICAgICAgLnJlZ19iaXRzID0gMzIsDQo+ICAgICAgICAgICAgICAgICAudmFsX2JpdHMgPSAzMiwN
Cj4gICAgICAgICB9Ow0KPiANCj4gICAgICAgICB2b2lkIF9faW9tZW0gKmJhc2U7DQo+IA0KPiAg
ICAgICAgIGJhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2
LCAwLCAmcmVzKTsNCj4gICAgICAgICBpZiAoSVNfRVJSKGJhc2UpKQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIFBUUl9FUlIoYmFzZSk7DQo+IA0KPiAgICAgICAgIHJlZ21hcCA9IGRldm1fcmVn
bWFwX2luaXRfbW1pbyhkZXYsIGJhc2UsDQo+ICZydGtfcmVnbWFwX2NvbmZpZyk7DQo+IA0KPiAg
ICAgICAgIC0tLQ0KPiANCj4gICAgICAgICBBbmQgdGhlbiBqdXN0IGNhbGwgcmVnbWFwX3JlYWQg
d2l0aG91dCBhbnkgY2FsY3VsYXRpb24gYmV0d2Vlbg0KPiAgICAgICAgIGJhc2UgYWRkcmVzcyBh
bmQgc3BlY2lmaWMgcmVnaXN0ZXIuDQo+IA0KPiAgICAgICAgIHJlZ21hcF9yZWFkKHJlZ21hcCwg
VVNCX1RZUEVDX0NUUkxfQ0MxXzApDQo+IA0KDQpJIHN0dWRpZWQgbW1pbydzIHJlZ21hcC4NCg0K
SXQgb25seSBjaGFuZ2VkIG9uZSBlbmNvZGluZyBtZXRob2QuIEFuZCBzaW1wbGlmaWVzIHRoZSBj
YWxjdWxhdGlvbiBiZXR3ZWVuIHRoZSBiYXNlIGFkZHJlc3MgYW5kIHRoZSBzcGVjaWZpYyByZWdp
c3Rlci4NCklmIHRoZSByZWdpc3RlciBpcyAzMi1iaXQgYWxpZ25lZCwgb3RoZXIgb3BlcmF0aW9u
cyBsb29rIHRoZSBzYW1lIGFzIHJlYWRsL3dyaXRlbC4NCkkgdGhpbmsgcmVnbWFwIGlzIG1vcmUg
c2ltcGxpZmllZCBpZiB0aGUgcmVhZCByZWdpc3RlcnMgYXJlIG5vdCAzMi1iaXQgYWxpZ25lZCwg
ZS5nLiBudm1lbSByZWFkL3dyaXRlLg0KDQpTbyBpdCB3b3VsZCBiZSBtb3JlIGludHVpdGl2ZSBm
b3IgbWUgdG8ga2VlcCB3cml0ZWwvcmVhZGwgaGVyZQ0KDQo+IA0KPiA+ICsgICAgIHZhbF9jYyAm
PSB+VFlQRV9DX1NXSVRDSF9NQVNLOw0KPiA+ICsNCj4gPiArICAgICBpZiAoY2MgPT0gRElTQUJM
RV9DQykgew0KPiA+ICsgICAgICAgICAgICAgdmFsX2NjICY9IFRZUEVfQ19ESVNBQkxFX0NDOw0K
PiA+ICsgICAgIH0gZWxzZSBpZiAoY2MgPT0gRU5BQkxFX0NDMSkgew0KPiA+ICsgICAgICAgICAg
ICAgdmFsX2NjIHw9IFRZUEVfQ19FTkFCTEVfQ0MxOw0KPiA+ICsgICAgIH0gZWxzZSBpZiAoY2Mg
PT0gRU5BQkxFX0NDMikgew0KPiA+ICsgICAgICAgICAgICAgdmFsX2NjIHw9IFRZUEVfQ19FTkFC
TEVfQ0MyOw0KPiA+ICsgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJyKHR5
cGVfYy0+ZGV2LCAiJXM6IEVycm9yIGNjIHNldHRpbmcgY2M9MHgleFxuIiwNCj4gX19mdW5jX18s
IGNjKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgIH0NCj4g
PiArICAgICB3cml0ZWwodmFsX2NjLCByZWcpOw0KPiA+ICsNCg0KVGhhbmtzLA0KU3RhbmxleQ0K
