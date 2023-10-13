Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07BF7C7AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjJMAj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379509AbjJMAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:39:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B094C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:39:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E7A1C433C7;
        Fri, 13 Oct 2023 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697157591;
        bh=sz9I0Q0eXTpw8IBCkmFB0BYmz1j+4yp49G2YdNKdNhA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=silJG9J5+6EUCpiQ8IMVwYVEby55h6opW/1ppg0gJwbZ+0cw0/kJkFbbGK3ZziNJH
         RjnLQEXhN/GUjIBWI1D/6mjjUF/Dv4nucKpI7SQMPYVp12Dc5dki0fn8jU8OFfYGBa
         8PX5++2KdzyL1NpgZqKHsgvxdWaFTKULe4EDQ/yJD4nh9YAY40NnYOkSbFG7k4ehh7
         RomzCSoBdkjCG1dyh3K/oWh3Y+uDYSkui2/4LnPHlEUBC8Z4PUxHNYzw4YCFZINH7O
         UpcYQGMIkIE243Dd3AAT1GA5mSh5snJidDB4gRGtbUjaB5GPbgN01am2VrxSPB8ZH3
         giHGlI1ZhNQpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01570C595C3;
        Fri, 13 Oct 2023 00:39:51 +0000 (UTC)
Subject: Re: [GIT PULL] Workqueue fixes for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSh-Mjmquc6wAw9B@slm.duckdns.org>
References: <ZSh-Mjmquc6wAw9B@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSh-Mjmquc6wAw9B@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.6-rc5-fixes
X-PR-Tracked-Commit-Id: 5d9c7a1e3e8e18db8e10c546de648cda2a57be52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5e1170364cdb21c59638c8900b8cab7578cdb15
Message-Id: <169715759099.17241.4119181278306974098.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 00:39:50 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Oct 2023 13:16:02 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.6-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5e1170364cdb21c59638c8900b8cab7578cdb15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
