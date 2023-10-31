Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C47DC6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjJaHCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbjJaHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:02:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44BC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:02:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB404C433C7;
        Tue, 31 Oct 2023 07:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698735758;
        bh=Em0+6SP1h0+BVZfBTwMuWnLpilzqF2na5f/iOYVPAg8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p//j+k0BAtRHHCjJ7ulGypl21TnpdXKPsm9qTq6MB01TVRMpDXvLzleU0SI6Qx5lF
         f5mllR0Y1CVHPHJfzDz3RSzH9s9OOlehGXy0IHBZRhSaidZhW/OTn7umGGT1LD2Zt9
         7SAuJvdgVkuIW29nKYgp5yW0KVuX+vR2KD0w5L1Ni9oMCRmrplD3fLRtjmIUqitRpl
         HOlZF8ZGeRXCtvjUOkmwVHJbP2tdFKWsujeT9vZd8SnVigUHqsMwqNFJhQGiKZDBNp
         PEcnL8Mte2Tin+wUM7MskoeYSQmHqQhSMxUArtmxq+qg+qjyMwpdnIXUBaY/4JTRpv
         70HSgdPuPDlnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8FB2EAB08A;
        Tue, 31 Oct 2023 07:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUBOCeLPnmgrE1qn@slm.duckdns.org>
References: <ZUBOCeLPnmgrE1qn@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUBOCeLPnmgrE1qn@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7
X-PR-Tracked-Commit-Id: 265f3ed077036f053981f5eea0b5b43e7c5b39ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 866b8870b6e6f478e9a1c51e732c9ba26dddbe91
Message-Id: <169873575875.30696.9400059903786318586.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 07:02:38 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 14:44:57 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/866b8870b6e6f478e9a1c51e732c9ba26dddbe91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
