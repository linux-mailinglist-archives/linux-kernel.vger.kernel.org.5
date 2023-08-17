Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635377F0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbjHQGyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348341AbjHQGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:54:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76CA82102
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:54:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37H6r0omD007140, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37H6r0omD007140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 14:53:00 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 17 Aug 2023 14:53:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Aug 2023 14:53:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 17 Aug 2023 14:53:20 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
Thread-Topic: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
Thread-Index: AQHZ0E08ScgrpcreG0KiXxOIOuSUw6/tvaCw///IwICAAIfRAA==
Date:   Thu, 17 Aug 2023 06:53:20 +0000
Message-ID: <9a7ba7ac11f745ee8d80da105ba79811@realtek.com>
References: <202308161422.37GEMlZkA018197@rtits1.realtek.com.tw>
 <6c02765f89eb4455806b895a6e0cb763@realtek.com> <ZN3CQ1Y3yC9p/01Y@matsya>
In-Reply-To: <ZN3CQ1Y3yC9p/01Y@matsya>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3JlYWx0ZWsvS2NvbmZpZw0KPiA+ID4gYi9k
cml2ZXJzL3BoeS9yZWFsdGVrL0tjb25maWcgaW5kZXgNCj4gPiA+IDY1MGUyMGVkNjlhZjQxZDIu
Ljc1YWM3ZTdjMzFhZWM2ZjIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BoeS9yZWFsdGVr
L0tjb25maWcNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGh5L3JlYWx0ZWsvS2NvbmZpZw0KPiA+ID4g
QEAgLTIsNiArMiw5IEBADQo+ID4gPiAgIw0KPiA+ID4gICMgUGh5IGRyaXZlcnMgZm9yIFJlYWx0
ZWsgcGxhdGZvcm1zICAjDQo+ID4gPiArDQo+ID4gPiAraWYgQVJDSF9SRUFMVEVLIHx8IENPTVBJ
TEVfVEVTVA0KPiA+ID4gKw0KPiA+ID4gIGNvbmZpZyBQSFlfUlRLX1JURF9VU0IyUEhZDQo+ID4g
PiAgICAgICAgIHRyaXN0YXRlICJSZWFsdGVrIFJURCBVU0IyIFBIWSBUcmFuc2NlaXZlciBEcml2
ZXIiDQo+ID4gPiAgICAgICAgIGRlcGVuZHMgb24gVVNCX1NVUFBPUlQNCj4gPiA+IEBAIC0yNSwz
ICsyOCw1IEBAIGNvbmZpZyBQSFlfUlRLX1JURF9VU0IzUEhZDQo+ID4gPiAgICAgICAgICAgVGhl
IERIQyAoZGlnaXRhbCBob21lIGNlbnRlcikgUlREIHNlcmllcyBTb0NzIHVzZWQgdGhlDQo+IFN5
bm9wc3lzDQo+ID4gPiAgICAgICAgICAgRFdDMyBVU0IgSVAuIFRoaXMgZHJpdmVyIHdpbGwgZG8g
dGhlIFBIWSBpbml0aWFsaXphdGlvbg0KPiA+ID4gICAgICAgICAgIG9mIHRoZSBwYXJhbWV0ZXJz
Lg0KPiA+ID4gKw0KPiA+ID4gK2VuZGlmICMgQVJDSF9SRUFMVEVLIHx8IENPTVBJTEVfVEVTVA0K
PiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiA+IFdoeSBub3QgdXNlICJkZXBlbmRz
IG9uIj8NCj4gPiBkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQo+IA0K
PiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgYmV0dGVyLCB0aGlzIHdheSBhbGwgZnV0dXJlIHJ0ZWsg
ZHJpdmVycyB3aWxsIGJlIGZpeGVkIGFzIHdlbGwsDQo+IG5vIG5lZWQgdG8gYWRkIGZvciBlYWNo
IGRyaXZlcg0KPiANCk9rLCB0aGFua3MsDQpTdGFubGV5DQoNCg0K
