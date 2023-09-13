Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44FD79E367
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbjIMJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIMJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:19:36 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 02:19:31 PDT
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA21999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:19:31 -0700 (PDT)
Received: from sunying$isrc.iscas.ac.cn ( [180.111.102.117] ) by
 ajax-webmail-APP-10 (Coremail) ; Wed, 13 Sep 2023 17:11:50 +0800
 (GMT+08:00)
X-Originating-IP: [180.111.102.117]
Date:   Wed, 13 Sep 2023 17:11:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   sunying@isrc.iscas.ac.cn
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn,
        renyanjie01@gmail.com
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bit.c and bus.c with a
 series of the non-existing config "NOUVEAU_I2C_INTERNAL"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <501c0133.60683.18a8dcfa512.Coremail.sunying@isrc.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tACowAD3_1_WfAFlSG4KAA--.54825W
X-CM-SenderInfo: 5vxq5x1qj6x21ufox2xfdvhtffof0/1tbiCgUNCmUBThuxbAAAsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIHNvdXJjZSBmaWxlcyBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRldi9p
MmMvYml0LmM6MjYgYW5kCiBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRldi9pMmMv
YnVzLmM6MjE0IHJlZmVyIHRvCiBjb25maWd1cmF0aW9uIG9wdGlvbnMgIkNPTkZJR19OT1VWRUFV
X0kyQ19JTlRFUk5BTCIgYW5kIAoiQ09ORklHX05PVVZFQVVfSTJDX0lOVEVSTkFMX0RFRkFVTFQi
IGZvciBjb25kaXRpb25hbCBjb21waWxhdGlvbiwKYnV0IHRoZXNlIGNvbmZpZ3VyYXRpb24gb3B0
aW9ucyBhcmUgbm90IGRlZmluZWQgaW4gYW55IGtjb25maWcgZmlsZXMsCndoaWNoIG1lYW5zIHRo
ZSAiI2lmZGVmIENPTkZJR19OT1VWRUFVX0kyQ19JTlRFUk5BTF94eHgiIGNvbmRpdGlvbiBjb250
YWlucyBkZWFkIGNvZGUuCgpEbyB0aGVzZSBjb25maWd1cmF0aW9uIG9wdGlvbnMgbmVlZCB0byBi
ZSByZXRhaW5lZCBhbmQgYWRkZWQgbGF0ZXI/CiBPciBjYW4gd2Ugc2ltcGx5IGRyb3AgdGhlIGRl
YWQgY29kZT8KCgpCZXN0IHJlZ2FyZHMsCllhbmppZSBSZW4KWWluZyBTdW4KCgo=
