Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4003E781A69
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjHSQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjHSQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 12:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE622A1C;
        Sat, 19 Aug 2023 09:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7AC61C4A;
        Sat, 19 Aug 2023 16:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AEACC433C7;
        Sat, 19 Aug 2023 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692460908;
        bh=7n1CC74HKqRSxoIXlvbbxvblK1V2CUJ1qbAXF+3uiu0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U2FYUJdukI1452thIbV2EQUFdp+3uvjJ2X9rLc3blPCs4DsQcq+eDLhrzD8EOEo+U
         6sGKUOhGBNFw/WIocMkpOFUblwEyJC3z4ZZLoll6rw0Lx2ic4EvgbTCnW20iZUZaAF
         rztVAKshRKqB9MORQ6hNOrkBdThPxngb8VjB8S/fKRkz1wcuBvYS5w+gTJp+HbEG8Q
         MJE3cEXkfP0Xj9+rycSclMr9FzsSiPQ6W3FZPVLTRWzapSCye3RpB6vbzohbLjhpO0
         AEvLB491oBzBE/YPj7AfWXn3ivjFXEIPPJPXUaK5vCHFM5TrPfWHMXwkesqefzTY/b
         3vYGXBO+kcgSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66F78C395DC;
        Sat, 19 Aug 2023 16:01:48 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZODfqGYs/M1xvIJ8@ls3530>
References: <ZODfqGYs/M1xvIJ8@ls3530>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZODfqGYs/M1xvIJ8@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.5-rc7
X-PR-Tracked-Commit-Id: 0650d5098f8b6b232cd5ea0e15437fc38f7d63ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5cab28be6ccf08237078b675fc1d446679779ba
Message-Id: <169246090841.15016.6846906717154418207.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Aug 2023 16:01:48 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Aug 2023 17:28:40 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5cab28be6ccf08237078b675fc1d446679779ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
