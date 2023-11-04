Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3467E10AD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjKDTBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjKDTBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:01:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD261BC;
        Sat,  4 Nov 2023 12:01:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36B34C433C9;
        Sat,  4 Nov 2023 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699124494;
        bh=jqoqRBrahXgFt8CKrWMUpi3C4qdw4tFMaKV5AHi98ws=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vwi7KEfH0fmfcFtWYEjP9yJCYVW0u1Q76+E4qcA7Hkf8YUg6VgPxZLfPedfQQgc0H
         MSMbUkMy97t0czqLjCKid8b0jeMYP1SWpRafnvwQLk30Q5pukx7cL+iUP3HCXBSRKz
         B1uznOOArnfh4PRbDn/dYA2l+jxqeheYcl+ZE6+DK0Rl9kVrCUn8XtSQWSiAl0n4Iu
         qr3Y712ovdiuSzosTMluNF8wifZvYq7vtNSeKb1FJX64hRbcrnd/qW+BSGtGrcB7tI
         VEys5vxfqaBwFfRMrs43pSmdkSIVo04TJHiPed20MNoQD1eaIq7/3t1Gdr+XFaqCgQ
         5m3JKSJdTMPlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D296EAB08A;
        Sat,  4 Nov 2023 19:01:34 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
References: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1-2
X-PR-Tracked-Commit-Id: 4b27d5c420335dad7aea1aa6e799fe1d05c63b7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3062a9879afbca810d9f1613698963ecfcb35701
Message-Id: <169912449411.2096.15814675613023825068.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 19:01:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 15:45:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3062a9879afbca810d9f1613698963ecfcb35701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
