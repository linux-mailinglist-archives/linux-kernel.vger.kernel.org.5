Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE978521F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjHWH50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjHWH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:57:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 723221BE;
        Wed, 23 Aug 2023 00:57:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37N7ugTH3031092, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37N7ugTH3031092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Aug 2023 15:56:42 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 23 Aug 2023 15:56:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 23 Aug 2023 15:56:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 23 Aug 2023 15:56:48 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/7] dt-bindings: pinctrl: realtek: add RTD1315E pinctrl binding
Thread-Topic: [PATCH 5/7] dt-bindings: pinctrl: realtek: add RTD1315E pinctrl
 binding
Thread-Index: AQHZyS4KlrKw42BEDUewXNjTeqXxea/2B4ig
Date:   Wed, 23 Aug 2023 07:56:48 +0000
Message-ID: <ba502655bea5481aaee9209195f2bf79@realtek.com>
References: <20230726090409.16606-1-tychang@realtek.com>
 <20230726090409.16606-6-tychang@realtek.com>
 <CACRpkdYzLiXSLpU63Nn84b+p3Nz5Ls-o94HsoAq514LvGkSiVg@mail.gmail.com>
In-Reply-To: <CACRpkdYzLiXSLpU63Nn84b+p3Nz5Ls-o94HsoAq514LvGkSiVg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCj4NCj5IaSBUWSBDaGFuZywN
Cj4NCj50aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+DQo+T24gV2VkLCBKdWwgMjYsIDIwMjMgYXQg
MTE6MDbigK9BTSBUWSBDaGFuZyA8dHljaGFuZ0ByZWFsdGVrLmNvbT4gd3JvdGU6DQo+DQo+PiBB
ZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIFJURDEzMTVFLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFRZIENoYW5nIDx0eWNoYW5nQHJlYWx0ZWsuY29tPg0KPg0KPk1heWJlIHlvdSBjb3VsZCB3
cml0ZSBhIHNob3J0IHBhcmFncmFwaCBhYm91dCB0aGUgUlREMTMxNUUgc28gd2Uga25vdyB3aGF0
DQo+dGhpcyBpcz8gSSBndWVzcyBpdCBpcyBzb21lIFNvQyB3aXRoIHNvbWUgaW50ZW5kZWQgdXNl
IGNhc2U/DQo+DQoNCkkgd2lsbCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiguLi4p
DQo+PiArZGVzY3JpcHRpb246IHwNCj4+ICsgIEJpbmRpbmcgZm9yIFJlYWx0ZWsgREhDIFJURDEz
MTVFIFNvQyBwaW4gY29udHJvbC4NCj4NCj5TYW1lIHRleHQgc2hvdWxkIGdvIGhlcmUgaW4gdGhh
dCBjYXNlLg0KPg0KPj4gKyAgICAgICAgcmVhbHRlayxwZHJpdmU6DQo+PiArICAgICAgICAgIGRl
c2NyaXB0aW9uOiB8DQo+PiArICAgICAgICAgICAgQW4gaW50ZWdlciBkZXNjcmliaW5nIHRoZSBs
ZXZlbCB0byBhZGp1c3QgUE1PUyBvdXRwdXQgZHJpdmluZw0KPmNhcGFiaWxpdHkuDQo+PiArICAg
ICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4g
KyAgICAgICAgICBtaW5pbXVtOiAwDQo+PiArICAgICAgICAgIG1heGltdW06IDcNCj4+ICsNCj4+
ICsgICAgICAgIHJlYWx0ZWssbmRyaXZlOg0KPj4gKyAgICAgICAgICBkZXNjcmlwdGlvbjogfA0K
Pj4gKyAgICAgICAgICAgIEFuIGludGVnZXIgZGVzY3JpYmluZyB0aGUgbGV2ZWwgdG8gYWRqdXN0
IE5NT1Mgb3V0cHV0IGRyaXZpbmcNCj5jYXBhYmlsaXR5Lg0KPj4gKyAgICAgICAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAgICAgICAgbWlu
aW11bTogMA0KPj4gKyAgICAgICAgICBtYXhpbXVtOiA3DQo+DQo+SSB3b3VsZCByZW5hbWUgdGhl
c2UgcmVhbHRlayxkcml2ZS1zdHJlbmd0aC1wIGFuZCByZWFsdGVrLGRyaXZlLXN0cmVuZ3RoLW4u
DQoNClN1cmUsIEkgdGhpbmsgbmFtaW5nIHRoZW0gbGlrZSB0aGF0IG1ha2VzIGl0IGNsZWFyZXIu
DQoNCj4NCj5Zb3UgbmVlZCB0byBleHBsYWluIHdoYXQgaXMgbWVhbnQgd2l0aCBQTU9TIGFuZCBO
TU9TIGhlcmUuIElmIGl0IGlzIHdoYXQgSSB0aGluaw0KPml0IGlzLCBJIHRoaW5rIHNvbWUgQVND
SUkgYXJ0IHdvdWxkIGJlIGhhbmR5IQ0KPg0KPllvdSBjYW4gcmV1c2UgbXkgQVNDSUkgYXJ0IGZy
b20gRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2dwaW8vZHJpdmVyLnJzdDoNCj4NCj4gICAgICAg
ICAgICAgICAgICAgICBWREQNCj4gICAgICAgICAgICAgICAgICAgICAgfA0KPiAgICAgICAgICAg
IE9EICAgIHx8LS0rDQo+ICAgICAgICAgKy0tLyAtLS1vfHwgICAgIFAtTU9TLUZFVA0KPiAgICAg
ICAgIHwgICAgICAgIHx8LS0rDQo+ICAgIElOIC0tKyAgICAgICAgICAgICstLS0tLSBvdXQNCj4g
ICAgICAgICB8ICAgICAgICB8fC0tKw0KPiAgICAgICAgICstLS8gLS0tLXx8ICAgICBOLU1PUy1G
RVQNCj4gICAgICAgICAgICBPUyAgICB8fC0tKw0KPiAgICAgICAgICAgICAgICAgICAgICB8DQo+
ICAgICAgICAgICAgICAgICAgICAgR05EDQo+DQo+TWF5YmUgeW91IHdhbm5hIGRlbGV0ZSB0aGUg
T0Qgc3dpdGNoIGlmIHRoZXNlIGRyaXZlcnMgZG9uJ3Qgc3VwcG9ydCB0aGF0Lg0KPg0KPldoYXQg
ZG9lcyB0aGUgdmFsdWVzIDAuLjcgYWN0dWFsbHkgY29ycmVzcG9uZCB0bz8gSXMgaXQgdGhlIG51
bWJlciBvZg0KPnRyYW5zaXN0b3JzL2RyaXZlciBzdGFnZXMgc2ltcGx5PyBUaGVuIHdyaXRlIHRo
YXQuDQo+DQo+V2UgbmVlZCB0byB0aGluayB3aGV0aGVyIHRoaXMgaXMgc28gZ2VuZXJpY2FsbHkg
dXNlZnVsIHRoYXQgaXQgc2hvdWxkIHNpbXBseSBiZQ0KPmRyaXZlLXN0cmVuZ3RoLXBtb3MgYW5k
IGRyaXZlLXN0cmVuZ3RoLW5tb3MsIHNpbXBseSBwdXQsIGFzIG90aGVyIFNvQ3MgbWF5DQo+aW1w
bGVtZW50IHRoZSBzYW1lLiBXaGF0IGRvIHBlb3BsZSB0aGluaz8NCj4NCg0KSSB3aWxsIGFkZCB0
aGVzZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBUaGUgdmFsdWVzIDAuLjcgaXMgdGhlIGxldmVsIG9m
IHRoZSBkcml2aW5nIHN0cmVuZ3RoLiANClRoZXNlIGxldmVzIGNhbiBpbXBhY3QgdGhlIHJpc2lu
Zy9mYWxsaW5nIHRpbWUgb2YgdGhlIHdhdmVmb3JtLCBhc3Npc3RpbmcgaW4gYWNoaWV2aW5nDQp0
aGUgZGVzaXJlZCB0cmFuc2ZlciBzcGVlZC4NCg0KPj4gKyAgICAgICAgcmVhbHRlayxkY3ljbGU6
DQo+PiArICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+PiArICAgICAgICAgICAgQW4gaW50ZWdl
ciBkZXNjcmliaW5nIHRoZSBsZXZlbCB0byBhZGp1c3Qgb3V0cHV0IGR1dHkgY3ljbGUuDQo+PiAr
ICAgICAgICAgICAgVmFsaWQgYXJndW1lbnRzIGFyZSBkZXNjcmliZWQgYXMgYmVsb3c6DQo+PiAr
ICAgICAgICAgICAgMDogMG5zDQo+PiArICAgICAgICAgICAgMjogKyAwLjI1bnMNCj4+ICsgICAg
ICAgICAgICAzOiArIDAuNW5zDQo+PiArICAgICAgICAgICAgNDogLTAuMjVucw0KPj4gKyAgICAg
ICAgICAgIDU6IC0wLjVucw0KPj4gKyAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAgICAgICAgZW51bTogWyAwLCAyLCAzLCA0LCA1
IF0NCj4NCj5UaGlzIGRvZXMgbm90IGV4cGxhaW4gdGhlIGR1dHkgY3ljbGUgb2YgKndoYXQqPw0K
Pg0KPkl0IGxvb2tzIHJlYWxseSB1c2VmdWwgc28gcGxlYXNlIGV4cGxhaW4gdGhvcm91Z2hseSB3
aGF0IGl0IGRvZXMuDQo+DQo+SSBndWVzcyB0aGlzIGlzIG5vdCBQV00gYmVjYXVzZSB0aGVuIHlv
dSBjb3VsZCB1c2UgUElOX0NPTkZJR19NT0RFX1BXTS4NCj4NCg0KVGhpcyBpcyBub3QgUFdNLiBU
aGUgZHV0eSBjeWNsZSBoZXJlIGlzIHRvIGFkanVzdCB0aGUgcHJvcG9ydGlvbiBvZiBwb3NpdGl2
ZSBhbmQgbmVnYXRpdmUgd2F2ZWZvcm1zLCBhbmQgaXMgYWRqdXN0ZWQgaW4gbmFub3NlY29uZChu
cykuDQoNCj5Zb3VycywNCj5MaW51cyBXYWxsZWlqDQo+DQoNClRoYW5rcywNClRZIENoYW5nDQo=
