Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1399B7D02A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbjJSTlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346586AbjJSTln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:41:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87008E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:41:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 288FEC433C8;
        Thu, 19 Oct 2023 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744502;
        bh=146dGb+6XobHWS/WTm6XBevDFMhJZ4JqrHRQSP2wcIM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UE151hnv/LGmQo/uuTV92amBQOnmIRaaeu9rdnTZ4/hH+UMjjQqa9JKLSJeO5u0je
         Wrn8tCN2b9JHWYwsrPYNlT3+X0IUZYiakZYSKno46F93FYgcwGDM0wv4/F6J8NxGoD
         p1HzD8uO1POkkprWGPQDYFJiwfwfPDXsr8RClrYuD5rfD9x19wTwOhHoMejRk2lXVt
         tc7cQDoetMi4yWAt+01OZrEVzU18SpWRC2O1FE8sh4LAH5Y0t4LRk/mdtY/1H8Ubaf
         4wx3B2NfC3wWWcm5EeU57lvUxDztSoJUlK1IG3l6Af8/ljQYK8yPRrVkiSkUK7PQMZ
         kqCQz39KknhgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 157A7C04E27;
        Thu, 19 Oct 2023 19:41:42 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231019174735.1177985-1-kuba@kernel.org>
References: <20231019174735.1177985-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231019174735.1177985-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc7
X-PR-Tracked-Commit-Id: 524515020f2552759a7ef1c9d03e7dac9b1ff3c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce55c22ec8b223a90ff3e084d842f73cfba35588
Message-Id: <169774450207.26229.8169337360472386974.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Oct 2023 19:41:42 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Oct 2023 10:47:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce55c22ec8b223a90ff3e084d842f73cfba35588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
