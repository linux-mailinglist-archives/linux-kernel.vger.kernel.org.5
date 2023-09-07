Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1BD797F17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbjIGXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbjIGXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:10:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C371BD5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:10:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36810C433C7;
        Thu,  7 Sep 2023 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694128244;
        bh=6gWp2LzWin1oNp74f1oWXGDjZIu3aUVYay4jiJw+Pas=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sdy0QlZx9F7DFfWW1TG0Ct7xAzGMBo93ZdTQNLuzkZqRDprHof+ef0n37uhNiLtNW
         7vCm7FvlDvCuJk1C+6DdWGmPHjBQJFsKRlCejJB6ddKaM7T7wkLwus+vvcwyDx0MnL
         JsgNLacFhGRkZdpVcMQYe+Ty0QfigEcZ/etOb/LaRZE8jSm2Ka/6adK4dMmjDWa4IR
         XpFHV1ufxaYfhLLTyuCI71SqTgx+niulbC4Bw5MB7qK8s5LMuKgr1Mtt8uxw9QA5ag
         nv70J1DOIT/IK6cEFebj0cQEnz2+J30rXDl24HgG3Mqr3qlplvVyarD84StNYLaDOI
         M1U2r0FKqil9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25666C4166F;
        Thu,  7 Sep 2023 23:10:44 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230906220710e64b2b71@mail.local>
References: <20230906220710e64b2b71@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230906220710e64b2b71@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.6
X-PR-Tracked-Commit-Id: 6e13d6528be2f7e801af63c8153b87293f25d736
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e59a698b2d89b95471769c901d12392134c56eab
Message-Id: <169412824414.8351.10637565613849854944.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 23:10:44 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Sep 2023 00:07:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e59a698b2d89b95471769c901d12392134c56eab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
