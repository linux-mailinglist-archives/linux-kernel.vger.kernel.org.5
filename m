Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A37E6003
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjKHVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjKHVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:34:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D8A1FCE;
        Wed,  8 Nov 2023 13:34:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EC12C433C7;
        Wed,  8 Nov 2023 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699479265;
        bh=gLxSowCsfCRzMHFEn1leBol01qkTRz7p9BJBOhTwo34=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TswYzn34SR5HVKR1FkGsf2MDp5rUMTWplRaV02YCarNi7PPmpw8xqaUolCdq+EXjL
         QG+e7CZGu7nauDfHOzkk3UvnX0yEBWqeQA3txWySANhWiRImV0iGl4zfk8JQjRKYeW
         SBpi7W+1HLSAzJBfYjsi0L8Tm9Cwfcd3yAUD+7mzbKg8K9sMhfq0p3SsSdks+Z8zmU
         +F1dKJU/ulwxM4UQepnas3D+QqSlJmw3USDGSgl+pGhi0ZIARvjBGs8xSeoDKUZDcZ
         dFkFwALK9RmaOSaqNnhEJV01XX9HCwh5ZuGZdRa5x7TGJ2iVouk0J/iD5t85h4QbWs
         LuSdlXPiLGdiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D8ABE00081;
        Wed,  8 Nov 2023 21:34:25 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.7 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01699475581-ext-3562@work.hours>
References: <your-ad-here.call-01699475581-ext-3562@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01699475581-ext-3562@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-2
X-PR-Tracked-Commit-Id: 02e790ee3077c0571794d0ab8f71413edbe129cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1995a536702921f000acda2bed645f1fe0e7ee5b
Message-Id: <169947926537.28494.9947968642163792352.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 21:34:25 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Nov 2023 21:33:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1995a536702921f000acda2bed645f1fe0e7ee5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
