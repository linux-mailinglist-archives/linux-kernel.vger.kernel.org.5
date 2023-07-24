Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B05C75E9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGXDMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGXDMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:12:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D5137
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:12:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8QFY2VkHzBRYmR
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:12:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690168353; x=1692760354; bh=PeoMidOEMI3JSDJGBb091hI84X2
        Ct+kfKaZVoMaGZhA=; b=CH6gqrxpc/TianuFvYJ/o1QZcC1yio3PdkYEPj8TxoD
        enMsngN2X+B51XOUJWsQGAeOMmlauz4TL5j1aY1MmYQ5j4dIsQ6REDsGO5gFswvM
        RgRCdIQPAGgjxIvOppWpYJ62TicwJFftx+9P03XlzXbY8YJGIu4AoMlNWSFO/a4z
        c0x6EtYKxSKVMoAHSQG3x0WX0XuNAZ8SmtLbpLh39sRN6QxKEu0j6F1vXCSp1WCv
        XVpiiIf2A8Mm1HgVRlHN8j3xLXkKhDDlvso57Dr7Im3ScR16JNjTayokQGezd8zg
        MqnaO4xCtVUWaMJfD4BFS/3f1dpBVD8Hk/kMi9qVj+Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3G0c3uKDwqaj for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 11:12:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8QFX6RcdzBRDrF;
        Mon, 24 Jul 2023 11:12:32 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 11:12:32 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: that open brace { should be on the previous line
In-Reply-To: <20230724031126.7694-1-xujianghui@cdjrlc.com>
References: <20230724031126.7694-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <3a9a96f2b98642a86bdc33c3149cac97@208suo.com>
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
  drivers/gpu/drm/radeon/ni_dpm.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.c 
b/drivers/gpu/drm/radeon/ni_dpm.c
index a101ba00ea30..1cf4de4cda23 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -625,7 +625,7 @@ static const u32 cayman_mgcg_disable[] =
  };
  #define CAYMAN_MGCG_DISABLE_LENGTH   sizeof(cayman_mgcg_disable) / (3 * 
sizeof(u32))

-static const u32 cayman_mgcg_enable[] = :621 {
+static const u32 cayman_mgcg_enable[] = : 621 {
  	0x0000802c, 0xc0000000, 0xffffffff,
  	0x000008f8, 0x00000000, 0xffffffff,
  	0x000008fc, 0x00000000, 0xffffffff,
