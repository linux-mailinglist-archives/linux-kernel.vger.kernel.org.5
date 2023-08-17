Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC777EEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHQCH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHQCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:07:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A38D268F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:07:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37H26OJd8016210, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37H26OJd8016210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 10:06:25 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 17 Aug 2023 10:06:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 17 Aug 2023 10:06:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 17 Aug 2023 10:06:44 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
Thread-Topic: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
Thread-Index: AQHZ0E08ScgrpcreG0KiXxOIOuSUw6/tvaCw
Date:   Thu, 17 Aug 2023 02:06:44 +0000
Message-ID: <6c02765f89eb4455806b895a6e0cb763@realtek.com>
References: <202308161422.37GEMlZkA018197@rtits1.realtek.com.tw>
In-Reply-To: <202308161422.37GEMlZkA018197@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
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

SGkgR2VlcnQsDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3JlYWx0ZWsvS2NvbmZpZyBi
L2RyaXZlcnMvcGh5L3JlYWx0ZWsvS2NvbmZpZyBpbmRleA0KPiA2NTBlMjBlZDY5YWY0MWQyLi43
NWFjN2U3YzMxYWVjNmYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9yZWFsdGVrL0tjb25m
aWcNCj4gKysrIGIvZHJpdmVycy9waHkvcmVhbHRlay9LY29uZmlnDQo+IEBAIC0yLDYgKzIsOSBA
QA0KPiAgIw0KPiAgIyBQaHkgZHJpdmVycyBmb3IgUmVhbHRlayBwbGF0Zm9ybXMNCj4gICMNCj4g
Kw0KPiAraWYgQVJDSF9SRUFMVEVLIHx8IENPTVBJTEVfVEVTVA0KPiArDQo+ICBjb25maWcgUEhZ
X1JUS19SVERfVVNCMlBIWQ0KPiAgICAgICAgIHRyaXN0YXRlICJSZWFsdGVrIFJURCBVU0IyIFBI
WSBUcmFuc2NlaXZlciBEcml2ZXIiDQo+ICAgICAgICAgZGVwZW5kcyBvbiBVU0JfU1VQUE9SVA0K
PiBAQCAtMjUsMyArMjgsNSBAQCBjb25maWcgUEhZX1JUS19SVERfVVNCM1BIWQ0KPiAgICAgICAg
ICAgVGhlIERIQyAoZGlnaXRhbCBob21lIGNlbnRlcikgUlREIHNlcmllcyBTb0NzIHVzZWQgdGhl
IFN5bm9wc3lzDQo+ICAgICAgICAgICBEV0MzIFVTQiBJUC4gVGhpcyBkcml2ZXIgd2lsbCBkbyB0
aGUgUEhZIGluaXRpYWxpemF0aW9uDQo+ICAgICAgICAgICBvZiB0aGUgcGFyYW1ldGVycy4NCj4g
Kw0KPiArZW5kaWYgIyBBUkNIX1JFQUxURUsgfHwgQ09NUElMRV9URVNUDQoNClRoYW5rcyBmb3Ig
eW91ciBwYXRjaC4NCldoeSBub3QgdXNlICJkZXBlbmRzIG9uIj8NCmRlcGVuZHMgb24gQVJDSF9N
RURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
