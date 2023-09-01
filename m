Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91B78FB82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbjIAJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIAJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:55:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B971FC;
        Fri,  1 Sep 2023 02:55:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3819t8Bv9014444, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3819t8Bv9014444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 17:55:08 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 17:55:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Sep 2023 17:55:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Fri, 1 Sep 2023 17:55:33 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] dt-bindings: pinctrl: realtek: add RTD1315E pinctrl binding
Thread-Topic: [PATCH v2 5/7] dt-bindings: pinctrl: realtek: add RTD1315E
 pinctrl binding
Thread-Index: AQHZ1s+HbgdteTQm50qw2SI6YdXagLAA5J2A//9/1QCABWFPgA==
Date:   Fri, 1 Sep 2023 09:55:33 +0000
Message-ID: <4b3ec041f2144c099b3108c80c4d889c@realtek.com>
References: <20230824105703.19612-1-tychang@realtek.com>
 <20230824105703.19612-6-tychang@realtek.com>
 <20230824211121.GA1388146-robh@kernel.org>
 <14b8a56d55af4b689cf06f9ff0fab30b@realtek.com>
 <9e22cc04-a153-4aff-2783-2e6cbc7cc9c1@linaro.org>
In-Reply-To: <9e22cc04-a153-4aff-2783-2e6cbc7cc9c1@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+DQo+VHJpbSB1bnJlbGV2YW50IHBhcnRzIG9mIHRoZSBxdW90ZSwg
c28gd2UgZG8gbm90IG5lZWQgdG8gc2Nyb2xsIGVudGlyZSBtZXNzYWdlIHRvDQo+ZmluZCB0aGF0
IHlvdSBkaWQgbm90IHdhbnQgdG8gc2F5IGFueXRoaW5nIG1vcmUuDQoNClRoYW5rIHlvdSBmb3Ig
dGhlIHJlbWluZGVyLiBJJ2xsIHRyaW0gaXQgbmV4dCB0aW1lLg0KDQo+DQo+QmVzdCByZWdhcmRz
LA0KPktyenlzenRvZg0KPg0KDQpUaGFua3MsDQpUenV5aSBDaGFuZw0KDQo=
