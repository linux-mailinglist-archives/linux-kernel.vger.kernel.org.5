Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AEF7516A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjGMDPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGMDPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:15:48 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AF1FCD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:15:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1frG0BpCzBHXgq
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:15:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689218141; x=1691810142; bh=oUifFL4hNuO5wK51PoZK5M+Wdsf
        yqn2Rag+DxPBT7d0=; b=dHggqHFy0UcQDdrPnIo+e/VeYgHPXoPu8g7IBjD746Z
        PCdqTveD2lJxCVUHyplotqNtceKvnMgW5alY1qq02GnR75HjOVAbdfROPq+pSgD+
        92//mvsPx69yyHGXtjYSqCzMUicsXPftHM+su6ouYIZDEYHZERs/NcTytxOJWNlN
        C+FyDlYTdjIpxnf9EywZgaVrB/mi3O8bLxCWDaJ44w6rrY7bBcQppOMADDiPf0ru
        gUxOZRakCVlax2twOj4H4+5nX/XOzp7waZ85DBoj5O2BbHeOkHuu3+o0xT+kMV3R
        pXPpKVfZ4Nk8sylCXtQrdhYZDUwIy6Dk+wwZjtnkdTQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ttg3P6OxkSsQ for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 11:15:41 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1frF4nD6zBHXgf;
        Thu, 13 Jul 2023 11:15:41 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 11:15:41 +0800
From:   liubin001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] drm/vmwgfx: "foo* const bar" should be "foo * const
 bar"\ that ope- n brace { should be on the previous line
In-Reply-To: <tencent_4F166AB6DC9C757B0454E3F4875027411F08@qq.com>
References: <tencent_4F166AB6DC9C757B0454E3F4875027411F08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <28a0378f6935b3a670a31c5badf185a3@208suo.com>
X-Sender: liubin001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(1)The standard format for declaring a pointer is to add a space bet-
ween the type name and the * symbol, as well as between the * symbol and 
the variable name.
(2) that open brace { should be on the previous line
Signed-off-by:     Bin Liu <liubin001@208suo.com>
---
  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c 
b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 96504a320c2a..b56936f95d31 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -87,7 +87,7 @@ struct rpc_channel {

  #if IS_ENABLED(CONFIG_DRM_VMWGFX_MKSSTATS)
  /* Kernel mksGuestStats counter names and desciptions; same order as 
enum mksstat_kern_stats_t */
-static const char* const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] 
=
{
         { "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
         { "vmw_cotable_resize", "vmw_cotable_resize" },
};

+static const char * const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] 
= {
      { "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
      { "vmw_cotable_resize", "vmw_cotable_resize" },
  };
