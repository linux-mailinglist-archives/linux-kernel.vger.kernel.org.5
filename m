Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1976E0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjHCHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHCHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:10:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B28A4194;
        Thu,  3 Aug 2023 00:10:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3737A80V0023899, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3737A80V0023899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Aug 2023 15:10:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 3 Aug 2023 15:09:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 3 Aug 2023 15:09:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 3 Aug 2023 15:09:56 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] doc: dt: bindings: usb: realtek,dwc3: Add Realtek DHC RTD SoC DWC3 USB
Thread-Topic: [PATCH v1 2/2] doc: dt: bindings: usb: realtek,dwc3: Add Realtek
 DHC RTD SoC DWC3 USB
Thread-Index: AQHZwQcMHiqO6RUc7UW0WlFc2kMWqq/XSK8AgADkZTA=
Date:   Thu, 3 Aug 2023 07:09:56 +0000
Message-ID: <3ade69876138407aaa650255a902999d@realtek.com>
References: <20230728035318.18741-1-stanley_chang@realtek.com>
 <20230728035318.18741-2-stanley_chang@realtek.com>
 <20230803011836.GA1635549-robh@kernel.org>
In-Reply-To: <20230803011836.GA1635549-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAg
IGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIHJlYWx0ZWsscnRk
MTI5NS1kd2MzDQo+ID4gKyAgICAgICAgICAtIHJlYWx0ZWsscnRkMTMxNWUtZHdjMw0KPiA+ICsg
ICAgICAgICAgLSByZWFsdGVrLHJ0ZDEzMTktZHdjMw0KPiA+ICsgICAgICAgICAgLSByZWFsdGVr
LHJ0ZDEzMTlkLWR3YzMNCj4gPiArICAgICAgICAgIC0gcmVhbHRlayxydGQxMzk1LWR3YzMNCj4g
PiArICAgICAgICAgIC0gcmVhbHRlayxydGQxNjE5LWR3YzMNCj4gPiArICAgICAgICAgIC0gcmVh
bHRlayxydGQxNjE5Yi1kd2MzDQo+ID4gKyAgICAgIC0gY29uc3Q6IHJlYWx0ZWsscnRkLWR3YzMN
Cj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gDQo+IFNvbWUgZGV0
YWlscyBvbiB3aGF0IHRoZXNlIHJlZ2lzdGVycyBhcmUgd291bGQgYmUgdXNlZnVsLiBPciBkZXNj
cmliaW5nIHdoYXQncw0KPiBpbiB0aGUgJ2dsdWUnIGRldmljZT8NCg0KT2ssIEkgd2lsbCBhZGQg
dGhlIGRlc2NyaXB0aW9uLg0KIA0KDQo+ID4gKyAgcmVhbHRlayx1bmxpbmstdXNiMy1wb3J0Og0K
PiA+ICsgICAgZGVzY3JpcHRpb246IERpc2FibGUgbGluayBiZXR3ZWVuIFVTQiAzLjAgUEhZIGFu
ZCBVU0IgbWFjLg0KPiA+ICsgICAgICBPbmx5IGZvciBSVEQxNjE5IFNvQywgaWYgdGhlIGJvYXJk
IGRlc2lnbiBzdXBwb3J0IG1heGltdW0gMi4wDQo+IHNwZWVkLg0KPiA+ICsgICAgdHlwZTogYm9v
bGVhbg0KPiANCj4gV2UgaGF2ZSBhIHByb3BlcnR5IGZvciB0aGlzOiBtYXhpbXVtLXNwZWVkDQo+
IA0KPiBUaGF0IGJlbG9uZ3MgaW4gdGhlIFVTQiBjb250cm9sbGVyIG5vZGUgdGhvdWdoLg0KDQpJ
IGNhbiB0cnkgdG8gdXNlIHRoaXMgcHJvcGVydHkuDQpCdXQgSSBoYXZlIGEgcXVlc3Rpb24uDQpU
aGlzIHByb3BlcnR5IGJlbG9uZ3MgdG8gZHdjMy4NCldoZW4gdGhlIGR3YzMtcnRrIHNldHRpbmcg
ZGlzYWJsZXMgVVNCIDMuMCBwaHksIGR3YzMgaXMgbm90IHByb2JlZC4NClNvIEkgY2FuJ3QgdXNl
IGFwaSB1c2JfZ2V0X21heGltdW1fc3BlZWQoZGV2KSB0byBnZXQgbWF4aW11bV9zcGVlZC4NCg0K
SSBjYW4gYWRkIHRoaXMgcHJvcGVydHkgIm1heGltdW0tc3BlZWQiIHRvIHRoZSBkd2MzLXJ0ayBu
b2RlLCB3aGljaCBpcyB0aGUgc2FtZSBhcyB0aGUgZHdjMyBjb3JlIG5vZGUuDQpJcyB0aGlzIGNv
bmZpZ3VyYXRpb24gYXBwcm9wcmlhdGU/IA0KRm9yIGV4YW1wbGUgDQogICAgdXNiQDk4MDEzZTAw
IHsNCiAgICAgICAgY29tcGF0aWJsZSA9ICJyZWFsdGVrLHJ0ZDEzMTlkLWR3YzMiLCAicmVhbHRl
ayxydGQtZHdjMyI7DQogICAgICAgIHJlZyA9IDwweDk4MDEzZTAwIDB4MjAwPjsNCiAgICAgICAg
I2FkZHJlc3MtY2VsbHMgPSA8MT47DQogICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KICAgICAg
ICByYW5nZXM7DQogICAgICAgIG1heGltdW0tc3BlZWQgPSAiaGlnaC1zcGVlZCI7DQoNCiAgICAg
ICAgdXNiQDk4MDUwMDAwIHsNCiAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic25wcyxkd2MzIjsN
CiAgICAgICAgICAgIHJlZyA9IDwweDk4MDUwMDAwIDB4OTAwMD47DQogICAgICAgICAgICBpbnRl
cnJ1cHRzID0gPDAgOTQgND47DQogICAgICAgICAgICBwaHlzID0gPCZ1c2IycGh5ICZ1c2IzcGh5
PjsNCiAgICAgICAgICAgIHBoeS1uYW1lcyA9ICJ1c2IyLXBoeSIsICJ1c2IzLXBoeSI7DQogICAg
ICAgICAgICBkcl9tb2RlID0gIm90ZyI7DQogICAgICAgICAgICB1c2Itcm9sZS1zd2l0Y2g7DQog
ICAgICAgICAgICByb2xlLXN3aXRjaC1kZWZhdWx0LW1vZGUgPSAiaG9zdCI7DQogICAgICAgICAg
ICBzbnBzLGRpc191Ml9zdXNwaHlfcXVpcms7DQogICAgICAgICAgICBzbnBzLHBhcmttb2RlLWRp
c2FibGUtc3MtcXVpcms7DQogICAgICAgICAgICBzbnBzLHBhcmttb2RlLWRpc2FibGUtaHMtcXVp
cms7DQogICAgICAgICAgICBtYXhpbXVtLXNwZWVkID0gImhpZ2gtc3BlZWQiOw0KICAgICAgICB9
Ow0KICAgIH07DQoNCj4gPiArDQo+ID4gKyAgcmVhbHRlayxkaXNhYmxlLXVzYjMtcGh5Og0KPiA+
ICsgICAgZGVzY3JpcHRpb246IENsb3NlIFVTQiAzLjAgUEhZIGlmIHRoZSBib2FyZCBkZXNpZ24g
bm90IHN1cHBvcnQgVVNCIDMuMC4NCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gDQo+IENhbid0
IHRoaXMgYmUgZGV0ZXJtaW5lZCBieSBub3QgaGF2aW5nIGEgVVNCMyBwaHkgbGlzdGVkPw0KDQpJ
IHdpbGwgdHJ5IHRvIHVzZSBtYXhpbXVtLXNwZWVkLg0KDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsg
IC0gfA0KPiA+ICsgICAgdXNiQDk4MDEzZTAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0g
InJlYWx0ZWsscnRkMTMxOWQtZHdjMyIsICJyZWFsdGVrLHJ0ZC1kd2MzIjsNCj4gPiArICAgICAg
ICByZWcgPSA8MHg5ODAxM2UwMCAweDIwMD47DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgcmFu
Z2VzOw0KPiA+ICsgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gDQo+IERyb3Agc3RhdHVzIGZy
b20gZXhhbXBsZXMuDQoNCk9rLg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
