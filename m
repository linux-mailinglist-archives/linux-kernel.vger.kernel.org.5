Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF07DFDAB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376728AbjKCBAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348011AbjKCBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE01A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAAC9C433C7;
        Fri,  3 Nov 2023 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698973226;
        bh=eaIddpQgBnKcKnj/N1Urdhdo1QmBXF+gSqJkb9RdSbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cYUe0eeiCH/kzK7z2BE9FLxn5jXy4QIdYXeqe7GhywAamnSlr/O0krI1yma4M1T2Y
         j1jwU8yaii4aPJzHCTfw5Qca+CiTCMcHyRI8OjTZFefACNH1WoB60zGmh0ygF9nUJa
         ku2Px6iOtJf2VB52vp9iSByfYai4brderJW6CArXNOMxc80zpvWlOyGyk6deH3pKOx
         wpeLoinjf765ZLrtaX5HshogROFai7Bwk5JDawTNDa/MOE09Hlay/PAj6KsgeQK0e5
         vOZqZVDGnUpbushBkbDCCKbxupi8yPMJDcBByxdoA/FwleiWb/zdAP/whxe47p6+8F
         watxY7aAOVhxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4F03C43168;
        Fri,  3 Nov 2023 01:00:26 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102142918.GX8909@google.com>
References: <20231102142918.GX8909@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102142918.GX8909@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.7
X-PR-Tracked-Commit-Id: 2b481822446e30943fb7c02744a7b49ebec0e696
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27bc0782ef8ec26ed94b9fa16c75c11fdb3cd78b
Message-Id: <169897322673.13409.13713156729323053634.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:00:26 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 14:29:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27bc0782ef8ec26ed94b9fa16c75c11fdb3cd78b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
