Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD67C8B98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjJMQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJMQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999BB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EC5AC433C9;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215196;
        bh=6deSOnE3AFYdaQBzhcFMJ8RWSZLE1MBlyHOVZbLAeYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PJwPGqmCblcQpZhrj4OQEbWacC5dRyKbmdyBKg8qjLVVMYc57OniHFNrfxeFkUALW
         cvcJAb3ZvJxIcrjNZ6p+mWBSq4eZReeIcz+VigrfT6CpigD8dF1vSI16RRRaX2yR2F
         6Lgz7D5lVXXZHRYEW8CiOH5t6k8Vdoqm/ouHzS7PxVbVZ3bzIDJZg+OkglnrFKRqdD
         W6dvdddKDeAPFdmP9GhLwRTnQsX8vmrV2QAu2X6awk4B3YvvLMTrZ5938Zzfi0UX3c
         FV3UjNE9BQhWaFepSFcKtMqOOqBg3/XsRZWu4ws2se/RTJgudqM55sv+UbW5ZxfBwH
         GiuENHifsMG1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E50B8C73FEA;
        Fri, 13 Oct 2023 16:39:55 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSlKUui11Cvq4Y/0@matsya>
References: <ZSlKUui11Cvq4Y/0@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSlKUui11Cvq4Y/0@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.6
X-PR-Tracked-Commit-Id: 3fa53518ad419bfacceae046a9d8027e4c4c5290
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3439b2a87edcdb86557b5e64787372c6f280dcba
Message-Id: <169721519593.5219.1426124554977063497.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 16:39:55 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 19:16:58 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3439b2a87edcdb86557b5e64787372c6f280dcba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
