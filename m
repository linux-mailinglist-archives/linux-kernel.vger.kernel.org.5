Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0459D7A7DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjITMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjITMLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:11:46 -0400
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298BAD;
        Wed, 20 Sep 2023 05:11:37 -0700 (PDT)
Received: from wangchen20$iscas.ac.cn ( [222.95.63.58] ) by
 ajax-webmail-APP-13 (Coremail) ; Wed, 20 Sep 2023 20:03:50 +0800
 (GMT+08:00)
X-Originating-IP: [222.95.63.58]
Date:   Wed, 20 Sep 2023 20:03:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5rGq6L6w?= <wangchen20@iscas.ac.cn>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "Chen Wang" <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, xiaoguang.xing@sophgo.com
Subject: Re: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042
 bindings
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
In-Reply-To: <ec11eb6a-c37b-08bd-5997-8fc390fd58c8@linaro.org>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <ec11eb6a-c37b-08bd-5997-8fc390fd58c8@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3d2bba58.29898.18ab279a15c.Coremail.wangchen20@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: twCowAB3BOam3wpl01IMAA--.34858W
X-CM-SenderInfo: 5zdqwuhkhqji46lvutnvoduhdfq/1tbiBwIABmUKzVQmtwABsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIG15IG1pc3Rha2UgdG8gZm9yZ2V0IGFkZGluZyB0aGUgdGFnLCB3aWxsIGFkZCBpbiBu
ZXh0IHJldmlzaW9uLgoKCiZndDsgLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQomZ3Q7IOWPkeS7tuS6
ujogIktyenlzenRvZiBLb3psb3dza2kiIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+
CiZndDsg5Y+R6YCB5pe26Ze0OiAyMDIzLTA5LTIwIDE5OjU1OjMwICjmmJ/mnJ/kuIkpCiZndDsg
5pS25Lu25Lq6OiAiQ2hlbiBXYW5nIiA8dW5pY29ybnh3QGdtYWlsLmNvbT4sIGFvdUBlZWNzLmJl
cmtlbGV5LmVkdSwgY2hhby53ZWlAc29waGdvLmNvbSwgY29ub3JAa2VybmVsLm9yZywgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20s
IGd1b3JlbkBrZXJuZWwub3JnLCBqc3poYW5nQGtlcm5lbC5vcmcsIGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgbGludXgtcmlz
Y3ZAbGlzdHMuaW5mcmFkZWFkLm9yZywgcGFsbWVyQGRhYmJlbHQuY29tLCBwYXVsLndhbG1zbGV5
QHNpZml2ZS5jb20sIHJvYmgrZHRAa2VybmVsLm9yZywgeGlhb2d1YW5nLnhpbmdAc29waGdvLmNv
bQomZ3Q7IOaKhOmAgTogIkNoZW4gV2FuZyIgPHdhbmdjaGVuMjBAaXNjYXMuYWMuY24+CiZndDsg
5Li76aKYOiBSZTogW1BBVENIIHYyIDAzLzExXSBkdC1iaW5kaW5nczogcmlzY3Y6IGFkZCBzb3Bo
Z28gc2cyMDQyIGJpbmRpbmdzCiZndDsgCiZndDsgT24gMjAvMDkvMjAyMyAwODozNywgQ2hlbiBX
YW5nIHdyb3RlOgomZ3Q7ICZndDsgQWRkIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhl
IFNvcGhnbyBTRzIwNDIgU29jIFsxXSBhbmQgdGhlCiZndDsgJmd0OyBNaWxrLVYgUGlvbmVlciBi
b2FyZCBbMl0uCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IFsxXTogaHR0cHM6Ly9lbi5zb3BoZ28uY29t
L3Byb2R1Y3QvaW50cm9kdWNlL3NnMjA0Mi5odG1sCiZndDsgJmd0OyBbMl06IGh0dHBzOi8vbWls
a3YuaW8vcGlvbmVlcgomZ3Q7IAomZ3Q7IFRoaXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBkdXJp
bmcgdGhlIHJldmlldyBwcm9jZXNzLgomZ3Q7IAomZ3Q7IEl0IGxvb2tzIGxpa2UgeW91IHJlY2Vp
dmVkIGEgdGFnIGFuZCBmb3Jnb3QgdG8gYWRkIGl0LgomZ3Q7IAomZ3Q7IElmIHlvdSBkbyBub3Qg
a25vdyB0aGUgcHJvY2VzcywgaGVyZSBpcyBhIHNob3J0IGV4cGxhbmF0aW9uOgomZ3Q7IFBsZWFz
ZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkvVGVzdGVkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5l
dwomZ3Q7IHZlcnNpb25zLCB1bmRlciBvciBhYm92ZSB5b3VyIFNpZ25lZC1vZmYtYnkgdGFnLiBU
YWcgaXMgInJlY2VpdmVkIiwgd2hlbgomZ3Q7IHByb3ZpZGVkIGluIGEgbWVzc2FnZSByZXBsaWVk
IHRvIHlvdSBvbiB0aGUgbWFpbGluZyBsaXN0LiBUb29scyBsaWtlIGI0CiZndDsgY2FuIGhlbHAg
aGVyZS4gSG93ZXZlciwgdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0
byBhZGQKJmd0OyB0aGUgdGFncy4gVGhlIHVwc3RyZWFtIG1haW50YWluZXIgd2lsbCBkbyB0aGF0
IGZvciB0YWdzIHJlY2VpdmVkIG9uIHRoZQomZ3Q7IHZlcnNpb24gdGhleSBhcHBseS4KJmd0OyAK
Jmd0OyBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni41LXJjMy9zb3VyY2UvRG9j
dW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QjTDU3NwomZ3Q7IAomZ3Q7
IElmIGEgdGFnIHdhcyBub3QgYWRkZWQgb24gcHVycG9zZSwgcGxlYXNlIHN0YXRlIHdoeSBhbmQg
d2hhdCBjaGFuZ2VkLgomZ3Q7IAomZ3Q7IEJlc3QgcmVnYXJkcywKJmd0OyBLcnp5c3p0b2YKCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCkJlc3QgUmVnYXJkcyAKIAog5rGq6L6wKFdh
bmcgQ2hlbikgCgo8L3dhbmdjaGVuMjBAaXNjYXMuYWMuY24+PC91bmljb3JueHdAZ21haWwuY29t
Pjwva3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg==
