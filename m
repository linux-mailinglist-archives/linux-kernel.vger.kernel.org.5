Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C27FF960
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbjK3Sac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjK3SaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:30:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18A10E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA4F4C43395;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369029;
        bh=7EwKEblPzCXv6jUK/RHT67PlnQI6fT/hklcZDkI84Qw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sPNkfQtGYm8ixzOJiq4KIQEnN1ywTZYSHEGg5ygm6lRcCqmG2vUkGLGQzJvS6qY3I
         zbVZi5N/BQh5nDleB671Y8MqlkGSWoCNwNIsL5pap2UIVgzwfnm90BiJybOiZSdrzt
         fbMOBG9DvKYNCjuXapnZL2NLaHMMum4YRA2hP6RkHrYMXBKmlfPUrt4xbMyA98J0o5
         CLNy97nw1R8e6Y1NKsyAGGYLMG1THxPi7WrxpxHkGqN6+jGh0S7mTcNBn2o4lUXQ58
         y9pEgCIzM2VsuwAMujAzRj0IG4udlsfgY7nHHxWAvdk7ga2SbZ70BzRp5LH7L31WEl
         a0gPHPYrk6fdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBD64C691E1;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <170136902876.21709.2888041762449260245.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 18:30:28 +0000
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
In-Reply-To: <20231114212414.3498074-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 14 Nov 2023 13:24:14 -0800 you wrote:
> When recovering zoned UFS, sometimes we add the same zone to discard multiple
> times. Simple workaround is to bypass adding it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: skip adding a discard command if exists
    https://git.kernel.org/jaegeuk/f2fs/c/bbd3efed3383

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


