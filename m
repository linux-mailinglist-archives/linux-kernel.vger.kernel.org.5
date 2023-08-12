Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2577A1CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHLSeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHLSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:34:03 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5E910C2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:34:06 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D5030160BE6;
        Sat, 12 Aug 2023 20:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1691865244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e/X3Jp03pfCojLdzJqlMAuYtV41cck+wlhq+414/CjQ=;
        b=KQshq1aG5s6vd3VRPPPirmrRIriAu8hACMtBQN9thn0RX37gRWY0eVCDJMdFkE63k8ICBV
        0noxhLgEk8ANfhdO0MTIJHS5MK3eMlnMJghhPq/npbndQN0GK5pUrEmSWBsZkRcSoU1qxg
        4ds2pQAlHI/h+SjQHfx81sK7MEk19fg=
From:   David Heidelberg <david@ixit.cz>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     David Heidelberg <david@ixit.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: JDI LT070ME05000 drop broken link
Date:   Sat, 12 Aug 2023 20:34:03 +0200
Message-Id: <20230812183404.374718-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link is no longer functional and web.archive.org doesn't provide PDF
with detail information.

Some informations can be found from web.archive.org here:
https://web.archive.org/web/20170629205602/http://panelone.net/en/7-0-inch/JDI_LT070ME05000_7.0_inch-datasheet

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 213008499caa..f9a69f347068 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -5,10 +5,6 @@
  *
  * Copyright (C) 2016 Linaro Ltd
  * Author: Sumit Semwal <sumit.semwal@linaro.org>
- *
- * From internet archives, the panel for Nexus 7 2nd Gen, 2013 model is a
- * JDI model LT070ME05000, and its data sheet is at:
- * http://panelone.net/en/7-0-inch/JDI_LT070ME05000_7.0_inch-datasheet
  */
 
 #include <linux/backlight.h>
-- 
2.40.1

