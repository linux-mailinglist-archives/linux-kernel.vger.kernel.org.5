Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9896809EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573419AbjLHJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573418AbjLHJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:02:06 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B410FC;
        Fri,  8 Dec 2023 01:02:12 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B891c8C2772277, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B891c8C2772277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 17:01:38 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Dec 2023 17:01:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 8 Dec 2023 17:01:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 8 Dec 2023 17:01:36 +0800
From:   =?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?= <tychang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
Subject: RE: [PATCH 1/2] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC PCIe PHY
Thread-Topic: [PATCH 1/2] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC
 PCIe PHY
Thread-Index: AQHaJERyJL4rQ+THDkqbltcZ8ZneurCXQdKAgAXqHZCAAAb2gIABve4A
Date:   Fri, 8 Dec 2023 09:01:36 +0000
Message-ID: <c7dfa01f7b114d56adf8561125536580@realtek.com>
References: <20231201105207.11786-1-tychang@realtek.com>
 <20231201105207.11786-2-tychang@realtek.com>
 <01946883-e008-4b4c-8e2a-a73787ad9f23@linaro.org>
 <5e57f7b0f54d4a8aa52ed6e15a9af9f5@realtek.com>
 <c864f62e-0ac2-4e5e-83d3-28e493a6f6c0@linaro.org>
In-Reply-To: <c864f62e-0ac2-4e5e-83d3-28e493a6f6c0@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+Pj4gT24gMDEvMTIvMjAyMyAxMTo1MiwgVHp1eWkgQ2hhbmcgd3Jv
dGU6DQo+Pj4+ICsgICIjcGh5LWNlbGxzIjoNCj4+Pj4gKyAgICBjb25zdDogMA0KPj4+PiArDQo+
Pj4+ICsgIG52bWVtLWNlbGxzOg0KPj4+PiArICAgIG1heEl0ZW1zOiAxDQo+Pj4+ICsgICAgZGVz
Y3JpcHRpb246DQo+Pj4+ICsgICAgICBQaGFuZGxlIHRvIG52bWVtIGNlbGwgdGhhdCBjb250YWlu
cyAnVHggc3dpbmcgdHJpbScNCj4+Pj4gKyAgICAgIHR1bmluZyBwYXJhbWV0ZXIgdmFsdWUgZm9y
IFBDSWUgcGh5Lg0KPj4+PiArDQo+Pj4+ICsgIG52bWVtLWNlbGwtbmFtZXM6DQo+Pj4+ICsgICAg
aXRlbXM6DQo+Pj4+ICsgICAgICAtIGNvbnN0OiB0eF9zd2luZ190cmltDQo+Pj4+ICsNCj4+Pj4g
KyAgcmVhbHRlayxwY2llLXN5c2NvbjoNCj4+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+Pj4+ICsgICAgZGVzY3JpcHRpb246IHBoYW5kbGUg
b2Ygc3lzY29uIHVzZWQgdG8gY29udHJvbCBQQ0llIE1ESU8gcmVnaXN0ZXIuDQo+Pj4NCj4+PiBX
aHkgdGhpcyBkb2VzIG5vdCBoYXZlIHJlZyBwcm9wZXJ0eSBidXQgc3lzY29uPyBUaGlzIGxvb2tz
IGhhY2t5Lg0KPj4+DQo+Pg0KPj4gT3VyIFBDSWUgUEhZIGRyaXZlciBuZWVkcyB0byBhY2Nlc3Mg
dHdvIHJlZ2lzdGVyczoNCj4+IDEuIFBDSWUgTURJTyByZWdpc3RlcjogVXRpbGl6ZWQgZm9yIGNv
bmZpZ3VyaW5nIHRoZSBQQ0llIFBIWS4NCj4+IDIuIFBDSWUgTUFDIExpbmsgQ29udHJvbCBhbmQg
TGluayBTdGF0dXMgUmVnaXN0ZXI6IFVzZSB0byBnZXQgdGhlIGN1cnJlbnQNCj4+ICAgbGluayBz
cGVlZCBmb3IgY2FsaWJyYXRpb24gcHVycG9zZXMuDQo+Pg0KPj4gQm90aCB0aGVzZSByZWdpc3Rl
cnMgcmVzaWRlIHdpdGhpbiB0aGUgUENJZSBjb250cm9sbGVyIHJlZ2lzdGVycy4gVGhlDQo+PiBQ
Q0llIGRyaXZlciBoYXMgbWFwcGVkIHRoZXNlIHJlZ2lzdGVyIGFkZHJlc3MgcmVnaW9uLCBzbyBJ
IHVzZSByZWdtYXANCj4+IHRvIGFjY2VzcyB0aGVzZSByZWdpc3RlcnMuDQo+DQo+SG0sIGlzbid0
IGluIHN1Y2ggY2FzZSBQQ0llIFBIWSBhIGNoaWxkIG9mIHRoZSBQQ0llIGNvbnRyb2xsZXI/IEhv
dyBpcyBpdCB3aXRoDQo+cmVzb3VyY2VzLCBsaWtlIHBvd2VyIGRvbWFpbnMgb3IgcmVndWxhdG9y
cz8NCg0KSW4gZmFjdCwgSSBwb3NpdGlvbmVkIHRoZSBQQ0llIFBIWSBub2RlIG91dHNpZGUgdGhl
IFBDSWUgY29udHJvbGxlciBub2RlLg0KSXQgd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZSBmb3Ig
dGhlIFBDSWUgUEhZIGFzIHRoZSBjaGlsZCBub2RlIG9mIHRoZSBQQ0llDQpjb250cm9sbGVyLiBJ
IHdpbGwgcmV2aXNlIHRvIHRoaXMgc3RydWN0dXJlLg0KSSB3aWxsIGFsc28gcmVtb3ZlIHRoZSAi
cmVhbHRlayxwY2llLXN5c2NvbiIgcHJvcGVydHkgYW5kIHVzZSBkZXYtPnBhcmVudC0+b2Zfbm9k
ZQ0KdG8gZ2V0IHRoZSBzeXNjb24gb2YgdGhlIFBDSWUgY29udHJvbGxlci4NCg0KU2luY2UgdGhl
IE1ESU8gcmVnaXN0ZXIgaXMgbG9jYXRlZCB3aXRoaW4gdGhlIFBDSWUgY29udHJvbGxlciByZWdp
c3RlcnMsIGl0IGNhbg0Kb25seSBiZSBhY2Nlc3NlZCBhZnRlciBlbmFibGluZyB0aGUgY2xvY2sg
YW5kIGFzc2VydGluZyB0aGUgcmVzZXRzIG9mIHRoZSBQQ0llIGNvbnRyb2xsZXIuDQpUaGVyZWZv
cmUsIHRoZSBQQ0llIFBIWSBkcml2ZXIgb25seSByZWdpc3RlcnMgdGhlIGNhbGxiYWNrIGZ1bmN0
aW9ucyBvZiBwaHlfb3BzICguaW5pdCBhbmQgLmNhbGlicmF0ZSkuDQpBZnRlciB0aGUgUENJZSBj
b250cm9sbGVyIGRyaXZlciBzZXRzIHRoZSBjbG9jayBhbmQgcmVzZXRzLCBpdCB3aWxsIGV4ZWN1
dGUgUEhZIGZyYW1ld29yayBBUEkgdG8NCmNvbmZpZ3VyZSB0aGUgUEhZLg0KDQpUaGFua3MsDQpU
enV5aSBDaGFuZw0K
