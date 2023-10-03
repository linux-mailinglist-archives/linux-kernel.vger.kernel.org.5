Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F57B5F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjJCC0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjJCC0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:26:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE52AD;
        Mon,  2 Oct 2023 19:26:06 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3932Pry361367183, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3932Pry361367183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 10:25:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 10:25:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Oct 2023 10:25:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 3 Oct 2023 10:25:53 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Chanwoo Choi <chanwoo@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Thread-Topic: [PATCH v3 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Thread-Index: AQHZ3u58OLY8hY7bwUySjxPCOIjYqLAgN6uggBZR8QCAAPlCYA==
Date:   Tue, 3 Oct 2023 02:25:53 +0000
Message-ID: <294cca4cfd77430ba4aae76567277439@realtek.com>
References: <20230904051253.23208-1-stanley_chang@realtek.com>
 <43138ac278224fb78055c5c78e93cfb0@realtek.com>
 <CAGTfZH0QTYCXF_hpPw_gHMBX4Mf-ZQ_5auU4p-20CtYtcOWYoA@mail.gmail.com>
In-Reply-To: <CAGTfZH0QTYCXF_hpPw_gHMBX4Mf-ZQ_5auU4p-20CtYtcOWYoA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hhbndvbywNCg0KVGhhbmsgeW91IHNvIG11Y2guDQoNClN0YW5sZXkNCj4gDQo+IA0KPiBI
aSBTdGFubGV5LA0KPiANCj4gQXBwbGllZCB0aGVtIHdpdGggcGF0Y2gxLzIuDQo+IA0KPiBJJ20g
c29ycnkgZm9yIGxhdGUgcmVwbHkuDQo+IA0KPiBSZWdhcmRzLA0KPiBDaGFud29vIENob2kNCj4g
DQoNCg==
