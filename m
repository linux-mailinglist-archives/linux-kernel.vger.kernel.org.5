Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5975EE03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGXIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGXImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:42:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB4184
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:42:10 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8YYq4m9zzBRx5B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:42:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690188127; x=1692780128; bh=eE7sNKxG4/rjsPDu9gJ/H3YFqzO
        mN4jtb9Ah4UwXSdc=; b=kxCrOKJ/X6KDq2G5oEObom94SRx7CYjqrqZRkIa/JSN
        w+gWM1YSu4rSANtBoTB5Hl9EqTUk5OIpxorjDfwo6t6qp9EcW+m8j6Tt+/zRvl1B
        k+lkwemajkgxmRlEdM6blOU9BNJsoOPPphNAasDoLyQWFfkpYETFmiaShf2TzYWC
        tEaEOg5skrZsLBL382oYRUlX8nUywcH/go7lkJDlrQ4ncAPLfhUQC62Aweupystc
        OH+KPGzVGT8FEg+gg7j+cmX7mnZTfATZlHH3tbLXX3ugy1qWlEUev5s1+X2aiQuF
        saP9nS8DZCwkzazLOJhvaWPLRiHsZDRtIhbRMWmM2BQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xEgVwIkS3k13 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 16:42:07 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8YYq2NgkzB7Bvn;
        Mon, 24 Jul 2023 16:42:07 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 16:42:07 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: that open brace { should be on the previous line
In-Reply-To: <20230724084109.9496-1-xujianghui@cdjrlc.com>
References: <20230724084109.9496-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7fde0c4213bf401813918ac05f313fbb@208suo.com>
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
  drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h 
b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
index beab6d7b28b7..630132c4a76b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
@@ -52,8 +52,7 @@ static unsigned int DbiPrbs7[] =


  //4096 bytes, 256 byte aligned
-static unsigned int NoDbiPrbs7[] =
-{
+static unsigned int NoDbiPrbs7[] = {
      0x0f0f0f0f, 0x0f0f0f0f, 0x0f0f0f0f, 0xf0f00f0f, 0x0f0f0f0f, 
0x0f0f0f0f, 0xf0f0f0f0, 0x0f0f0f0f, 0x0f0f0f0f, 0xf0f00f0f, 0xf0f00f0f, 
0x0f0f0f0f, 0xf0f0f0f0, 0xf0f0f0f0, 0x0f0f0f0f, 0xf0f00f0f,
      0x0f0f0f0f, 0xf0f00f0f, 0xf0f0f0f0, 0x0f0f0f0f, 0xf0f0f0f0, 
0xf0f00f0f, 0xf0f00f0f, 0xf0f00f0f, 0x0f0ff0f0, 0xf0f0f0f0, 0xf0f0f0f0, 
0x0f0ff0f0, 0x0f0f0f0f, 0x0f0f0f0f, 0xf0f0f0f0, 0xf0f00f0f,
      0x0f0f0f0f, 0xf0f00f0f, 0x0f0ff0f0, 0x0f0f0f0f, 0xf0f0f0f0, 
0x0f0ff0f0, 0xf0f00f0f, 0xf0f00f0f, 0xf0f0f0f0, 0x0f0ff0f0, 0xf0f0f0f0, 
0xf0f00f0f, 0xf0f0f0f0, 0x0f0f0f0f, 0x0f0ff0f0, 0xf0f00f0f,
@@ -121,8 +120,7 @@ static unsigned int NoDbiPrbs7[] =
  };

  // 4096 bytes, 256 byte aligned
-static unsigned int DbiPrbs7[] =
-{
+static unsigned int DbiPrbs7[] = {
      0xffffffff, 0xffffffff, 0xffffffff, 0x0000ffff, 0xffffffff, 
0xffffffff, 0x00000000, 0xffffffff, 0xffffffff, 0x0000ffff, 0x0000ffff, 
0xffffffff, 0x00000000, 0x00000000, 0xffffffff, 0x0000ffff,
      0xffffffff, 0x0000ffff, 0x00000000, 0xffffffff, 0x00000000, 
0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffff0000, 0x00000000, 0x00000000, 
0xffff0000, 0xffffffff, 0xffffffff, 0x00000000, 0x0000ffff,
      0xffffffff, 0x0000ffff, 0xffff0000, 0xffffffff, 0x00000000, 
0xffff0000, 0x0000ffff, 0x0000ffff, 0x00000000, 0xffff0000, 0x00000000, 
0x0000ffff, 0x00000000, 0xffffffff, 0xffff0000, 0x0000ffff,
