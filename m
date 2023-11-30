Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186167FF961
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjK3Saf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:30:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66110E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D654BC433CB;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369028;
        bh=N3FJPdmu6JG4s+PR7gx03k6+pt8NSSPRT5nSnkmdAAc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UsI5fo1/ZNqUHbaVx4GgHZg6G2codDXYvR8docPWiZXFYD2Y/IGHKhDdwmQgmLQeR
         AMa6Zu6ChfAbZPN7k8LBLcnjv3vCHT9edceMyiDFbiEM+08EVW/ZrbDfjOL5t4u7qF
         zqwmyPqCpUSKdHr6QNltqFFfXHNAgN9LQv/vFrifqb24c3RUNuK2kCtUOz5tCltEQd
         v3T1or3ixKGtrnk8Eopp6dhaLdzqBwhdLDZV32yWpvdcJOHkN8M/fpdhsYmemuVpgt
         PcYJOQchApHJdxflK+u4iAM6tS3x1vrccQPMIAe/IgZRa6Ma+7jwPUkkHQq6JMhkqe
         +7sHlSktHQ6Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5C4BE00090;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: sysfs: support discard_io_aware
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <170136902874.21709.1570439758273381080.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 18:30:28 +0000
References: <20231122144715.518256-1-chao@kernel.org>
In-Reply-To: <20231122144715.518256-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, 22 Nov 2023 22:47:15 +0800 you wrote:
> It gives a way to enable/disable IO aware feature for background
> discard, so that we can tune background discard more precisely
> based on undiscard condition. e.g. force to disable IO aware if
> there are large number of discard extents, and discard IO may
> always be interrupted by frequent common IO.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: sysfs: support discard_io_aware
    https://git.kernel.org/jaegeuk/f2fs/c/d346fa09abff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


