Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4B801DB6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjLBQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:19:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34CFA;
        Sat,  2 Dec 2023 08:19:30 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B2GIv2J2975485, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B2GIv2J2975485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Dec 2023 00:18:57 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sun, 3 Dec 2023 00:18:57 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 3 Dec 2023 00:18:56 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Sun, 3 Dec 2023 00:18:56 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Thread-Index: AQHaGXMHJnbDooY4VkyEcMH4aisPjrCBFAaAgAG3OTCAE2RqMA==
Date:   Sat, 2 Dec 2023 16:18:56 +0000
Message-ID: <e1490203387d4c48a5f8c4040ece038a@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
 <c3a98e2c-ba62-4798-a0d0-a8bc1fe5bb6b@linaro.org>
 <7959920acf004f3cb8072de1e17439fa@realtek.com>
In-Reply-To: <7959920acf004f3cb8072de1e17439fa@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.16.16.224]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

SGkgS3J6eXN6dG9mLA0KDQo+Pj4gKw0KPj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4gKyAgICBlbnVt
Og0KPj4+ICsgICAgICAtIHJlYWx0ZWsscnRkMTMxOS1pbnRjLWlzbw0KPj4+ICsgICAgICAtIHJl
YWx0ZWsscnRkMTMxOS1pbnRjLW1pc2MNCj4+PiArDQo+Pj4gKyAgIiNhZGRyZXNzLWNlbGxzIjoN
Cj4+PiArICAgIGNvbnN0OiAwDQo+Pj4gKw0KPj4+ICsgIGludGVycnVwdC1jb250cm9sbGVyOiB0
cnVlDQo+Pj4gKw0KPj4+ICsgIGludGVycnVwdHMtZXh0ZW5kZWQ6DQo+Pg0KPj5pbnRlcnJ1cHRz
IGluc3RlYWQuDQo+Pg0KPj5Bbnl3YXksIHlvdSBtdXN0IGRlc2NyaWJlIHRoZSBpdGVtcy4gV2h5
IHRoaXMgaXMgbm90IGZpeGVkIGJ1dCBmbGV4aWJsZT8NCj4+SGFyZHdhcmUgaGFzIGRpZmZlcmVu
dCBudW1iZXIgb2YgcGlucz8gVGhhdCdzIHVubGlrZWx5Lg0KPj4NCj5JIHdpbGwgcmVwbGFjZSBp
dCB3aXRoICdpbnRlcnJ1cHRzJy4gU2luY2Ugb3VyIEludGVycnVwdCBjb250cm9sbGVyIGFyY2hp
dGVjdHVyZQ0KPmRvZXNuJ3QgaW52b2x2ZSBtdWx0aXBsZSBpbnRlcnJ1cHQgc291cmNlcywgdXNp
bmcgJ2ludGVycnVwdHMnIHNob3VsZCBzdWZmaWNlLg0KPg0KDQpEdWUgdG8gY2hhbmdlcyBpbiBo
YXJkd2FyZSBkZXNpZ24sIHNvbWUgcGVyaXBoZXJhbCBpbnRlcnJ1cHRzIHBpbiBpbml0aWFsbHkg
Y29ubmVjdGVkIHRvIHRoZSBSZWFsdGVrIGludGVycnVwdCBjb250cm9sbGVyIHdlcmUgcmVkaXJl
Y3RlZCB0byB0aGUgR0lDLiANCkhvd2V2ZXIsIHRoZSBhc3NvY2lhdGVkIGZpZWxkcyBhbmQgc3Rh
dHVzZXMgaW4gdGhlIFJlYWx0ZWsgaW50ZXJydXB0IGNvbnRyb2xsZXIgcmVnaXN0ZXJzIHdlcmUg
bm90IHJlbW92ZWQuDQpBcyBhIHJlc3VsdCwgdGhlc2UgaW50ZXJydXB0cyBjYW5ub3QgYmUgY2xl
YXJlZCBieSBwZXJpcGhlcmFsIHJlZ2lzdGVyLCBhbmQgdGhlaXIgc3RhdHVzIGNsZWFyaW5nIGlz
IHN0aWxsIG5lZWRpbmcgdGhlIFJlYWx0ZWsgaW50ZXJydXB0IGNvbnRyb2xsZXIgZHJpdmVyIHRv
IG1hbmFnZS4NCg0KVGhhdCdzIHdoeSBmbGV4aWJpbGl0eSBpcyBuZWNlc3NhcnkuDQoNClJlZ2Fy
ZHMsDQpKYW1lcw0K
