Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131958092B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443910AbjLGUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjLGUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7AA198D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:46:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFC8EC433C7;
        Thu,  7 Dec 2023 20:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982014;
        bh=NwNkY7Lupu4KcZz4m8HPPe5ArDTwKZ+txhqyvO9E6GE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UhBQ/9DpspEHJZqhRTXWizm64gQwdF7qtbu/0nGC0JNrijNqQvw4XbJsqI0jhC35G
         HrkRpWqr/sP0wN07yX2P19D6FLof3A3jpGisojN72BuswIc6DD/b5tkpOu6kfaxd3b
         7SO7sP5XaQuX/JdA/4y+woZAq62r4KB0IGYXfKSH4xwKhnYfjMW9UgiYHCeAaZbAKn
         To5Ey2ARrtinZPc3pw0Zq1xswq0+Z835wcrudI/ED7082B2xDOwTo6OgIHtveheXSw
         JDE/VIo5tf0JIrpRueXtSHJ250Ulbv4NQGkg6Jq8UlBokZbe4lsIvSrO7BsJXrqCSM
         HyUHfdsAM5pbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADFDAC4314C;
        Thu,  7 Dec 2023 20:46:54 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fix for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXCRkjpftWJwIbpk@p100>
References: <ZXCRkjpftWJwIbpk@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXCRkjpftWJwIbpk@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc5
X-PR-Tracked-Commit-Id: 487635756198cad563feb47539c6a37ea57f1dae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55b224d90d44d794c1afab046c4fd9dc8be9247d
Message-Id: <170198201470.1554.10463763662820932160.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Dec 2023 20:46:54 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Dec 2023 16:21:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55b224d90d44d794c1afab046c4fd9dc8be9247d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
