Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1E7B59DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjJBRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjJBRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E190
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:45:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0738C433C7;
        Mon,  2 Oct 2023 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696268725;
        bh=OebXjDEOZa6ivgFkBfeBsM65Cl96z9kA28gUyRehOpQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=prXlZKQdSCorSzcbhOR//eJMOK1xyUKJOjiu21npvB/7hF/tQ2YuwSTOnJdSt1ZLW
         Ybg2T32XZakyapwjwGkx0U0r04BfC4H9NU21PRWEwmx4dGLUkpMH0OoVFxSfnfhrgx
         wYDqbbnCMxZGhFhyeRovp8AsvBeQzn3KOeljOgM2CXfSPUvfbNOd8ROksw1sCXZOhB
         HWe6XxT2FGIiE4lWatmRKdfcYcN3kGRJr8QeuldPuiFM/FHHDZ9uD9oRzBT57G3I8g
         0xRpAqVrHdAYjjAFAqQHQHYlNNRgN6vRyjiFPtKfZExqccHZO6j8cb/eySxI4vRluV
         MwWKIZFY4UaXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD65AE632CE;
        Mon,  2 Oct 2023 17:45:24 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRpmBaTbF3xPNJHz@8bytes.org>
References: <ZRpmBaTbF3xPNJHz@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRpmBaTbF3xPNJHz@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.6-rc4
X-PR-Tracked-Commit-Id: 59df44bfb0ca4c3ee1f1c3c5d0ee8e314844799e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f1b4600373f9da2afc124f31788b16f47eb950c
Message-Id: <169626872489.14950.4405464693910497570.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Oct 2023 17:45:24 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Oct 2023 08:41:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f1b4600373f9da2afc124f31788b16f47eb950c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
