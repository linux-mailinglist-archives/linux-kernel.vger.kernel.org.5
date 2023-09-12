Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9779C941
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjILIHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjILIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:06:41 -0400
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366F4236
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:04:00 -0700 (PDT)
Received: from sunying$nj.iscas.ac.cn ( [180.111.102.117] ) by
 ajax-webmail-APP-10 (Coremail) ; Tue, 12 Sep 2023 16:03:56 +0800
 (GMT+08:00)
X-Originating-IP: [180.111.102.117]
Date:   Tue, 12 Sep 2023 16:03:56 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   sunying@nj.iscas.ac.cn
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?5L6v5pyL5pyL?= <pengpeng@iscas.ac.cn>,
        renyanjie01@gmail.com
Subject: arch/csky/abiv2/inc/abi/fpu.h with a series of the non-existing
 config "OPEN_FPU_xxx"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7afcf320.5c2f1.18a886b202f.Coremail.sunying@nj.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tACowAD3_19sGwBlPwgKAA--.51735W
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/1tbiCgUMAWT-9DmJnwABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIGhlYWRlciBmaWxlIGFyY2gvY3NreS9hYml2Mi9pbmMvYWJpL2ZwdS5oLCBsaW5lcyAz
MC02NCByZWZlciB0bwogYSBzZXJpZXMgb2YgY29uZmlndXJhdGlvbiBvcHRpb25zIHN0YXJ0aW5n
IHdpdGggIk9QRU5fRlBVIiBmb3IgY29uZGl0aW9uYWwgY29tcGlsYXRpb24sCiBidXQgdGhlc2Ug
Y29uZmlndXJhdGlvbiBvcHRpb25zIGFyZSBub3QgZGVmaW5lZCBpbiBhbnkga2NvbmZpZyBmaWxl
cywKIHdoaWNoIG1lYW5zIHRoZSAiI2lmZGVmIENPTkZJR19PUEVOX0ZQVV94eHgiIGNvbmRpdGlv
biBjb250YWlucyBkZWFkIGNvZGUuCgpEbyB0aGVzZSBjb25maWd1cmF0aW9uIG9wdGlvbnMgbmVl
ZCB0byBiZSByZXRhaW5lZCBhbmQgYWRkZWQgbGF0ZXI/IE9yIGNhbiB3ZSBzaW1wbHkgZHJvcCB0
aGUgZGVhZCBjb2RlPwoKCkJlc3QgcmVnYXJkcywKWWFuamllIFJlbgpZaW5nIFN1bg==
