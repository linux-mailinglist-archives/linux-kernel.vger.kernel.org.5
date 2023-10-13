Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF57C7BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjJMCtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:49:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F20B7;
        Thu, 12 Oct 2023 19:49:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E87E8C433C7;
        Fri, 13 Oct 2023 02:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697165390;
        bh=QePjhnrr5bXOySLZ4yd6DXsFYEB+DEt3y1Ny2geqJ3s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OLal7hPnYTXYKcnZgEy/0KTceZLQ4i4Wk26o3Is7Rj+tm8t7r3P3+rE3pwhwn2uBi
         7EGGHMYdybHnPLXZmUGF9ubH1c7+pqbT3EDHCPPg7AoCakpwpLzBJkM0Mhn2EbTbzc
         b0Vq9YkdP26YabTrwPKM9BkkZHnuc2NgLbKODo99RUtPJsp9bW5/PPgNctfhPE6Izs
         anKNKrqQth9VrePsY0M7tUptbLbA2o7bPXQqoGc71iRg/KoCJpD4Hpm5TAt/21NPEx
         1BTwr6xrinCpme0cfYX8n7MKZkp+nX5/MDP0Lorks/jHW8Ik0iAm/riL0q9b+zdNE5
         5Pu7nXR73Zq9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB7BCC39563;
        Fri, 13 Oct 2023 02:49:50 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231013014139.yhfw45mur7lbyxfm@mercury.elektranox.org>
References: <20231013014139.yhfw45mur7lbyxfm@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231013014139.yhfw45mur7lbyxfm@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6-rc2
X-PR-Tracked-Commit-Id: 8894b432548851f705f72ff135d3dcbd442a18d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce583d5fb9d3f4e20473b9d5619d51ea3cc92283
Message-Id: <169716539082.12343.1558552470274382291.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 02:49:50 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 03:41:39 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce583d5fb9d3f4e20473b9d5619d51ea3cc92283

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
