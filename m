Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5D753260
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjGNG65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjGNG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:58:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B392171D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:58:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2MlG0MBGzBR9tP
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:58:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-type:message-id:user-agent:references:subject:to:from
        :date:mime-version; s=dkim; t=1689317929; x=1691909930; bh=BmX7S
        FBwPUkYefMqVZRLt8+DjQinCnGYUMgeD5Nrou8=; b=p+aV0JQwQuQGLzJ5U8P4y
        bsVBOfnGlNpNblyqX5HPNdgYKv58IIHjULxmXz0w4q060CDM6ABNgFBq8Xb5Kw2e
        U4nso7ngs4Bu2FCHtz8uIuBz28J0zRpnWn5YH63HH3WdpG2KfvlZfUENxX3Wev+8
        V0f9BR1QItP3dRvdiqfhb1K/WQnW7UY2KK2SQaE/8l9eQmsmF2tF36BUP8iX7kKE
        K+iOTwTNe1ftS0h38y+bP0iZJlX6+5PJ9t+1K0TCVOVCrizNg6MU491nKsny0taA
        tDhV64HrITS0EVf8k1WZFkXJBHgFG2mdSIpwSRgvg0b6dNhhcJKU7cCyBMqF4L0K
        w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZoK2-YuJnFyh for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:58:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2MlF427CzBR9sv;
        Fri, 14 Jul 2023 14:58:49 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:58:49 +0800
From:   huzhi001@208suo.com
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the gk104.c
 error: ERROR: : trailing statements should be on next line
