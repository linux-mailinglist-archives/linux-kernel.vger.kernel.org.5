Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5207C8D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJMTG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjJMTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:06:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C60A9;
        Fri, 13 Oct 2023 12:06:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CA69C433CA;
        Fri, 13 Oct 2023 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697224012;
        bh=+mVztfYjkKcUzCIHSTNl5JOXLy6H6gVer2tl8V/r+Jg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ACQllJSQQ3es7fQLVjClKIlNtEVIOv2Lhdzc3e+gI2ZyN+lugdkjeDBGT03NLWUQP
         hOf+tN6GL5VnK8ELMefvUY6r+NpQ5uOucElvMH2VxqDVoyH4Ua8RJGSdcARxAwpnzD
         3uLTo/Ba+DjhfzJiPQ77Zqb00c/U/6LIS/waCHHNOs/Xlpo6TuafLz0akAr3mr4l+/
         xRmrOTHws59HyVhzV3OQRn/4ynzJBoP8e2NQze8J3Q846JZYbkJQI8ZyNDAmaQJ08h
         sjPaTtMtYa1hcfOZF9164GxSAfx1GIM+Kt9jcK+MytsorHjwI/ZHk4RVTeEP0HjU2L
         BMXs5Dd60s7HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 554C1E1F669;
        Fri, 13 Oct 2023 19:06:52 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <81d665ccd17999d96d698c0d897e11c992a4de21.camel@HansenPartnership.com>
References: <81d665ccd17999d96d698c0d897e11c992a4de21.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <81d665ccd17999d96d698c0d897e11c992a4de21.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: a20c4350c6a12405b7f732b3ee6801ffe2cc45ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cb1f10d8c4b716c88b87ae4402a3305d96e5db2
Message-Id: <169722401234.18973.12021057288491044214.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 19:06:52 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 14:46:58 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cb1f10d8c4b716c88b87ae4402a3305d96e5db2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
