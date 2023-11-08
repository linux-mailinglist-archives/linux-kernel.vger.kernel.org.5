Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470E07E513A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjKHHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjKHHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:40:31 -0500
Received: from hmat.qianxin.com (hmat.qianxin.com [220.181.41.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D28AAF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:40:22 -0800 (PST)
Received: from hmat.qianxin.com (unknown [10.44.121.88])
        by hmat.qianxin.com (SkyGuard) with ESMTPS id 4SQH6w4n2Tz2LZmc;
        Wed,  8 Nov 2023 15:40:08 +0800 (CST)
Received: from qax-bjmail06.ESG.360ES.CN
 (2402:d040:0:8425:2849:52e7:3abe:7096) by qax-bjmail04.ESG.360ES.CN
 (2402:d040:0:8425:e8d8:c276:4bf1:2b8c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 15:40:08 +0800
Received: from qax-bjmail06.ESG.360ES.CN ([fe80::2849:52e7:3abe:7096]) by
 qax-bjmail06.ESG.360ES.CN ([fe80::2849:52e7:3abe:7096%5]) with mapi id
 15.01.2507.031; Wed, 8 Nov 2023 15:40:08 +0800
From:   =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Marco Elver <elver@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Reply: A null-ptr crash in linux-6.4 usb driver
Thread-Topic: Reply: A null-ptr crash in linux-6.4 usb driver
Thread-Index: AdoSFgP0DPn+YGr3QtGlMviRGOA6Gg==
Date:   Wed, 8 Nov 2023 07:40:08 +0000
Message-ID: <043105feee62401f833a06ea480a3b1b@qianxin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.110.178.148]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBoYXZlIG1hZGUgYSBwYXRjaCB0aGF0IHNpbXBseSBjaGVja3MgZm9yIG51bGwgcG9pbnRlciwg
YnV0IEkgYW0gbm90IHN1cmUgaWYgdGhpcyB3aWxsIGFmZmVjdCBjZXJ0YWluIGZ1bmN0aW9ucyBv
ciBsb2dpYy4gSSBob3BlIHlvdSBjYW4gY2hlY2sgaXQgY2FyZWZ1bGx5Lg0KDQoxMDA2YzEwMDYN
CjwgICAgICAgaWYgKGRldi0+cC0+ZGVhZCkgew0KLS0tDQo+ICAgICAgIGlmICghZGV2LT5wfHxk
ZXYtPnAtPmRlYWQpIHsNCg0KDQoNCj5UcnkgaXQgYW5kIHNlZSEgIFlvdSBoYXZlIHRoZSByZXBy
b2R1Y2VyLCBzbyB5b3UgYXJlIGluIHRoZSBiZXN0IHBvc2l0aW9uIHRvIHdvcmsgb24gdGhpcy4N
Cg==
