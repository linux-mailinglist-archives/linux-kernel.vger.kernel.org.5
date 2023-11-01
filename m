Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24AA7DDBAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjKADuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjKADuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ADAA4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:50:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54927C433C9;
        Wed,  1 Nov 2023 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698810611;
        bh=Hd1SULWRRD8nZs3PlsfVkaDp6hr4ZklIraLWY73hn+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EGHYCJD4xl3ATC68q+BvV/h4xcUItqei5Rd/58cyVXL/EBV6KK0RmY+PZer5LsHRl
         WhZQg7JBhcetptvQ9IGopF+jY8/7YVPLKZA7kyl+0pIFXnsmK7JotxONf3+Q6ZSgZg
         YiyyAJwy9W0f79MeI0nPx+tb7mp44btlY1MDd1IOJL+egdvnEx7FGCq764aw3ZNeww
         jZMdGuqSKkPe4GTSwDi6SRamVrbhatmV5mHdATJRhHADBsBmyxJZ1j5YYMmISWDf/c
         A1y1hCCGX9vq+7k3Yx29yFhnCJsL7xN9PMKsS/c4vnQPzeq3U0qR0V8fsQPUBxHilq
         go6PNvvQcOiMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41FD2C39563;
        Wed,  1 Nov 2023 03:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231030133404.256A7C433C7@smtp.kernel.org>
References: <20231030133404.256A7C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030133404.256A7C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.7
X-PR-Tracked-Commit-Id: 6bbebcc11a69aef269eb2a33212f76992a4cfb1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cbff4b2d9e2a59f4096af8b8f967e2b30f025f2
Message-Id: <169881061126.15630.9818789556686895063.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 03:50:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 13:33:54 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cbff4b2d9e2a59f4096af8b8f967e2b30f025f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
