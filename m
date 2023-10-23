Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8FD7D3AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjJWPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92010D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AEF3C433C9;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=fky56o6OGMffUlnNTnMeI5GtbOUQM5DLVFGgZZmx03Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Jc6QPJo75xtph1CujVnPQqnI3CLhVnBru/a8uHyKGDs2fjbhtrd5x6OQ0oOUMGjLl
         4oHtqftbPmkFD9XtcMwNPWaF00FIa2qw5p0M+0TpDOrl81JdQR2rtVdfCOxQzE4J/I
         vWdN0RveX8K8GeMFkovi/8bqWtOHhzi+sHjbehq1nSkvFiMBwrBWp92OYsdsQj//FR
         lWnLgoPbKElVUOUZXy8PVGibQHkWoIZWhTA3FmbWPuWhcRlgC6cEIe0DMLtd/43LDY
         V+9zQlfNZNoJWS5ZjicFtD9R0VBojqqsgJTjvns39DJJ9zhe/O6t0qORJSmyOfAGG8
         GqkrNRWajupMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05A90C2BBF6;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up zones when not successfully
 unmounted
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502501.26537.6061670597610762355.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <20231010193628.2629168-1-daeho43@gmail.com>
In-Reply-To: <20231010193628.2629168-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 10 Oct 2023 12:36:28 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We can't trust write pointers when the previous mount was not
> successfully unmounted.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up zones when not successfully unmounted
    https://git.kernel.org/jaegeuk/f2fs/c/9f792ab8e33d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


