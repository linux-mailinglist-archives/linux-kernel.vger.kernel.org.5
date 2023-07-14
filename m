Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7187530E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGNFIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjGNFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:07:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6E2D5F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:07:55 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2KHC5cc0zBR9sj
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:07:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689311271; x=1691903272; bh=iLOcUk3bzPHlWtwxwuDqm4mV/on
        mtIq3hNktSDaOMh0=; b=dayk1z4nMV1fZbuidXhMI6B2QFfwaNUxjs6ELTjkeqW
        q/1uz9XY+klGvH68wDkTyfO5nzdQ8KG0m4u8aflOzh2IUb04h9/YGnZ92qWj9BOQ
        +DOgBw1GiE4R2UvijLnRUWzlIlYXOOzoQV9gEmfi66bi991CQwn8CicSG8dImCu0
        69WwSSMTUTNS7n9RkrqMAgNy8EEmvwuZiHf75p9y8IHyjXFKmKKdmsi2FhZDHg/D
        GDCh+GKbpZITWFLddjBrmHbGhXbs50AtGAwqqAFbGiLIv7RVMTu7cb9yuhdC9bnv
        7DkbK88GIaW8RPqKpBTMqHdVI/bclfwcNrEljKG5KrQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SBe3wUlta6lO for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 13:07:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2KHC1hs4zBR7bB;
        Fri, 14 Jul 2023 13:07:51 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 13:07:51 +0800
From:   shijie001@208suo.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: space prohibited before that ',' (ctx:WxV)
In-Reply-To: <tencent_E1D8F653B67C8E7FFC6D0E16C4A59D916306@qq.com>
References: <tencent_E1D8F653B67C8E7FFC6D0E16C4A59D916306@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <501c1939cf8047584b11c1af2022518a@208suo.com>
X-Sender: shijie001@208suo.com
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

Fix two occurrences of the checkpatch.pl error:
ERROR: space prohibited before that ',' (ctx:WxV)
ERROR: space required after that ',' (ctx:WxV)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/atom-bits.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/atom-bits.h 
b/drivers/gpu/drm/radeon/atom-bits.h
index e8fae5c77514..2bfd6d0ff050 100644
--- a/drivers/gpu/drm/radeon/atom-bits.h
+++ b/drivers/gpu/drm/radeon/atom-bits.h
@@ -33,7 +33,7 @@ static inline uint8_t get_u8(void *bios, int ptr)
  #define CU8(ptr) get_u8(ctx->bios, (ptr))
  static inline uint16_t get_u16(void *bios, int ptr)
  {
-    return get_u8(bios ,ptr)|(((uint16_t)get_u8(bios, ptr+1))<<8);
+    return get_u8(bios, ptr)|(((uint16_t)get_u8(bios, ptr+1))<<8);
  }
  #define U16(ptr) get_u16(ctx->ctx->bios, (ptr))
  #define CU16(ptr) get_u16(ctx->bios, (ptr))
