Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE4753029
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjGNDvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGNDvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:51:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884E626B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:51:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Hb16K1WzBRSVs
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:51:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689306685; x=1691898686; bh=QD5wT/8x1E9M8LSp4jRHIAhQCQo
        Pi5hSuSfjtzogOas=; b=ZHw6c8u2/z+5GtVUcOcsaGHJUnoV/oIuU0kGzPRMfWq
        m19IVTXe/KNfcxdYm37cwcyNIqsSEu6AZeat1YB9SzfwC9f65X0+rZD7x/3dGWu2
        vLXpJH+jruz4Ue53UQn8AiN2L+s1zBNie0FgwA+b0dIYzfyisHRYuXcrkNet9ZZK
        g5p+IclJqMxXFuHYnkLyIrnmwl3YYjKVzxhuQwCNUYMjBRSERnkYmPm5HDMew3/5
        jN3c47QUDcIbw8bIArGwMhxsuzQr/WbrY9tLdNbO3pnyNGceNpJNrzzsvV/TLue5
        jZxovYkW4+DbQCub9d5319dwBaiR7Ci4IhyxV+afU5A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B-H4zmc2ubeV for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:51:25 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Hb12z43zBHXhN;
        Fri, 14 Jul 2023 11:51:25 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:51:25 +0800
From:   huzhi001@208suo.com
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
