Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E97E49E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjKGUeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjKGUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:34:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AE10D2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:34:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D32B2C433C8;
        Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699389255;
        bh=0lIW6Nyn0UOgIUeAPiMieJgkmrYbTNwidBLfpg15AsI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jfXcdda8JrBC0fQwvq18+KUiE23CjrOZdzFnr9bMgJxFg8irRBKHS8Nox8UUykIk8
         lG7yNAz0nNErQrck/OhznF1tpDcyG/p2orJ7pMJbZJxxnCQehYL/gMq9rbZbC0jbsR
         aaqjK92va+jZ4k5u1Qa45HLHEL47LXyaV2j3Mb9tcyfnoE9p1CnLAzNP0VNGJ6dyYI
         CLv79HohJAU99lcORLgmIfsRZr7kR9t6ulqIHtI3ECxKgD6WymKJ6bIn9Tzqbzh7JP
         u7n65CFRdnXumQ5rFbbZ7MSfCOscRscZ67komEfoXknuJ2Yql0Pd5xeZK3dP8e19c/
         N6pFdwPUhJ6FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFF8EC395FC;
        Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fanotify fsid updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231107-vfs-fsid-5037e344d215@brauner>
References: <20231107-vfs-fsid-5037e344d215@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231107-vfs-fsid-5037e344d215@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.fsid
X-PR-Tracked-Commit-Id: 4ad714df58e646d4b2a454a7dface8ff903911c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13d88ac54ddd1011b6e94443958e798aa06eb835
Message-Id: <169938925578.27832.3220980088475051039.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Nov 2023 20:34:15 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 Nov 2023 15:49:05 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.fsid

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13d88ac54ddd1011b6e94443958e798aa06eb835

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
