Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFF756AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGQRed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGQReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50276C7;
        Mon, 17 Jul 2023 10:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A69066119B;
        Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12E76C4339A;
        Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615262;
        bh=4ZvqU758s2JKaNXLRepPna0T6aOCUUXfAyBfPR8X2VY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XSQ4EZW3ipVSumHvPXWYtnkSlLMtIQsp55O6t0OWefIpLJU6mOQ33fykGZQSD+XCL
         WQO1rNHu79U+li2ThhL0UJi8n7KqE1NWixR5Lh9c2H6nYxiqTV2gI487LSAJuWObKy
         nrt9PO+ZGljxzeatGDTeLOX7UawhMbDJsyxXJqEplq8dEY9KTGA3K3HyKSCwkvc2kL
         cQRPGESCBHkyUv78DVU2WGtRP/jnJ56uwk3fZ8Ef9QkDA0RjuVjpAWMJn+dd7nJB1A
         yav6BMCReubq2L3MlZ1vaZ/VA/xS0uGeTuhNI10/xy9x/t+etnsHGwZbkGVHwlw2ZV
         2meSprAdgZ48w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D5FE29F36;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: get out of a repeat loop when getting a
 locked data page
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168961526192.4078.9064603829957550841.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 17:34:21 +0000
References: <20230323213919.1876157-1-jaegeuk@kernel.org>
In-Reply-To: <20230323213919.1876157-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 23 Mar 2023 14:39:19 -0700 you wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216050
> 
> Somehow we're getting a page which has a different mapping.
> Let's avoid the infinite loop.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: get out of a repeat loop when getting a locked data page
    https://git.kernel.org/jaegeuk/f2fs/c/5a47ad28e606

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


