Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731C57E15EC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjKESxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjKESxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1980D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:53:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E702C433C7;
        Sun,  5 Nov 2023 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699210419;
        bh=M4JBT3QE9ijUui69l1vKwXF3KM5CqYYGNpDSwkuFEG0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q42Rdcn6aXh2BBrB5xQ1dDAgD5TuSskcR58KM+rgljlPa++BMKRVptjQlJn9PKb8Q
         ai4O1+XTD7r4iYezcXgyWbJ+BGP/uyIWCH5ZH887p5rwqKdY0nBhPpiIJnLxaAp80X
         vEv2A8oNa7y3iKu4VVf52zp5mBbRdiOV0jPzLUbIk3PEbA9xL2dqacTRFTVXjsHemu
         aCsKhzprZLWLwgliTOhBLjEywDza0wqX3/ANu2US/11pUJEmxvFLwRlPIALM1FsOgn
         N/5fv62oFQAg0EcAB5miL6BxiorEVOL+6l4Q1iEroUK+QEBxgA0ehdcIZEgnkHI2WM
         zWY9e1gyt7kBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ABC4C4316B;
        Sun,  5 Nov 2023 18:53:39 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS Updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <15692057.53962.1699180262386.JavaMail.zimbra@nod.at>
References: <15692057.53962.1699180262386.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <15692057.53962.1699180262386.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.7-rc1
X-PR-Tracked-Commit-Id: 75690493591fe283e4c92a3ba7c4420e9858abdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2153fc3d68170bb67be8e389c2f6e0f4a9eb7cd3
Message-Id: <169921041956.20864.10618508564929955622.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 18:53:39 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Nov 2023 11:31:02 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2153fc3d68170bb67be8e389c2f6e0f4a9eb7cd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
