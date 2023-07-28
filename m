Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E643766F90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbjG1Of1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjG1Of0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:35:26 -0400
Received: from out28-131.mail.aliyun.com (out28-131.mail.aliyun.com [115.124.28.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAF3AB4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:35:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08700002|-1;BR=01201311R131S69rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00311369-0.000355902-0.99653;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5_212501EE_1690554907535_o7001c54a;
Received: from WS-web (sunran001@208suo.com[W4_0.2.3_v5_212501EE_1690554907535_o7001c54a]) at Fri, 28 Jul 2023 22:35:19 +0800
Date:   Fri, 28 Jul 2023 22:35:19 +0800
From:   "=?UTF-8?B?5a2Z5YaJ?=" <sunran001@208suo.com>
To:     "airlied" <airlied@gmail.com>, "daniel" <daniel@ffwll.ch>,
        "alexander.deucher" <alexander.deucher@amd.com>
Cc:     "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "=?UTF-8?B?5a2Z5YaJ?=" <sunran001@208suo.com>
Message-ID: <3a4bebc5-79fb-4799-8743-14a0dde97a4f.sunran001@208suo.com>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vcmFkZW9uOiBQcmVmZXIgJ3Vuc2lnbmVkIGludCcgdG8gYmFyZSB1c2Ug?=
  =?UTF-8?B?b2YgJ3Vuc2lnbmVkJw==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5][Chrome]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_0.2.3_v5_TCwTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNS4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMTUuMC4xOTAxLjE4Mw==FR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V0FSTklORzogUHJlZmVyICd1bnNpZ25lZCBpbnQnIHRvIGJhcmUgdXNlIG9mICd1bnNpZ25lZCcK
ClNpZ25lZC1vZmYtYnk6IFJhbiBTdW4gPHN1bnJhbjAwMUAyMDhzdW8uY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5oIHwgOCArKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX29iamVjdC5oCmluZGV4IDM5Y2M4N2E1OWE5YS4uOWI1NWE3MTAzY2ZkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuaApAQCAtMzcsNyArMzcsNyBAQAogICoK
ICAqIFJldHVybnMgY29ycmVzcG9uZGluZyBkb21haW4gb2YgdGhlIHR0bSBtZW1fdHlwZQogICov
Ci1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIHJhZGVvbl9tZW1fdHlwZV90b19kb21haW4odTMyIG1l
bV90eXBlKQorc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgcmFkZW9uX21lbV90eXBlX3RvX2Rv
bWFpbih1MzIgbWVtX3R5cGUpCiB7CiAgc3dpdGNoIChtZW1fdHlwZSkgewogIGNhc2UgVFRNX1BM
X1ZSQU06CkBAIC0xMTIsMTIgKzExMiwxMiBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcg
cmFkZW9uX2JvX3NpemUoc3RydWN0IHJhZGVvbl9ibyAqYm8pCiAgcmV0dXJuIGJvLT50Ym8uYmFz
ZS5zaXplOwogfQogCi1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIHJhZGVvbl9ib19uZ3B1X3BhZ2Vz
KHN0cnVjdCByYWRlb25fYm8gKmJvKQorc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgcmFkZW9u
X2JvX25ncHVfcGFnZXMoc3RydWN0IHJhZGVvbl9ibyAqYm8pCiB7CiAgcmV0dXJuIGJvLT50Ym8u
YmFzZS5zaXplIC8gUkFERU9OX0dQVV9QQUdFX1NJWkU7CiB9CiAKLXN0YXRpYyBpbmxpbmUgdW5z
aWduZWQgcmFkZW9uX2JvX2dwdV9wYWdlX2FsaWdubWVudChzdHJ1Y3QgcmFkZW9uX2JvICpibykK
K3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHJhZGVvbl9ib19ncHVfcGFnZV9hbGlnbm1lbnQo
c3RydWN0IHJhZGVvbl9ibyAqYm8pCiB7CiAgcmV0dXJuIChiby0+dGJvLnBhZ2VfYWxpZ25tZW50
IDw8IFBBR0VfU0hJRlQpIC8gUkFERU9OX0dQVV9QQUdFX1NJWkU7CiB9CkBAIC0xODksNyArMTg5
LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICpyYWRlb25fc2FfYm9fY3B1X2FkZHIoc3RydWN0IGRy
bV9zdWJhbGxvYyAqc2FfYm8pCiAKIGV4dGVybiBpbnQgcmFkZW9uX3NhX2JvX21hbmFnZXJfaW5p
dChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKICAgICAgICAgIHN0cnVjdCByYWRlb25fc2Ff
bWFuYWdlciAqc2FfbWFuYWdlciwKLSAgICAgICAgIHVuc2lnbmVkIHNpemUsIHUzMiBhbGlnbiwg
dTMyIGRvbWFpbiwKKyAgICAgICAgIHVuc2lnbmVkIGludCBzaXplLCB1MzIgYWxpZ24sIHUzMiBk
b21haW4sCiAgICAgICAgICB1MzIgZmxhZ3MpOwogZXh0ZXJuIHZvaWQgcmFkZW9uX3NhX2JvX21h
bmFnZXJfZmluaShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKICAgICAgICAgICBzdHJ1Y3Qg
cmFkZW9uX3NhX21hbmFnZXIgKnNhX21hbmFnZXIpOwotLSAKMi4xNy4xCgo=
