Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C67BC398
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjJGBVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjJGBVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:21:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB2CC5;
        Fri,  6 Oct 2023 18:21:14 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3971KhZN22568955, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3971KhZN22568955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 7 Oct 2023 09:20:43 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 7 Oct 2023 09:20:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 7 Oct 2023 09:20:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Sat, 7 Oct 2023 09:20:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Subject: Re: [PATCH] wifi: rtw89: coex: Annotate struct rtw89_btc_btf_set_slot_table with __counted_by
Thread-Topic: [PATCH] wifi: rtw89: coex: Annotate struct
 rtw89_btc_btf_set_slot_table with __counted_by
Thread-Index: AQHZ+JIdINNFwhWCA0q/Xu1rquYi7LA9Aa0A
Date:   Sat, 7 Oct 2023 01:20:43 +0000
Message-ID: <4716f3c7bf3d34ea25229edd5250f5f0cff639d8.camel@realtek.com>
References: <20231006201715.work.239-kees@kernel.org>
In-Reply-To: <20231006201715.work.239-kees@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.81.64]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <055816771E1C154CA2754D4B6C70B030@realtek.com>
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

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDEzOjE3IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IA0K
PiBQcmVwYXJlIGZvciB0aGUgY29taW5nIGltcGxlbWVudGF0aW9uIGJ5IEdDQyBhbmQgQ2xhbmcg
b2YgdGhlIF9fY291bnRlZF9ieQ0KPiBhdHRyaWJ1dGUuIEZsZXhpYmxlIGFycmF5IG1lbWJlcnMg
YW5ub3RhdGVkIHdpdGggX19jb3VudGVkX2J5IGNhbiBoYXZlDQo+IHRoZWlyIGFjY2Vzc2VzIGJv
dW5kcy1jaGVja2VkIGF0IHJ1bi10aW1lIHZpYSBDT05GSUdfVUJTQU5fQk9VTkRTIChmb3INCj4g
YXJyYXkgaW5kZXhpbmcpIGFuZCBDT05GSUdfRk9SVElGWV9TT1VSQ0UgKGZvciBzdHJjcHkvbWVt
Y3B5LWZhbWlseQ0KPiBmdW5jdGlvbnMpLg0KPiANCj4gQXMgZm91bmQgd2l0aCBDb2NjaW5lbGxl
WzFdLCBhZGQgX19jb3VudGVkX2J5IGZvciBzdHJ1Y3QNCj4gcnR3ODlfYnRjX2J0Zl9zZXRfc2xv
dF90YWJsZS4NCj4gDQo+IENjOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4g
Q2M6IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+IENjOiAiR3VzdGF2byBBLiBSLiBT
aWx2YSIgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbGludXgtaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZw0KPiBMaW5r
OiBodHRwczovL2dpdGh1Yi5jb20va2Vlcy9rZXJuZWwtdG9vbHMvYmxvYi90cnVuay9jb2NjaW5l
bGxlL2V4YW1wbGVzL2NvdW50ZWRfYnkuY29jY2kgWzFdDQo+IFNpZ25lZC1vZmYtYnk6IEtlZXMg
Q29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODkvY29leC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L2NvZXguYw0KPiBpbmRleCA0YmE4YjNkZjcwYWUuLmQ2NmExMTUyYzNmNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMNCj4gQEAgLTIz
Nyw3ICsyMzcsNyBAQCBzdHJ1Y3QgcnR3ODlfYnRjX2J0Zl9zZXRfcmVwb3J0IHsNCj4gIHN0cnVj
dCBydHc4OV9idGNfYnRmX3NldF9zbG90X3RhYmxlIHsNCj4gICAgICAgICB1OCBmdmVyOw0KPiAg
ICAgICAgIHU4IHRibF9udW07DQo+IC0gICAgICAgdTggYnVmW107DQo+ICsgICAgICAgdTggYnVm
W10gX19jb3VudGVkX2J5KHRibF9udW0pOw0KDQpUaGlzIHN0cnVjdCBpc24ndCBkZWZpbmVkIHBy
b3Blcmx5LiBJdCBzaG91bGQgYmUgDQoNCnN0cnVjdCBydHc4OV9idGNfYnRmX3NldF9zbG90X3Rh
YmxlIHsNCgl1OCBmdmVyOw0KCXU4IHRibF9udW07DQoJc3RydWN0IHJ0dzg5X2J0Y19mYnRjX3Ns
b3QgdGJsW10gX19jb3VudGVkX2J5KHRibF9udW0pOw0KfSBfX3BhY2tlZDsNCg0KQW5kLCB3ZSBz
aG91bGQgbW9kaWZ5IHJ0dzg5X2J0Y19md19zZXRfc2xvdHMoKSBhcyB3ZWxsLiANCg0KQW5vdGhl
ciBzdHJ1Y3QgJ3J0dzg5X2J0Y19idGZfc2V0X21vbl9yZWcnIGhhcyBzaW1pbGFyIHByb2JsZW0u
DQoNClNvLCBOQUNLIHRoaXMgcGF0Y2guIEkgd2lsbCBwcmVwYXJlIG9uZSBvciB0d28gcGF0Y2hl
cyBmb3IgdGhlbSBuZXh0IHdlZWsuIA0KDQpCeSB0aGUgd2F5LCBJIGhhdmUgcXVlc3Rpb24gYWJv
dXQgX19jb3VudGVkX2J5KCkuIENhbiBJIGFwcGx5IGl0IHRvIGxpdHRsZS9iaWctDQplbmRpYW4g
J251bSc/IExpa2UNCg0Kc3RydWN0IGZvbyB7DQoJLi4uDQoJX19sZTMyIG51bTsNCglfX2xlMzIg
ZGF0YVtdIF9fY291bnRlZF9ieShudW0pOw0KfQ0KDQoNCj4gIH0gX19wYWNrZWQ7DQo+IA0KPiAg
c3RydWN0IHJ0dzg5X2J0Y19idGZfc2V0X21vbl9yZWcgew0KPiAtLQ0KPiAyLjM0LjENCj4gDQoN
Cg0KDQo=