References: <5c894d0a8a178628ca200d054004be3c@208suo.com>
 <f25017a660f8a3a4e49258a1d96003dc@208suo.com>
 <2f4a7303e305d07fdd9c15a9dc95dc5f@208suo.com>
 <d0d767fb0dd3a9b7642559f379dbb0d6@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <0ad4154429aaa41ca26da859c3f35784@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: multipart/mixed;
 boundary="=_ff68884a3fac4130d787939fa0c53b83"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_ff68884a3fac4130d787939fa0c53b83
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++-----
  1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c 
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index d8a4d773a58c..b99e0a7c96bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct 
nvkm_cctx *cctx, struct nvkm_chan
      u64 addr = 0ULL;

      switch (engn->engine->subdev.type) {
-    case NVKM_ENGINE_SW    : return;
-    case NVKM_ENGINE_GR    : ptr0 = 0x0210; break;
-    case NVKM_ENGINE_SEC   : ptr0 = 0x0220; break;
-    case NVKM_ENGINE_MSPDEC: ptr0 = 0x0250; break;
-    case NVKM_ENGINE_MSPPP : ptr0 = 0x0260; break;
-    case NVKM_ENGINE_MSVLD : ptr0 = 0x0270; break;
-    case NVKM_ENGINE_VIC   : ptr0 = 0x0280; break;
-    case NVKM_ENGINE_MSENC : ptr0 = 0x0290; break;
-    case NVKM_ENGINE_NVDEC :
+    case NVKM_ENGINE_SW:
+        return;
+    case NVKM_ENGINE_GR:
+        ptr0 = 0x0210;
+        break;
+    case NVKM_ENGINE_SEC:
+        ptr0 = 0x0220;
+        break;
+    case NVKM_ENGINE_MSPDEC:
+        ptr0 = 0x0250;
+        break;
+    case NVKM_ENGINE_MSPPP:
+        ptr0 = 0x0260;
+        break;
+    case NVKM_ENGINE_MSVLD:
+        ptr0 = 0x0270;
+        break;
+    case NVKM_ENGINE_VIC:
+        ptr0 = 0x0280; break;
+    case NVKM_ENGINE_MSENC:
+        ptr0 = 0x0290;
+        break;
+    case NVKM_ENGINE_NVDEC:
          ptr1 = 0x0270;
          ptr0 = 0x0210;
          break;
@@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct 
nvkm_memory *memory, u32 start,
      int target;

      switch (nvkm_memory_target(memory)) {
-    case NVKM_MEM_TARGET_VRAM: target = 0; break;
-    case NVKM_MEM_TARGET_NCOH: target = 3; break;
+    case NVKM_MEM_TARGET_VRAM:
+        target = 0;
+        break;
+    case NVKM_MEM_TARGET_NCOH:
+        target = 3;
+        break;
      default:
          WARN_ON(1);
          return;
--=_ff68884a3fac4130d787939fa0c53b83
Content-Type: message/rfc822;
 name="=?UTF-8?Q?=5BPATCH=5D_drm/nouveau/fifo=3AFix_Nineteen_occurrences_?=
 =?UTF-8?Q?of_the_gk104=2Ec=2Eeml?="
Content-Disposition: attachment;
 filename*0*=UTF-8''%5BPATCH%5D%20drm%2Fnouveau%2Ffifo%3AFix%20Nineteen%20;
 filename*1*=occurrences%20of%20the%20gk104.c.eml;
 size=4891
Content-Transfer-Encoding: 7bit

MIME-Version: 1.0
Date: Fri, 14 Jul 2023 11:51:25 +0800
From: huzhi001@208suo.com
To: bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the gk104.c
 error: ERROR: space prohibited before that ':' (ctx:WxW) ERROR: trailing
 statements should be on next line ERROR: space prohibited before that ':'
 (ctx:WxW) ERROR: trailing statements should be on next line ERROR: space
 prohibited before that ':' (ctx:WxW) ERROR: trailing statements should be on
 next line ERROR: trailing statements should be on next line ERROR: space
 prohibited before that ':' (ctx:WxW) ERROR: trailing statements should be on
 next line ERROR: space prohibited before that ':' (ctx:WxW) ERROR: trailing
 statements should be on next line ERROR: space prohibited before that ':'
 (ctx:WxW) ERROR: trailing statements should be on next line ERROR: space
 prohibited before that ':' (ctx:WxW) ERROR: trailing statements should be on
 next line ERROR: space prohibited before that ':' (ctx:WxE) ERROR: space
 prohibited before that ':' (ctx:WxE) ERROR: trailing statements should be on
 next line ERROR: trailing s tatements should be on next line
In-Reply-To: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
References: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <5c894d0a8a178628ca200d054004be3c@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Fix Nineteen occurrences of the checkpatch.pl error:
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxW)
ERROR: trailing statements should be on next line
ERROR: space prohibited before that ':' (ctx:WxE)
ERROR: space prohibited before that ':' (ctx:WxE)
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line
Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++-----
  1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c 
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index d8a4d773a58c..b99e0a7c96bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct 
nvkm_cctx *cctx, struct nvkm_chan
      u64 addr = 0ULL;

      switch (engn->engine->subdev.type) {
-    case NVKM_ENGINE_SW    : return;
-    case NVKM_ENGINE_GR    : ptr0 = 0x0210; break;
-    case NVKM_ENGINE_SEC   : ptr0 = 0x0220; break;
-    case NVKM_ENGINE_MSPDEC: ptr0 = 0x0250; break;
-    case NVKM_ENGINE_MSPPP : ptr0 = 0x0260; break;
-    case NVKM_ENGINE_MSVLD : ptr0 = 0x0270; break;
-    case NVKM_ENGINE_VIC   : ptr0 = 0x0280; break;
-    case NVKM_ENGINE_MSENC : ptr0 = 0x0290; break;
-    case NVKM_ENGINE_NVDEC :
+    case NVKM_ENGINE_SW:
+        return;
+    case NVKM_ENGINE_GR:
+        ptr0 = 0x0210;
+        break;
+    case NVKM_ENGINE_SEC:
+        ptr0 = 0x0220;
+        break;
+    case NVKM_ENGINE_MSPDEC:
+        ptr0 = 0x0250;
+        break;
+    case NVKM_ENGINE_MSPPP:
+        ptr0 = 0x0260;
+        break;
+    case NVKM_ENGINE_MSVLD:
+        ptr0 = 0x0270;
+        break;
+    case NVKM_ENGINE_VIC:
+        ptr0 = 0x0280; break;
+    case NVKM_ENGINE_MSENC:
+        ptr0 = 0x0290;
+        break;
+    case NVKM_ENGINE_NVDEC:
          ptr1 = 0x0270;
          ptr0 = 0x0210;
          break;
@@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct 
nvkm_memory *memory, u32 start,
      int target;

      switch (nvkm_memory_target(memory)) {
-    case NVKM_MEM_TARGET_VRAM: target = 0; break;
-    case NVKM_MEM_TARGET_NCOH: target = 3; break;
+    case NVKM_MEM_TARGET_VRAM:
+        target = 0;
+        break;
+    case NVKM_MEM_TARGET_NCOH:
+        target = 3;
+        break;
      default:
          WARN_ON(1);
          return;
--=_ff68884a3fac4130d787939fa0c53b83
Content-Type: message/rfc822;
 name="=?UTF-8?Q?=5BPATCH=5D_drm/nouveau/fifo=3AFix_Nineteen_occurrences_?=
 =?UTF-8?Q?of_the_gk104=2Ec=5F2=2Eeml?="
Content-Disposition: attachment;
 filename*0*=UTF-8''%5BPATCH%5D%20drm%2Fnouveau%2Ffifo%3AFix%20Nineteen%20;
 filename*1*=occurrences%20of%20the%20gk104.c_2.eml;
 size=3868
Content-Transfer-Encoding: 7bit

MIME-Version: 1.0
Date: Fri, 14 Jul 2023 13:14:34 +0800
From: huzhi001@208suo.com
To: bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the gk104.c
 error: ERROR: space prohibited before that ':' (ctx:WxW) ERROR: trailing
 statements should be on next line ERROR: space prohibited before that ':'
 (ctx:WxW) ERROR: trailing statements should be on next line ERROR: space
 prohibited before that ':' (ctx:WxW) ERROR: trailing statements should be on
 next line ERROR: trailing statements should be on next line ERROR: space
 prohibited before that ':' (ctx:WxW) ERROR: trailing statements should be on
 next line ERROR: space prohibited before that ':' (ctx:WxW) ERROR: trailing
 statements should be on next line ERROR: space prohibited before that ':'
 (ctx:WxW) ERROR: trailing statements should be on next line ERROR: space
 prohibited before that ':' (ctx:WxW) ERROR: trailing statements should be on
 next line ERROR: space prohibited before that ':' (ctx:WxE) ERROR: space
 prohibited before that ':' (ctx:WxE) ERROR: trailing statements should be on
 next line ERROR: trailing s tatements should be on next line
In-Reply-To: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
References: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f25017a660f8a3a4e49258a1d96003dc@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++-----
  1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c 
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index d8a4d773a58c..b99e0a7c96bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct 
nvkm_cctx *cctx, struct nvkm_chan
      u64 addr = 0ULL;

      switch (engn->engine->subdev.type) {
-    case NVKM_ENGINE_SW    : return;
-    case NVKM_ENGINE_GR    : ptr0 = 0x0210; break;
-    case NVKM_ENGINE_SEC   : ptr0 = 0x0220; break;
-    case NVKM_ENGINE_MSPDEC: ptr0 = 0x0250; break;
-    case NVKM_ENGINE_MSPPP : ptr0 = 0x0260; break;
-    case NVKM_ENGINE_MSVLD : ptr0 = 0x0270; break;
-    case NVKM_ENGINE_VIC   : ptr0 = 0x0280; break;
-    case NVKM_ENGINE_MSENC : ptr0 = 0x0290; break;
-    case NVKM_ENGINE_NVDEC :
+    case NVKM_ENGINE_SW:
+        return;
+    case NVKM_ENGINE_GR:
+        ptr0 = 0x0210;
+        break;
+    case NVKM_ENGINE_SEC:
+        ptr0 = 0x0220;
+        break;
+    case NVKM_ENGINE_MSPDEC:
+        ptr0 = 0x0250;
+        break;
+    case NVKM_ENGINE_MSPPP:
+        ptr0 = 0x0260;
+        break;
+    case NVKM_ENGINE_MSVLD:
+        ptr0 = 0x0270;
+        break;
+    case NVKM_ENGINE_VIC:
+        ptr0 = 0x0280; break;
+    case NVKM_ENGINE_MSENC:
+        ptr0 = 0x0290;
+        break;
+    case NVKM_ENGINE_NVDEC:
          ptr1 = 0x0270;
          ptr0 = 0x0210;
          break;
@@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct 
nvkm_memory *memory, u32 start,
      int target;

      switch (nvkm_memory_target(memory)) {
-    case NVKM_MEM_TARGET_VRAM: target = 0; break;
-    case NVKM_MEM_TARGET_NCOH: target = 3; break;
+    case NVKM_MEM_TARGET_VRAM:
+        target = 0;
+        break;
+    case NVKM_MEM_TARGET_NCOH:
+        target = 3;
+        break;
      default:
          WARN_ON(1);
          return;
--=_ff68884a3fac4130d787939fa0c53b83
Content-Type: message/rfc822;
 name="=?UTF-8?Q?=5BPATCH=5D_drm/nouveau/fifo=3AFix_Nineteen_occurrences_?=
 =?UTF-8?Q?of_the_gk104=2Ec=5F3=2Eeml?="
Content-Disposition: attachment;
 filename*0*=UTF-8''%5BPATCH%5D%20drm%2Fnouveau%2Ffifo%3AFix%20Nineteen%20;
 filename*1*=occurrences%20of%20the%20gk104.c_3.eml;
 size=2997
Content-Transfer-Encoding: 7bit

MIME-Version: 1.0
Date: Fri, 14 Jul 2023 13:17:10 +0800
From: huzhi001@208suo.com
To: bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the gk104.c
 error: ERROR: space prohibited before that ':' (ctx:WxW) ERROR: : trailing
 statements should be on next line
In-Reply-To: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
References: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <2f4a7303e305d07fdd9c15a9dc95dc5f@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++-----
  1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c 
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index d8a4d773a58c..b99e0a7c96bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct 
nvkm_cctx *cctx, struct nvkm_chan
      u64 addr = 0ULL;

      switch (engn->engine->subdev.type) {
-    case NVKM_ENGINE_SW    : return;
-    case NVKM_ENGINE_GR    : ptr0 = 0x0210; break;
-    case NVKM_ENGINE_SEC   : ptr0 = 0x0220; break;
-    case NVKM_ENGINE_MSPDEC: ptr0 = 0x0250; break;
-    case NVKM_ENGINE_MSPPP : ptr0 = 0x0260; break;
-    case NVKM_ENGINE_MSVLD : ptr0 = 0x0270; break;
-    case NVKM_ENGINE_VIC   : ptr0 = 0x0280; break;
-    case NVKM_ENGINE_MSENC : ptr0 = 0x0290; break;
-    case NVKM_ENGINE_NVDEC :
+    case NVKM_ENGINE_SW:
+        return;
+    case NVKM_ENGINE_GR:
+        ptr0 = 0x0210;
+        break;
+    case NVKM_ENGINE_SEC:
+        ptr0 = 0x0220;
+        break;
+    case NVKM_ENGINE_MSPDEC:
+        ptr0 = 0x0250;
+        break;
+    case NVKM_ENGINE_MSPPP:
+        ptr0 = 0x0260;
+        break;
+    case NVKM_ENGINE_MSVLD:
+        ptr0 = 0x0270;
+        break;
+    case NVKM_ENGINE_VIC:
+        ptr0 = 0x0280; break;
+    case NVKM_ENGINE_MSENC:
+        ptr0 = 0x0290;
+        break;
+    case NVKM_ENGINE_NVDEC:
          ptr1 = 0x0270;
          ptr0 = 0x0210;
          break;
@@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct 
nvkm_memory *memory, u32 start,
      int target;

      switch (nvkm_memory_target(memory)) {
-    case NVKM_MEM_TARGET_VRAM: target = 0; break;
-    case NVKM_MEM_TARGET_NCOH: target = 3; break;
+    case NVKM_MEM_TARGET_VRAM:
+        target = 0;
+        break;
+    case NVKM_MEM_TARGET_NCOH:
+        target = 3;
+        break;
      default:
          WARN_ON(1);
          return;
--=_ff68884a3fac4130d787939fa0c53b83
Content-Type: message/rfc822;
 name="=?UTF-8?Q?=5BPATCH=5D_drm/nouveau/fifo=3AFix_Nineteen_occurrences_?=
 =?UTF-8?Q?of_the_gk104=2Ec=5F4=2Eeml?="
Content-Disposition: attachment;
 filename*0*=UTF-8''%5BPATCH%5D%20drm%2Fnouveau%2Ffifo%3AFix%20Nineteen%20;
 filename*1*=occurrences%20of%20the%20gk104.c_4.eml;
 size=2945
Content-Transfer-Encoding: 7bit

MIME-Version: 1.0
Date: Fri, 14 Jul 2023 13:21:22 +0800
From: huzhi001@208suo.com
To: bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the gk104.c
 error: ERROR: : trailing statements should be on next line
In-Reply-To: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
References: <tencent_0FA6AE16A21AAA2E9481C6FE598BA70CC405@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d0d767fb0dd3a9b7642559f379dbb0d6@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++-----
  1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c 
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index d8a4d773a58c..b99e0a7c96bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct 
nvkm_cctx *cctx, struct nvkm_chan
      u64 addr = 0ULL;

      switch (engn->engine->subdev.type) {
-    case NVKM_ENGINE_SW    : return;
-    case NVKM_ENGINE_GR    : ptr0 = 0x0210; break;
-    case NVKM_ENGINE_SEC   : ptr0 = 0x0220; break;
-    case NVKM_ENGINE_MSPDEC: ptr0 = 0x0250; break;
-    case NVKM_ENGINE_MSPPP : ptr0 = 0x0260; break;
-    case NVKM_ENGINE_MSVLD : ptr0 = 0x0270; break;
-    case NVKM_ENGINE_VIC   : ptr0 = 0x0280; break;
-    case NVKM_ENGINE_MSENC : ptr0 = 0x0290; break;
-    case NVKM_ENGINE_NVDEC :
+    case NVKM_ENGINE_SW:
+        return;
+    case NVKM_ENGINE_GR:
+        ptr0 = 0x0210;
+        break;
+    case NVKM_ENGINE_SEC:
+        ptr0 = 0x0220;
+        break;
+    case NVKM_ENGINE_MSPDEC:
+        ptr0 = 0x0250;
+        break;
+    case NVKM_ENGINE_MSPPP:
+        ptr0 = 0x0260;
+        break;
+    case NVKM_ENGINE_MSVLD:
+        ptr0 = 0x0270;
+        break;
+    case NVKM_ENGINE_VIC:
+        ptr0 = 0x0280; break;
+    case NVKM_ENGINE_MSENC:
+        ptr0 = 0x0290;
+        break;
+    case NVKM_ENGINE_NVDEC:
          ptr1 = 0x0270;
          ptr0 = 0x0210;
          break;
@@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct 
nvkm_memory *memory, u32 start,
      int target;

      switch (nvkm_memory_target(memory)) {
-    case NVKM_MEM_TARGET_VRAM: target = 0; break;
-    case NVKM_MEM_TARGET_NCOH: target = 3; break;
+    case NVKM_MEM_TARGET_VRAM:
+        target = 0;
+        break;
+    case NVKM_MEM_TARGET_NCOH:
+        target = 3;
+        break;
      default:
          WARN_ON(1);
          return;
--=_ff68884a3fac4130d787939fa0c53b83--
