Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C887A9B88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjIUTCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjIUTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435C7F353
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:35:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19F8BC58334;
        Thu, 21 Sep 2023 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695312676;
        bh=XoQC5a8R1Q8moEJNIwOPcjCrZdHjYGxBIi7nRjw3tSw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1B2ul8koR/LDeohQNtxJv0EmOJoBh/1Z3W8jV+8NVlbyOTXqckWYG0/qOtaUUAQp
         ZE4s/wcr8ab8aCN7lqiB/nZLryB5aaIohbE31B2X41b6Re0KK/AYn6tEgnsLPnoiVH
         xpYqX3m8aM8A2z/v52p9YdiEdtGRhgUraBh9PeegvN9hw4gbLoAPczC59KPGLdf3C6
         IRz6kD+RTFQqN6in2SVW4LXPnzLWz2QtyLEXPoUxp7rTEDg9q6c616cSrH7dfwAf30
         oYmY1YT/lejqA4w685+SaV4wMLn9qlA+GawCRn7iwnYA0qYjrmY9kQxtZFgpYIez5+
         w5hev5H+ZD+bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07265C04DD9;
        Thu, 21 Sep 2023 16:11:16 +0000 (UTC)
Subject: Re: [GIT PULL] memblock test: compilation fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230921055302.GG3303@kernel.org>
References: <20230921055302.GG3303@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230921055302.GG3303@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-09-21
X-PR-Tracked-Commit-Id: 55122e0130e51eb71f5ec62d10525db0468f28e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb8b1b93eed0f5ddb2f9903c2de2d9de8b372e8f
Message-Id: <169531267602.30941.17580587779780093371.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 16:11:16 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rong Tao <rongtao@cestc.cn>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Sep 2023 08:53:02 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-09-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb8b1b93eed0f5ddb2f9903c2de2d9de8b372e8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
