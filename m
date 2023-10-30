Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304D47DC0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJ3UFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjJ3UFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1BF5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 952EEC433CA;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696340;
        bh=ijZ8Z/+6e386OXGSMMnnmAuMhfYcaq6MlpsE5qSq7Hs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YjIyvG+PYumwNI8mn0Jk2yzVVk5fATP18zJndKbzB/NkdgTH5CvCp5xmKm65AxvjT
         qR+zk4kWPHRoVcwq12rMSHHB1ZvcbzbfcmYWBSfkZK52JTVHOVzKz9tInfR1NBnuMb
         VuRSK0hZabRbjl2wE5623+sed6OgRU0YXZ4KUPn+SZvKHxEJbavXV6pjGO/hytlg8x
         iSTTvCRH2Esf2WAT/5mMcAL0+slKYvajghH415yTlT+/jNKbeOOrX+QuE7K/AmxBJr
         XNaFSqZsSv/k2Ubr+/bZLpU1V735k898AhEuM4WfuYZfclpOVEGn4XSyRayd85E6vj
         I6y7NLK/PYoRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AECCEAB08B;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] autofs updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-autofs-018bbf11ed67@brauner>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-autofs-018bbf11ed67@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.autofs
X-PR-Tracked-Commit-Id: d3c50061765d4b5616dc97f5804fc18122598a9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d63d8b2294b228147bf58def506dde35e57daef
Message-Id: <169869634049.3440.11020096823125592426.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 20:05:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:33:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d63d8b2294b228147bf58def506dde35e57daef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
