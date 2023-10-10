Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F57C03CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjJJSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343662AbjJJSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:54:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92394
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:54:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3113DC433C7;
        Tue, 10 Oct 2023 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964073;
        bh=5M8uHajsXetU2LCmi4J1QL/R3D0JAdVcfHelqD5j7yY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R0AysTWDZTRdTpMy28oqE1vqClsxRcjMngy9BB/5RL0729u5LSFKimU92eL1caOvY
         syJVepPaCmMllOohbUETf96g/qJgjOqdP+wYITTfwHZO0s4ax7tPJVPXAKtW3s0eNC
         RE3S9oZn4xeaz5qaO/LHQfSXprTsRTH/n/bsfAS5xj+iKwExCCWKOqXZHimN7/xvCk
         6yVO19d6fNV4cxoKxvOoBV4o+VNqMD64bDGuRVx7h+n+S+UxCV0k0cxcLdqtdPmfNL
         V+SDGR8SdulSszcMy5Satz0NT0OauPPqXlvS3coE6FqpSX6pH+0Gx/VDnmFM98MIUH
         WlauBACnOi2Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14027C41671;
        Tue, 10 Oct 2023 18:54:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
References: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231009
X-PR-Tracked-Commit-Id: 42999c90461293233de9bb6e6c7d8a2db7281c1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b711538a40b794ccc83838fb66990a091c56c101
Message-Id: <169696407307.29903.11304557279294545474.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Oct 2023 18:54:33 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Oct 2023 05:39:35 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231009

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b711538a40b794ccc83838fb66990a091c56c101

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
