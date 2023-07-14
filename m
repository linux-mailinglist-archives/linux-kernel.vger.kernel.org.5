Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA196752FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjGNDcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGNDcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:32:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E1CD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:32:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2H9F3xvQzBRSVM
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:32:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689305553; x=1691897554; bh=AuYDgHFbLdSKDR3AAWF4AJBZRCt
        ktO5bYp21CycLwUE=; b=McsvLIXk3Bq/oQFGBcT9NxaV4fR5oNcfADN/MOcZkf/
        7jpZKdjDofruNkcpeo92d+oQXZ7Eqh+ne6aO2bHucugCK7iFs22Ht0l/nYXpjq6A
        ZsT2PHkcBSQjDtn/38q1M912cIvvZcAzBHQn7tJcDMPtau0I2ibpnrNlf5qSV5dS
        K6gH7cfK5IKmWSj2Otq3ChNYX8YBUBdhqKQxjgpcgohP1knRP7tXFkwPh7LL4OlA
        CwNOHQf+ENhj4wtDL2ezdM9Gk2qWM155lk/fbAFjkDOfAJHUTLHhLHxvMWGdeYUQ
        QouhNLwLPdouWJD9KyE/FiYmd8JeSm1RAAp06ste8qQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fJUgIz04IL7N for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:32:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2H9D5yklzBHXhS;
        Fri, 14 Jul 2023 11:32:32 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:32:32 +0800
From:   shijie001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: spaces required around that '+=' (ctx:VxV)
In-Reply-To: <tencent_90453D41C9A3FB57DCCA60655D9218D1870A@qq.com>
References: <tencent_90453D41C9A3FB57DCCA60655D9218D1870A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <97d2ba38071e5c650894c01a56a2533a@208suo.com>
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
ERROR: spaces required around that '+=' (ctx:VxV)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/r100.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r100.c 
b/drivers/gpu/drm/radeon/r100.c
index affa9e0309b2..2f0470f927f1 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1327,7 +1327,7 @@ int r100_packet3_load_vbpntr(struct 
radeon_cs_parser *p,
          return -EINVAL;
      }
      track->num_arrays = c;
-    for (i = 0; i < (c - 1); i+=2, idx+=3) {
+    for (i = 0; i < (c - 1); i += 2, idx += 3) {
          r = radeon_cs_packet_next_reloc(p, &reloc, 0);
          if (r) {
              DRM_ERROR("No reloc for packet3 %d\n",
