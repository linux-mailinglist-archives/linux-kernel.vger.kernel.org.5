Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8C80862B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378699AbjLGKJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379076AbjLGKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:09:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB4A4;
        Thu,  7 Dec 2023 02:09:58 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B7A9H3l8078237, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B7A9H3l8078237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 18:09:17 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 7 Dec 2023 18:09:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 7 Dec 2023 18:09:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 18:09:17 +0800
From:   =?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?= <tychang@realtek.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
Subject: RE: [PATCH 1/2] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC PCIe PHY
Thread-Topic: [PATCH 1/2] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC
 PCIe PHY
Thread-Index: AQHaJERyJL4rQ+THDkqbltcZ8ZneurCUEU0AgAkK6/A=
Date:   Thu, 7 Dec 2023 10:09:16 +0000
Message-ID: <951a35ee5bb84ac4bf2462729909fe7c@realtek.com>
References: <20231201105207.11786-1-tychang@realtek.com>
 <20231201105207.11786-2-tychang@realtek.com>
 <20231201-umbilical-unending-c8fa05cb42d2@spud>
In-Reply-To: <20231201-umbilical-unending-c8fa05cb42d2@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBDb25vciwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQo+PiArcHJvcGVydGll
czoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+DQo+PiArICAgICAgLSByZWFs
dGVrLHJ0ZDEzMTktcGNpZTAtcGh5DQo+PiArICAgICAgLSByZWFsdGVrLHJ0ZDEzMTktcGNpZTEt
cGh5DQo+PiArICAgICAgLSByZWFsdGVrLHJ0ZDEzMTktcGNpZTItcGh5DQo+PiArICAgICAgLSBy
ZWFsdGVrLHJ0ZDE2MTliLXBjaWUxLXBoeQ0KPj4gKyAgICAgIC0gcmVhbHRlayxydGQxNjE5Yi1w
Y2llMi1waHkNCj4NCj5QbGVhc2UgZXhwbGFpbiB3aHkgZGlmZmVyZW50IFBIWXMgb24gdGhlIHNh
bWUgU29DIG5lZWQgZGlmZmVyZW50IGNvbXBhdGlibGVzLg0KPg0KDQpJIGhhZG4ndCB0aG91Z2h0
IHRoaXMgY2xlYXJseS4gSSBhZGRlZCB0aGUgY29tcGF0aWJsZSBmb3IgZWFjaCBQQ0llIHBvcnRz
LiBIb3dldmVyLA0Kb25seSBvbmUgY29tcGF0aWJsZSBpcyBuZWVkZWQgZm9yIHRoZSBQSFkgZHJp
dmVyIG9uIGVhY2ggU29DLg0KSSB3aWxsIHJldmlzZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
DQpUaGVyZSBhcmUgbXVsdGlwbGUgcG9ydHMgZm9yIFBDSWUgb24gZGlmZmVyZW50IFNvQ3MuIFJU
RDEzMTkgaGFzIHRocmVlIFBDSWUgcG9ydHMgKHBvcnQgMCwgcG9ydDEsIHBvcnQyKS4NClJURDE2
MTlCIGhhcyB0d28gUENJZSBwb3J0cy4gQm90aCBSVEQxMzE5RCBhbmQgUlREMTMxNUUgaGF2ZSBv
bmUgUENJZSBwb3J0Lg0KDQo+PiArICAgICAgLSByZWFsdGVrLHJ0ZDEzMTlkLXBjaWUxLXBoeQ0K
Pj4gKyAgICAgIC0gcmVhbHRlayxydGQxMzE1ZS1wY2llMS1waHkNCj4NCj5BbmQgd2h5IGJvdGhl
ciB3aXRoIHRoZSAxIGhlcmUgZ2l2ZW4gdGhlcmUgaXMgbm8gMCBvciAyPw0KPg0KDQpJJ20gc29y
cnkgZm9yIHRoZSBjb25mdXNpb24gY2F1c2VkIGJ5IHRoZSBuYW1pbmcuIFRoZSBQQ0llIGNvbnRy
b2xsZXIgcmVnaXN0ZXIgYWRkcmVzcyBvbiANClJURDEzMTlEIGFuZCBSVEQxMzE1RSBpcyB0aGUg
c2FtZSBhcyBSVEQxMzE5J3MgUENJZSBwb3J0MSwgc28gSSBuYW1lZCBpdCBhcyBwY2llMS4NCkkn
bGwgcmVmcmFpbiBmcm9tIHVzaW5nIHN1Y2ggbmFtaW5nIGluIHRoZSBmdXR1cmUuDQoNCj5UaGlz
IGxvb2tzIHN1c3BpY2lvdXNseSBsaWtlIGFidXNlIG9mIHRoZSBjb21wYXRpYmxlIC0gZXNwZWNp
YWxseSBzaW5jZSBtb3N0IG9mDQo+dGhlIG9wcyBhcmUgdGhlIHNhbWUgZGVzcGl0ZSB0aGUgZGlm
ZmVyaW5nIGNvbXBhdGlibGVzLiBUaGUgY2FzZSB3aGVyZSB0aGF0DQo+ZG9lcyBub3QgYXBwbHks
IGl0IGxvb2tzIGxpa2UgdGhlIGlzc3VlIGlzIGRvd24gdG8gdGhlIHBvcnRpb24gb2YgdGhlIG52
bWVtIGNlbGwNCj5jb3JyZXNwb25kaW5nIHRvIHRoZSBQSFksIHdoaWNoIGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggdGhlIHByb2dyYW1taW5nIG1vZGVsDQo+b2YgdGhlIFBIWSBpdHNlbGYgSU1PLg0K
DQpUaGFua3MsDQpUenV5aSBDaGFuZw0KDQo=
