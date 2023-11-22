Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFA7F5074
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjKVTRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjKVTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:17:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D3093
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:17:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D53C433CD;
        Wed, 22 Nov 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700680624;
        bh=eu1niTZ9Us0JvNhA7epPBjffJ3MpouSoCCq6jD5odqM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cnwAdXViIEG6jkrRoeLzgTHZBmEJWabwoSsB6Kw5UKsd5Qb8d4AdvTZ/EuI3rCEhX
         LK4R1KJW8OldD9a79HItnzDSVeY/DSaA+4w2NzV5NGwYjBhrECfmMLZjuaDgKgawhA
         RB7w+8a01v/Hr39XRD7xYIK9ZyqDdOZG7GJJ2XyB3XEI8Eqvn3aQkFAIpPXx+qEyE6
         PS1PEmBkYBLYAODcqMzW1LB0ccmqTWxtmb783EeW0l8FAM9Yu3DeZlNypLQZ7wba6o
         iDsAq2w2Ean8xwz+DI5z0BsO06HTQ7ApqsNMzfSROzfV/6VUAqcFASKSxlnBbkzKa4
         LOmaIE2yE6s9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1571BEAA958;
        Wed, 22 Nov 2023 19:17:04 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
References: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231121
X-PR-Tracked-Commit-Id: 18286883e779fb79b413a7462968ee3f6768f19c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05c8c94ed407499279b2a552e7ee9bb03e859b7b
Message-Id: <170068062408.6718.13004684063632403217.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Nov 2023 19:17:04 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Nov 2023 05:12:30 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05c8c94ed407499279b2a552e7ee9bb03e859b7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
