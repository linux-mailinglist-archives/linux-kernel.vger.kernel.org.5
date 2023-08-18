Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA378059F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358028AbjHRFY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357782AbjHRFW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6B4EF2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2090667529
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D14C433C8;
        Fri, 18 Aug 2023 05:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692335895;
        bh=QdLqdIjISuh8OpzVyyaN3TMdoeWkEO26hO5xJu8AK1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NHD0ybKzCBDIXsTHCiOujm3GI3XMpKP5JtJbugpPX0dY+g9lX36ed8TZYODxShPUN
         pU/QtklVEkYT1HgnDtNv1P9JZbNfN52PdTi9hnrJA16nfox0eu15drpqKqGPyhblzF
         bLDoUkCLb5LA9qXhuosjCQ+XrYyuKMwDWjbGvSDxvdcpveKoPC9AjaP1XnZiHIflT9
         KgGQlg+sxf5Kt7tRUtmLiZCQpuPz1ZofLXMWnllsBHncFfn8+p5hsRjhHF0FVRjNVB
         zcLEsY6Ddo8EAeLisVQ7uAb3Nf6Zt/Qq7fzvNjl1HO3FgRxbUA1JMdvUR2WQvbl5O3
         tkX8UHcAwLqoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EFC5E93B34;
        Fri, 18 Aug 2023 05:18:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230817221129.1014945-1-kuba@kernel.org>
References: <20230817221129.1014945-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230817221129.1014945-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc7
X-PR-Tracked-Commit-Id: 820a38d8f2cb3a749ffb7bbde206acec9a387411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e8860d2125f51ba9bca67a520d826cb8f66cf42
Message-Id: <169233589544.13368.883924351693507238.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 05:18:15 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Aug 2023 15:11:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e8860d2125f51ba9bca67a520d826cb8f66cf42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
