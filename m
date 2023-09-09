Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F7799A7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbjIISxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbjIISxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:53:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63ACCC0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:53:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F223C433C8;
        Sat,  9 Sep 2023 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694285625;
        bh=PtyEBnBLcTmBKI6CQDuhWfJGvDYdeg7kTLGUQXuhuAc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jn9HZ9Y/ZcGNZRpAODspAvtlP3l2XVdwVdzAnhTvo5kVA+UMr59MOBiynQCP9f3g8
         C0qBaW6vGPCH1zP0Dt8atxw1JlDPopwbnU3C/YDQyKzevUccpQcxtNAT4oT2TzbMKr
         lYEqCi+tMOM1rGPQq2XslLYdtLHFmb+jE3kuRYSfsGs9ltEa3v9l1XjbpUsZhguqgu
         MNfvwg5f6/+/f2BKkrQxyBj2bZB9gCWTQHWHTV92wPRe1dr6BP6F7x3becH2BNMSWc
         mvlyYoqwcOo10Vd5hb6sW7HevKIGlCcwSA5tk6usN0ocqFZ2bs9ugErhnhUFqHu6KF
         EEfs24D9aKkOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E756E505B7;
        Sat,  9 Sep 2023 18:53:45 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPwxAWSXvmJNgj0X@infradead.org>
References: <ZPwxAWSXvmJNgj0X@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZPwxAWSXvmJNgj0X@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-09
X-PR-Tracked-Commit-Id: f875db4f20f4ec2e4fa3b3be0e5081976e0b5dad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 474197a4f7921a97aa1aabc6f759823a024ff25f
Message-Id: <169428562538.13340.9813278453236449776.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 18:53:45 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Sep 2023 05:46:57 -0300:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/474197a4f7921a97aa1aabc6f759823a024ff25f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
