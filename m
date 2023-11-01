Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12F7DDBAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjKADuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjKADuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:50:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50775C1;
        Tue, 31 Oct 2023 20:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFEE7C433C8;
        Wed,  1 Nov 2023 03:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698810608;
        bh=6dzLY2iaVL38rWgbdOCcm8+H0ylE8sYbmlWZ4iLykY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RSycqQWfeiPGcasjpHx4WpKeprcHwpoXqhWGsKSybCwp+fNuIIR9kSCSvitOIsLqc
         YPzCVY0+AitSDN84kfjfJ47zG+wsVOmh69pqnaRxMJ9qd2wGjm2umME+Npg8ctFm+m
         nthpmdKTGCjNnIpzPQQNKHCBWObTflw/JDx1c0k74O+sTHDCBqJBV4Tk9pa4bNn0gC
         E3unjLgBvGiKqmmi9/4thH+ch9eXVflY7oMugEgTCGokGRLHygkhqA6l9DSYqIA3eE
         76htZXspZxFhliQhSHAbM8qdGy1sLHALT2dwV/ytdlbILZg7SxNutSsa+XMjE6Q8Kt
         lMI9dwr/RWXoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCE1CC39563;
        Wed,  1 Nov 2023 03:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231030143340.2251301-1-linux@roeck-us.net>
References: <20231030143340.2251301-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030143340.2251301-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.7
X-PR-Tracked-Commit-Id: 0f564130e5c76f1e5cf0008924f6a6cd138929d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9a7eda4d73d44dc1d17d05cdc9aeb9fc5660740
Message-Id: <169881060783.15630.10494784992677768377.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 03:50:07 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 07:33:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9a7eda4d73d44dc1d17d05cdc9aeb9fc5660740

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
