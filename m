Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D07EAA65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjKNGAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 01:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjKNGA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75907D43
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 22:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B1AC433C8;
        Tue, 14 Nov 2023 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699941624;
        bh=R/8VR60svHhdl4xeNE6ZIwCEE/MiEGrJ2q9pzDRWa2M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qI64EoQypP3GzCKNkExTHQ7lIbxdV8sM+LwRCYFynfezs+ibMXnlCyv8mpRXZa2Pw
         Sg6AfRQsJkuSAv9sBvnK3msIJSviYAi9zdGtrCFXVQo4Jf/w0FsqXWlizuf+hhLdgF
         dnlpc4+JKuy4TJ6cQsQYvBPoYlzFhf+2EtZWxZzu99Ev/hsO3+a+haJWOKpVQ0YfdP
         LChaqZgpvATM632HwCh2OAqwinHOyApnCUhLG7GJHttMUm8HwkBJHA6thiHrX0Rqgy
         Bhfv5fYT8Rld3a02zcWAYUUdWywBI8pSrXhWz67jvbK6IHN0wxSMgLLzFLzLAaxERL
         OB/2Kbzgs8R/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F11C0E1F675;
        Tue, 14 Nov 2023 06:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: sensorhub: Fix typos
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169994162398.30294.7431100273285958893.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Nov 2023 06:00:23 +0000
References: <20231110165239.1559109-1-visitorckw@gmail.com>
In-Reply-To: <20231110165239.1559109-1-visitorckw@gmail.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sat, 11 Nov 2023 00:52:39 +0800 you wrote:
> Replace 'preceeds' with 'precedes' in the comment.
> Replace 'porod' with 'period' in the comment.
> Replace 'noone' with 'no one' in the comment.
> Replace 'lantency' with 'latency' in the comment.
> Replace 'kifo' with 'kfifo' in the comment.
> Replace 'change' with 'chance' in the comment.
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: sensorhub: Fix typos
    https://git.kernel.org/chrome-platform/c/49e380795414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


