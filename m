Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5E77C1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjHNUvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjHNUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D836DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19272647C9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7157AC433CA;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046222;
        bh=cFZPQo5ttQavTF3LVxiGZwW00ViXQY/i8Ui5n58JYcg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bh99qSODMspbWTo3pZrlR8CCZQ1MsCP/AvTD2FWmz6Rsguwh2sdunDDiZqweod/sl
         jOIqF8MgYgD8wxwZbc0rQwdgjDW2nStBtda4lVEgCFFgyZBdBGQNZXdn/MVBhiFVjr
         7nQTiAh3kyErLb9QVRm0OLOZejm9X5bjaTaU11T76BRFupPW2WMaSJnEJrI4W67RUE
         ppXz0lLTapJ8BwKRGlak5taPFNmWcdemYiMTgGkX+02MxNzjw7DZT4wpHf0i6mJI2k
         27355fza7LpeDFQ2DO3oS2zaUsWmnur+ILo+dHQ3u6+6+uDj83GgGDNeDAwI994y+j
         J/d0OPx41Z06g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55C34E93B32;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: should update REQ_TIME for direct write
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169204622234.5033.2138397345398066048.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 20:50:22 +0000
References: <1691656800-21616-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1691656800-21616-1-git-send-email-zhiguo.niu@unisoc.com>
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, niuzhiguo84@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Aug 2023 16:40:00 +0800 you wrote:
> The sending interval of discard and GC should also
> consider direct write requests; filesystem is not
> idle if there is direct write.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: should update REQ_TIME for direct write
    https://git.kernel.org/jaegeuk/f2fs/c/0cc81b1ad512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


