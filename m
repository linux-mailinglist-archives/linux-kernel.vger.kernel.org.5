Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62717E863F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbjKJXJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjKJXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:09:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A19118
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:09:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F5E9C433C8;
        Fri, 10 Nov 2023 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699657756;
        bh=/4P4FJ6MXqpWoFg0yfpPFpg+1ZM7nVTX6GEau6tdJSg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tuk/5UTMMAFnax+S/mTmb4AxoCzN6lzrcYzum3AAiTnaSa+uJZnMwZT4cue8bM3N6
         fuhxN8a71XkF/yOU7uXtZ/7O/5ELClq1ne0T7wrKWeAPaL/0gCV5OUxveC5kSrQYvv
         bZkhzvtA3oevbR5Vlc8oDKI2MCdi/b9Dpvd13ljI0WLh3HQrlKny8mYck6TcGL+dN4
         HQT2xSCOY12MZJHBrC3g1QxYO50p+ZwCg0gU2k+qZPMv5KyQl9+F5zF3aN0BG23kdW
         7jTUusvzGxjm0vTo+kqynxmiruTh4I2Mmz/kl0rPzazpxShTmcx2iedCjFda0shdSw
         aqiHpTz6IBi6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F407EAB08C;
        Fri, 10 Nov 2023 23:09:16 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZU6tdJPgt4tin/TU@ls3530>
References: <ZU6tdJPgt4tin/TU@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZU6tdJPgt4tin/TU@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.7-rc1
X-PR-Tracked-Commit-Id: a5035c81847430dfa3482807b07325f29e9e8c09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18553507f60f4f51f071644621a58836eb59e28c
Message-Id: <169965775605.1420.2530104698439511436.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 23:09:16 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 23:23:48 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18553507f60f4f51f071644621a58836eb59e28c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
