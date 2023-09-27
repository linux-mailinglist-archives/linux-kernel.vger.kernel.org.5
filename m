Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589877AFAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjI0GJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjI0GJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:09:01 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47DA5F9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:08:54 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:07:37
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:07:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xarray: Clean up errors in xarray.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7fc96e0.85f.18ad540066c.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUCpxhNlDeW9AA--.613W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAFEWFEYxtJMwANs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEppYW5nSHVp
IFh1IDx4dWppYW5naHVpQGNkanJsYy5jb20+Ci0tLQogaW5jbHVkZS9saW51eC94YXJyYXkuaCB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgveGFycmF5LmggYi9pbmNsdWRlL2xpbnV4L3hhcnJheS5o
CmluZGV4IGNiNTcxZGZjZjRiMS4uNDkwOTM1N2I3ZTJhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L3hhcnJheS5oCisrKyBiL2luY2x1ZGUvbGludXgveGFycmF5LmgKQEAgLTI5Nyw3ICsyOTcs
NyBAQCBzdHJ1Y3QgeGFycmF5IHsKIAlzcGlubG9ja190CXhhX2xvY2s7CiAvKiBwcml2YXRlOiBU
aGUgcmVzdCBvZiB0aGUgZGF0YSBzdHJ1Y3R1cmUgaXMgbm90IHRvIGJlIHVzZWQgZGlyZWN0bHku
ICovCiAJZ2ZwX3QJCXhhX2ZsYWdzOwotCXZvaWQgX19yY3UgKgl4YV9oZWFkOworCXZvaWQgX19y
Y3UgKnhhX2hlYWQ7CiB9OwogCiAjZGVmaW5lIFhBUlJBWV9JTklUKG5hbWUsIGZsYWdzKSB7CQkJ
CVwKLS0gCjIuMTcuMQo=
