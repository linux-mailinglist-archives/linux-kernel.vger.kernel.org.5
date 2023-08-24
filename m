Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB3786753
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbjHXGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbjHXGJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:09:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AA9C10F3;
        Wed, 23 Aug 2023 23:09:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37O68pmU6020106, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37O68pmU6020106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 14:08:51 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 24 Aug 2023 14:09:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Aug 2023 14:09:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 14:09:14 +0800
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
Subject: RE: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Thread-Topic: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Thread-Index: AQHZ1ONvA6JhKCipAECuqR11IG4J/a/17JuAgAMMUbA=
Date:   Thu, 24 Aug 2023 06:09:14 +0000
Message-ID: <46f0b3f33e884098b7336f29df2d5821@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <e33cd680-eeca-ac4b-ee4a-4c0a1d6cd00c@linaro.org>
In-Reply-To: <e33cd680-eeca-ac4b-ee4a-4c0a1d6cd00c@linaro.org>
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

SGkgS3J6eXN6dG9mLA0KDQo+IA0KPiANCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgZXh0Y29uX3J0a190eXBlX2NfZHJpdmVyID0gew0KPiA+ICsgICAgIC5wcm9iZSAgICAgICAg
ICA9IGV4dGNvbl9ydGtfdHlwZV9jX3Byb2JlLA0KPiA+ICsgICAgIC5yZW1vdmVfbmV3ICAgICA9
IGV4dGNvbl9ydGtfdHlwZV9jX3JlbW92ZSwNCj4gPiArICAgICAuZHJpdmVyICAgICAgICAgPSB7
DQo+ID4gKyAgICAgICAgICAgICAubmFtZSAgID0gImV4dGNvbi1ydGstdHlwZV9jIiwNCj4gPiAr
ICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IGV4dGNvbl9ydGtfdHlwZV9jX21hdGNoLA0K
PiA+ICsgICAgICAgICAgICAgLnBtID0gREVWX1BNX09QUywNCj4gPiArICAgICB9LA0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihleHRjb25fcnRrX3R5cGVfY19k
cml2ZXIpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJSZWFsdGVrIEV4dGNvbiBU
eXBlIEMgZHJpdmVyIik7DQo+ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06ZXh0Y29uLXJ0ay10
eXBlLWMiKTsNCj4gDQo+IERyb3AgYWxpYXMuIFlvdSBoYXZlIHNvbWV0aGluZyByZWFsbHkgbWlz
c2luZyBoZXJlIGlmIHlvdSBuZWVkIGl0Lg0KDQpPa2F5LiBJIHdpbGwgcmVtb3ZlLg0KDQo+ID4g
K01PRFVMRV9BVVRIT1IoIlN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+
Iik7DQo+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gDQpUaGFua3MsDQpTdGFubGV5DQo=
