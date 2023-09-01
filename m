Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77077903FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351189AbjIAXUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351187AbjIAXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEBA9C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AE66175D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51A3BC433C9;
        Fri,  1 Sep 2023 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693610408;
        bh=56408VrOVrGTL5Z4Ta5WoYXaIPU5GSyNBIPsDPNQ2TU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K5SSiSrRSKjYZ7i4CllAjcUUGt9UPuh44vX1qoCmeLmIRwd3onq0W5yOByUkhvIyi
         xmvdmPLFuTNNcz1Q1n8EUBirgW9FY9w4Y1wzpZnGCJQH2hfVjNDSqbBT3+7l3jF+Kw
         QpVgJ6eKtRyzPKJBSWmLJTFSjJ4Lwj0TBltNVNaGUCmoqzyX+sd/LLIoEgHFd3+4jj
         aPQsJ5rVbVsVBuNvtPelpBTGMS6XMFQ+tjdqPr5KWGG5nQ3XSuZ326U0ESMN0Bntno
         nJyx9V3Pg26QB1qAIGHOy5QK2YXOom1po7T1PqrCKmz5HyE9JbHUlVmD0uiwmemHlb
         SSbgwp1HAC1QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 382FAC595D2;
        Fri,  1 Sep 2023 23:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPESClTTFQ0xo6ku@slm.duckdns.org>
References: <ZPESClTTFQ0xo6ku@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPESClTTFQ0xo6ku@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.6
X-PR-Tracked-Commit-Id: fe48ba7daefe75bbbefa2426deddc05f2d530d2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd30fe6a7d9b72e73c5ac9109cbc3066dde08034
Message-Id: <169361040822.4205.6157657206041381201.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 23:20:08 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 12:19:54 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd30fe6a7d9b72e73c5ac9109cbc3066dde08034

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
