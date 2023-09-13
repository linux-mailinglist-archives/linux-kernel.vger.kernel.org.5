Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C079E3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjIMJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjIMJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:29:41 -0400
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846410DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:29:36 -0700 (PDT)
Received: from sunying$isrc.iscas.ac.cn ( [180.111.102.117] ) by
 ajax-webmail-APP-10 (Coremail) ; Wed, 13 Sep 2023 17:29:33 +0800
 (GMT+08:00)
X-Originating-IP: [180.111.102.117]
Date:   Wed, 13 Sep 2023 17:29:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   sunying@isrc.iscas.ac.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "renyanjie01@gmail.com" <renyanjie01@gmail.com>
Subject: Non-existing CONFIG_ options are used in source code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4e8525fe.607e2.18a8ddfdce8.Coremail.sunying@isrc.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tACowAC3H+T9gAFlOXAKAA--.25517W
X-CM-SenderInfo: 5vxq5x1qj6x21ufox2xfdvhtffof0/1tbiCQgNCmUBTe3BqAAAsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBjb25maWd1cmF0aW9uIG9wdGlvbnMgYXJlIG5vdCBkZWZpbmVkCiAodGhl
eSBtYXkgaGF2ZSBiZWVuIGRlbGV0ZWQgb3Igbm90IHlldCBhZGRlZCkKIGJ1dCBhcmUgdXNlZCBp
biB0aGUgc291cmNlIGZpbGVzLgoKSXMgdGhlcmUgc29tZXRoaW5nIGluIHRoZXNlIHRoYXQgbWln
aHQgbmVlZCBmaXhpbmc/Cgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQoxLiBDT05GSUdfTkVURlNfREVCVUcKZnMvbmV0ZnMvaW50ZXJuYWwuaDoxMjI6I2Vs
aWYgZGVmaW5lZChDT05GSUdfTkVURlNfREVCVUcpCgoyLiBDT05GSUdfU1NCX0RFQlVHCmluY2x1
ZGUvbGludXgvc3NiL3NzYi5oOjYyNjojaWZkZWYgQ09ORklHX1NTQl9ERUJVRwoKMy4gQ09ORklH
X0NSWVBUT19ERVZfQVNQRUVEX0hBQ0VfQ1JZUFRPX0RFQlVHCmRyaXZlcnMvY3J5cHRvL2FzcGVl
ZC9hc3BlZWQtaGFjZS1jcnlwdG8uYzoxOTojaWZkZWYgQ09ORklHX0NSWVBUT19ERVZfQVNQRUVE
X0hBQ0VfQ1JZUFRPX0RFQlVHCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CgoKCkJlc3QgcmVnYXJkcywKWWFuamllIFJlbgpZaW5nIFN1bgo=
