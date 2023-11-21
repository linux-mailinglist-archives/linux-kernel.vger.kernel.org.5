Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F17F377F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjKUUdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjKUUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:33:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63DA1AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:33:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1744EC433C8;
        Tue, 21 Nov 2023 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700598824;
        bh=egAqlVYa/A/HI0HadKIhudt6IzD9eGNLvK0Ri4QfjTw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g9cO+tJ8dqXbdCCNyztmmWUOTkV7lv0Wfy3GX6yA4DF7VbpAhk5oHQkhbX14Z8MtJ
         T2VCXyWlIby3Q19wppYlQ6ReCkDVbWYTVlDzQ+jnOUY8NSUrxAkrxBWaGW5GHPRsks
         RBrGfMAvzEwFR1XgLMpnU1MMxPvlWM+NmelN8mjTNsWJZs4TK27vcTFc3Dp2DBJJZa
         H/4WdVkA1E5zQzfVO6wEyMbEMSJTRcGdvmoDpzmBTJpRJhMvqeB1X0CH12gAa7aOTx
         G1z1puENxzdUMbV2YlETs/MaeMoOynDkqcan1Gq1APcg/BSZriLoNUY//nUUZazNFV
         afV0lf/wx6+5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 045B8EAA95F;
        Tue, 21 Nov 2023 20:33:44 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZVsQBsV2GFTmy+iZ@debian>
References: <ZVsQBsV2GFTmy+iZ@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZVsQBsV2GFTmy+iZ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc3-fixes
X-PR-Tracked-Commit-Id: 62b241efff99fc4d88a86f1c67c7516e31f432a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b65522316489ff0b2be65d00fbcecbc781017c9
Message-Id: <170059882400.5512.9141675111276341675.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Nov 2023 20:33:44 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Nov 2023 15:51:34 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b65522316489ff0b2be65d00fbcecbc781017c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
