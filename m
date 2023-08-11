Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88032778732
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjHKF6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:58:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16BF22722;
        Thu, 10 Aug 2023 22:58:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37B5w8igD004213, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37B5w8igD004213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 13:58:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 11 Aug 2023 13:58:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 11 Aug 2023 13:58:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 11 Aug 2023 13:58:26 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC DWC3 USB
Thread-Topic: [PATCH v3 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC
 DWC3 USB
Thread-Index: AQHZy08oIzVQuCZ6R0a3+HSHmsv8hK/jd/iAgAEgh5A=
Date:   Fri, 11 Aug 2023 05:58:25 +0000
Message-ID: <31c4716cd3df41418e91dd77347f8dc8@realtek.com>
References: <20230810055440.3534-1-stanley_chang@realtek.com>
 <20230810055440.3534-2-stanley_chang@realtek.com>
 <20230810203633.GA1121702-robh@kernel.org>
In-Reply-To: <20230810203633.GA1121702-robh@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIHVz
YkA5ODAxM2UwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJyZWFsdGVrLHJ0ZDEzMTlk
LWR3YzMiLCAicmVhbHRlayxydGQtZHdjMyI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4OTgwMTNl
MDAgMHgyMDA+Ow0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAg
ICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgIHJhbmdlczsNCj4gPiArICAgICAg
ICBtYXhpbXVtLXNwZWVkID0gImhpZ2gtc3BlZWQiOw0KPiANCj4gVGhpcyBzaG91bGQgYmUgYSB3
YXJuaW5nICh0aGUgYm90IHdhcyBoYXZpbmcgcHJvYmxlbXMpIGFzIGl0IGlzIG5vdCBkZWZpbmVk
IGZvcg0KPiB0aGlzIG5vZGUuIEl0IGJlbG9uZ3MgaW4gdGhlIGNoaWxkIG5vZGUgYXMgeW91IGFs
c28gaGF2ZSwgc28gZHJvcCBpdC4NCg0KQXMgSSBtZW50aW9uZWQgaW4gdGhlIHYxIHBhdGNoLCBJ
IGhhdmUgYSBwcm9ibGVtLg0KVGhpcyBwcm9wZXJ0eSBtYXhpbXVtLXNwZWVkIGJlbG9uZ3MgdG8g
ZHdjMy4NCldoZW4gdGhlIGR3YzMtcnRrIHNldHRpbmcgZGlzYWJsZXMgVVNCIDMuMCBwaHksIGR3
YzMgaXMgbm90IHByb2JlZC4NClNvIEkgY2FuJ3QgdXNlIGFwaSB1c2JfZ2V0X21heGltdW1fc3Bl
ZWQoZGV2KSB0byBnZXQgbWF4aW11bS1zcGVlZC4NCg0KSSBhZGRlZCB0aGlzIHByb3BlcnR5ICJt
YXhpbXVtLXNwZWVkIiB0byB0aGUgZHdjMy1ydGsgbm9kZSwgd2hpY2ggaXMgdGhlIHNhbWUgYXMg
dGhlIGR3YzMgY29yZSBub2RlLg0KSXMgdGhpcyBjb25maWd1cmF0aW9uIGFwcHJvcHJpYXRlPw0K
T3IgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24/DQoNCj4gPiArDQo+ID4gKyAgICAgICAgdXNi
QDk4MDUwMDAwIHsNCj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzbnBzLGR3YzMiOw0K
PiA+ICsgICAgICAgICAgICByZWcgPSA8MHg5ODA1MDAwMCAweDkwMDA+Ow0KPiA+ICsgICAgICAg
ICAgICBpbnRlcnJ1cHRzID0gPDAgOTQgND47DQo+ID4gKyAgICAgICAgICAgIHBoeXMgPSA8JnVz
YjJwaHkgJnVzYjNwaHk+Ow0KPiA+ICsgICAgICAgICAgICBwaHktbmFtZXMgPSAidXNiMi1waHki
LCAidXNiMy1waHkiOw0KPiA+ICsgICAgICAgICAgICBkcl9tb2RlID0gIm90ZyI7DQo+ID4gKyAg
ICAgICAgICAgIHVzYi1yb2xlLXN3aXRjaDsNCj4gPiArICAgICAgICAgICAgcm9sZS1zd2l0Y2gt
ZGVmYXVsdC1tb2RlID0gImhvc3QiOw0KPiA+ICsgICAgICAgICAgICBzbnBzLGRpc191Ml9zdXNw
aHlfcXVpcms7DQo+ID4gKyAgICAgICAgICAgIHNucHMscGFya21vZGUtZGlzYWJsZS1zcy1xdWly
azsNCj4gPiArICAgICAgICAgICAgc25wcyxwYXJrbW9kZS1kaXNhYmxlLWhzLXF1aXJrOw0KPiA+
ICsgICAgICAgICAgICBtYXhpbXVtLXNwZWVkID0gImhpZ2gtc3BlZWQiOw0KPiA+ICsgICAgICAg
IH07DQo+ID4gKyAgICB9Ow0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg0KVGhhbmtzLA0KU3Rh
bmxleQ0K
