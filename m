Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628C975EA19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGXDhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXDhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:37:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1546E40
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:37:03 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Qnm1jBszBRYmR
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:37:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690169820; x=1692761821; bh=QtbczKRz0FUK6RRntB/EC/QnHLq
        xHBVDRWfCYscwKwc=; b=QSrSlD/UrOyUZ98Zz3buV6E6NJS6T8V5a1mI8VW1XuH
        bHDBtucvsT1SE+VM4LHgv3eYpWAZgbsRuTN6h1D5W6yvdiJKtwyyOUZpKBOmA/SG
        Mu2qPE5u6uBXhOwanCOsdmskVqOssUY7Bvefr46h8B1xQhYA8LtwjN+fBLgcdBOZ
        zwc3RILbFOpAJun4DBuLqK6dajqMbq41yoMCg1Xy2lJSWbyhyadcoLtxp2M6n0PI
        TaLaPSlYchaUK4P433jY9bpMUhoP1QIySz36Knr4AGQMivV3LNhj/YG2kMw7O4n1
        vafZjI/DHgoGJ02X78lvRU/pCLz0amUZv8N2FbMy2ng==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H8_mOp61xwON for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 11:37:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Qnl6T7QzBJTF7;
        Mon, 24 Jul 2023 11:36:59 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 11:36:59 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: that open brace { should be on the previous line
In-Reply-To: <20230724033555.8039-1-xujianghui@cdjrlc.com>
References: <20230724033555.8039-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e30b4bea0907fe4f94459e0afd5c24a9@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/clearstate_si.h | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/clearstate_si.h 
b/drivers/gpu/drm/radeon/clearstate_si.h
index 356219c6c7f2..7da8418704fe 100644
--- a/drivers/gpu/drm/radeon/clearstate_si.h
+++ b/drivers/gpu/drm/radeon/clearstate_si.h
@@ -23,8 +23,7 @@

  #include "clearstate_defs.h"

-static const u32 si_SECT_CONTEXT_def_1[] =
-{
+static const u32 si_SECT_CONTEXT_def_1[] = {
      0x00000000, // DB_RENDER_CONTROL
      0x00000000, // DB_COUNT_CONTROL
      0x00000000, // DB_DEPTH_VIEW
