Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04D37E84E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjKJVAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKJVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:00:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68759D3;
        Fri, 10 Nov 2023 13:00:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFBA2C433C7;
        Fri, 10 Nov 2023 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699650018;
        bh=wvCSztlYiDjdaJ7JsHORNsg/f6bxUjZEEI05yjatVK4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KtlBnQhOO2xk0gpqeTv9b6AIXyW6BzIAxWf5mRNrfNNwDLcZDCb5FtgYE+xcVsSeN
         RRZ8DWRk8NC+rWv6ubtgtsoRfFN8nVXURFyuBcZEQQEQDjh53CB2hXIbLNkfqt+fSl
         yAl+WrFOrxkThCqInWBJNdSxxQzDM3LZ+yXLToX7tDHfu9RnWmCDdl1T18Ci89l8pz
         PSdC9jySgKLbVYVVF+1HQUrtxiNOs7BSCu2QtA1KrJFNf0rNG/fm2Oc1kDdsdmwNp+
         5ljDraS0ROEd1hL/+FTHupS0M2lm3zDXDIeKIBGKL2GphUsU6n5CpuF6yArdgYBseb
         vhOVyTjnXjMbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3C0BEAB08C;
        Fri, 10 Nov 2023 21:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Fixes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231110095013.655597-1-thierry.reding@gmail.com>
References: <20231110095013.655597-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231110095013.655597-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1-fixes
X-PR-Tracked-Commit-Id: d27abbfd4888d79dd24baf50e774631046ac4732
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b077b7ee9268bb4a34e22a503a2e6315ae8f97a7
Message-Id: <169965001780.30005.9874938510989864671.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 21:00:17 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 10:50:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b077b7ee9268bb4a34e22a503a2e6315ae8f97a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
