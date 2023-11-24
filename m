Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C27F7DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKXS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjKXS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:26:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5162210C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:26:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D21FC433CA;
        Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700850381;
        bh=wqOUFpnaHzv8Q4VPq9XcpKKDoJgSUHCKXfYoFOuaCyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MKXrIA7ntVv2rPSlvT9xufw+rwxRWkUQytiR7iR3DFwIpWqB/cv2VwdR+Aiws01WK
         XhU+SK5udKO16M/4HEM57rERcF4aI7bKrJwqfE6lDVpArPZJg0cAXybz2jtuAYsSFW
         Iork0MAeKnfwiPjfgR4fiuU6jH8JLmIVK6rwMKQSACexEswcS4B1s7lOBZznbifyuR
         cnqL8ExeklRhsGsL/8vFmu1jGY+i6A2yCFcH+Ps5ZgaLOfQxaeccVr7ZADlqSiyZRw
         bnKxfKH4DzwciKDrXd47H1LdG37l2VcjqtJ0N7FJTOhQiEFhWy27CvR6Aqa8WvLLm8
         H5wtAmFAO2LFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 498A5C395FD;
        Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231124-vfs-fixes-3420a81c0abe@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231124-vfs-fixes-3420a81c0abe@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7-rc3.fixes
X-PR-Tracked-Commit-Id: 796432efab1e372d404e7a71cc6891a53f105051
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa2b906f5148883e2d0be8952767469c2e3de274
Message-Id: <170085038129.12986.9041931709697424833.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 18:26:21 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Nov 2023 11:27:28 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa2b906f5148883e2d0be8952767469c2e3de274

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
