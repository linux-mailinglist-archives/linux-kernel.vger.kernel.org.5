Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C07E0DF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377969AbjKDF0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378512AbjKDF0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B61BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 22:26:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C7EDC433C9;
        Sat,  4 Nov 2023 05:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699075587;
        bh=twbKVQ1Pld7//buPHyXwA87T6IlG1yVulNaI6z7PJ3U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZtarKa2oOCOdB9BWcTBdfIe4KRnm22jvDVWk9ZUhyU1VBZYEb5yvToEyVhawrZu4w
         Wg5rrpWoCWFY5A098PjAjdwofh5V3g9XCFhlVeB+ATndkqFJOeZUxqBDzXX46ey9vd
         szxqNNwTqsMEW6FVMhKCLRG5p0+jjm0Q6g7/QZOoCrQ9pAheqL+cBivt509goBz7OQ
         Vs5r6UnLpCn/p5XE0U7OF5BARDy89YJBOn9y6XjbqBdD0fhEXycvdQd5IHrxfrkm4H
         2YJbFkxf4yA8aszc+a4Xu1Adu3qoAjdkhAKVRyZQO9CuQMk7kNzZKwL/1ZflR6NE21
         p1FsjcBw3rJtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F058CEAB08A;
        Sat,  4 Nov 2023 05:26:26 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTopnFSSzruomdk@matsya>
References: <ZUTopnFSSzruomdk@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTopnFSSzruomdk@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.7
X-PR-Tracked-Commit-Id: d688c8264b8ed25edbdafac46ea2b41b2e77416a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfafa2c19d706ab1db0b581f9d3886469fab8627
Message-Id: <169907558698.8300.17853816781484660056.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 05:26:26 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 18:03:42 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfafa2c19d706ab1db0b581f9d3886469fab8627

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
