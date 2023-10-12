Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA207C788D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442894AbjJLVVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442964AbjJLVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:21:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A429DA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AC3BC433C7;
        Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697145674;
        bh=JDqDcN35jjlG1aV7JE5yfePTlGTwz3k5XoD8NBK4fxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GH8w6x4R3rJktOJAld+wSvSMgn9T8jaSuj/+5vo3DABmb6KETDZ+N1CR+2uIWv2fo
         qhZL1FGubV9RzQ0OKEk94bUOkw9wcd4jIj4cHAgNBFAwwb0RCdBb+Gz993KwGXKusq
         AGfDXQNCHFVSl6L1iQK73/L++tgh409U9evSorxqAQDQVdpNHT89aijLwQpLyzwgQG
         NLc2fGTcff0MMwIxc2EApkDW8mbA5vdVaEhg9tM4J6OcNum2+X0s9VkCDxv/RFpykk
         XQSpl38S8D0UT8bpzwhDcKGLEeM83+NncQCYBdbrF/2OxjeQxmD2qbBcya1z8nKMWw
         RpKWhTb0+IOag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39AD7C595C3;
        Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231012110443.13091-1-pabeni@redhat.com>
References: <20231012110443.13091-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231012110443.13091-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc6
X-PR-Tracked-Commit-Id: b91e8403373cab79375a65f5cf3495e2cd0bbdfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8c127b0576660da9195504fe8393fe9da3de9ce
Message-Id: <169714567422.14457.7076633708395048875.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Oct 2023 21:21:14 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Oct 2023 13:04:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8c127b0576660da9195504fe8393fe9da3de9ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
