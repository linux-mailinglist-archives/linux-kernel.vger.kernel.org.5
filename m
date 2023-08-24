Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E7786C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjHXKFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjHXKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:05:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DCAB198A;
        Thu, 24 Aug 2023 03:05:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37OA50PX0003424, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37OA50PX0003424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 18:05:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 24 Aug 2023 18:05:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Aug 2023 18:05:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 18:05:21 +0800
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
Thread-Index: AQHZ1ONxPQNQ8ikjYkmsM4V64Zamr6/17aQAgAMBw+D//4itAIAAj2Mw//+WrQCAAIcBcP//jWIAABDd9xA=
Date:   Thu, 24 Aug 2023 10:05:21 +0000
Message-ID: <671154b1b4aa4e3eaa33c53e67d1c641@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <20230822102846.4683-2-stanley_chang@realtek.com>
 <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
 <ca406c19e59145fd9e7e035ea5ad3eeb@realtek.com>
 <50ce8e71-613e-1ef5-0c23-67a2f6f78949@linaro.org>
 <1390ad28e50f493fa72209fe29b7f3f4@realtek.com>
 <5894c8db-4b85-e7dd-e894-33aa8a448153@linaro.org>
 <7e34f4bfd15244ac95e68ee2372ac0de@realtek.com>
 <b06c6161-0143-f1fe-2ea8-4c54ed824595@linaro.org>
In-Reply-To: <b06c6161-0143-f1fe-2ea8-4c54ed824595@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoNCj4gT24gMjQvMDgvMjAyMyAxMToyMywgU3RhbmxleSBDaGFuZ1vm
mIzogrLlvrddIHdyb3RlOg0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gQW5kIEkgd2lsbCBhZGQg
4oCcY29ubmVjdG9y4oCdIHRvIHRoZSB0aXRsZS4NCj4gPj4+Pj4gdGl0bGU6IFJlYWx0ZWsgREhD
IFJURCBTb0NzIFVTQiBUeXBlLUMgQ29ubmVjdG9yIGRldGVjdGlvbg0KPiA+Pj4+DQo+ID4+Pj4g
U28gdXNiLi4uDQo+ID4+Pg0KPiA+Pj4gSSByZWZlciB0byB0aGlzIGJpbmRpbmcsIGFuZCBpdCBp
cyBpbiBmb2xkZXIgYmluZGluZ3MvZXh0Y29uLg0KPiA+Pj4gZG9jcy9kZXZpY2V0cmVlL2JpbmRp
bmdzL2V4dGNvbi9leHRjb24tdXNiYy1jcm9zLWVjLnlhbWwNCj4gPj4+IFRpdGxlOiBDaHJvbWVP
UyBFQyBVU0IgVHlwZS1DIENhYmxlIGFuZCBBY2Nlc3NvcnkgRGV0ZWN0aW9uDQo+ID4+DQo+ID4+
IFNvIG1heWJlIGl0IHNob3VsZCBiZSBtb3ZlZCBhcyB3ZWxsPw0KPiA+Pg0KPiA+PiBleHRjb24g
aXMgYSBMaW51eCBmcmFtZXdvcmsuIElmIHlvdSB0aGluayBleHRjb24gaXMgYSB0eXBlIG9mDQo+
ID4+IGhhcmR3YXJlLCB0aGVuIHBsZWFzZSB0ZWxsIG1lIHdoYXQgaXQgaXMgZXhhY3RseS4gUGxl
YXNlIGRlZmluZSBpdC4NCj4gPj4gQW5kIHRoZW4gSSB3b25kZXIgd2h5IHRoZSBuYW1lICJleHRj
b24iIGlzIGFueWhvdyBjb25uZWN0ZWQgdG8gVHlwZS1DDQo+IFVTQi4NCj4gPj4NCj4gPg0KPiA+
IFdlbGwsIGZyb20gbXkgcG9pbnQgb2Ygdmlldy4gZXh0Y29uIHN0YW5kcyBmb3IgRXh0ZXJuYWwg
Q29ubmVjdG9yLg0KPiANCj4gRm9yIGNvbm5lY3RvcnMgd2UgaGF2ZSBzZXBhcmF0ZSBkaXJlY3Rv
cnkgLSBjb25uZWN0b3IuIFNvIG5vLCBpdCBpcyBub3QgYW4NCj4gZXh0ZXJuYWwgY29ubmVjdG9y
Lg0KPiANCj4gQW55d2F5IHR5cGUgImV4dGVybmFsIGNvbm5lY3RvciIgdG8gV2lraXBlZGlhIG9y
IHNvbWUgaGFyZHdhcmUNCj4gbWFudWZhY3R1cmVyIHdlYnNpdGUgYW5kIGZpbmQgbWUgZXhhbXBs
ZXMgb2Ygc3VjaCBoYXJkd2FyZS4gSXQgZG9lcyBub3QNCj4gZXhpc3QuDQo+IA0KPiA+IEhETUkg
Y29ubmVjdG9yLCBtaWNybyBVU0IgY29ubmVjdG9yLCB0eXBlLWMgY29ubmVjdG9yIGFyZSBhbGwg
YSBraW5kIG9mDQo+IGhhcmR3YXJlLCB0aGV5IGFyZSBleHRlcm5hbCBjb25uZWN0b3JzLg0KPiAN
Cj4gWW91IGRpZCBub3Qgd3JpdGUgaGVyZSBiaW5kaW5ncyBmb3IgY29ubmVjdG9yLi4uDQo+IA0K
PiA+IEkgdGhpbmsgdGhlIFR5cGUtQyBjb25uZWN0b3IgaXMgYSBraW5kIG9mIGV4dGNvbi4NCj4g
DQo+IFRoZXJlIGlzIG5vIHN1Y2ggdGhpbmcgYXMgZXh0Y29uLiBPdGhlcndpc2UgcGxlYXNlIHNo
b3cgbWUgZGF0YXNoZWV0cyB1c2luZw0KPiB0aGlzIG5hbWUuIFNob3cgbWUgV2lraXBlZGlhIGFy
dGljbGUuDQo+IA0KPiA+IE9mIGNvdXJzZSwgSSBhZ3JlZSB0aGF0IFR5cGUtQyBpcyBwYXJ0IG9m
IFVTQi4NCj4gPg0KPiA+IFNvIHRoaXMgYmluZGluZyBjYW4gYmUgdXNiIG9yIGV4dGNvbiwgSSBk
b24ndCB0aGluayBpdCBpcyBzdHJpY3RseSByZXN0cmljdGVkLg0KPiANCg0KV2VsbH4NCkkgaGF2
ZSBubyBwb3NpdGlvbiB0byBhcmd1ZSB0aGlzIGlzc3VlLg0KSSBhZ3JlZSB0byBtb3ZlIHRoaXMg
YmluZGluZyB0byB1c2IgZGlyZWN0b3J5DQpCdXQgd2hhdCdzIHVwIHdpdGggdGhpcyBkaXJlY3Rv
cnkgIkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9leHRjb24vIiA/DQpXaGF0IGJp
bmRpbmcgY2FuIGJlIHBsYWNlZCBpbiB0aGlzIGRpcmVjdG9yeT8NCg0KVGhhbmtzLA0KU3Rhbmxl
eQ0K
