Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B542B7DFDA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjKCBAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348014AbjKCBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBDA1A4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08829C43391;
        Fri,  3 Nov 2023 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698973227;
        bh=a9HOIt3ALfWy2JbzWe2Ug9+amBY2po8B6LGKYQhtZOk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k00hD3qUyxyEywjPi6btWkgapIMIp8F2TeEnkXl6mrhPjLHsqB2IHETw64RtXA52X
         F53R9dPJ/OURy6+OmBu+EQ8RZzDrruJrscmjGXHl+NoduW+xx0huBcDaR/U+MwabJw
         lV/GF/kToENXnUxrX1YSXagRpA9Ms1/R6NTN+2T4rD8G+SgYOTkb6NCp6N+MKqszrU
         07USbxJSnHOQlCV16Aq/+ZiY+k2mHMCKKgdZtIjdZM65EtuyBGqOIM98PRKXvKvzOl
         cflC8FEhpN0avm8FAiuAPULrw9YCykhil1aKOJ6txxca1d2NMSsd5Tic6kuos5hXYd
         qZXT342cZyg2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8D45C43168;
        Fri,  3 Nov 2023 01:00:26 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102143229.GZ8909@google.com>
References: <20231102143229.GZ8909@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102143229.GZ8909@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.7
X-PR-Tracked-Commit-Id: b9604be241587fb29c0f40450e53d0a37dc611b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 431f1051884e38d2a5751e4731d69b2ff289ee56
Message-Id: <169897322694.13409.16519652445839352717.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:00:26 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 14:32:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/431f1051884e38d2a5751e4731d69b2ff289ee56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
