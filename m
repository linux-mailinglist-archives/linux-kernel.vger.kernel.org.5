Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D57A9C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjIUTMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjIUTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B5803F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:35:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 969B7C5FB20;
        Thu, 21 Sep 2023 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695312672;
        bh=LtqP847DUn2/wB0A+heTNMVWXmoSvHkxv/DokWcELVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f4mUg7AjTTouzrOrc1jDBxlW3nbK4k3U5Lut8muygCcuVdbY2O99w0rOS3tW3iXFo
         AxhUoFo+BnZc+Hy7WOFhdXSDMuwIJrroyNlxwNcqW+z8n6GsAXxw3iH/YK6U+IKSP4
         t0rI7qyo+mO2yjeMjLw5izrgKanXjRhPIgbaJ0skCGw0ekpMQicGeGKdOGn7jjmgbu
         y9FiiYnEM7gdMRRqiPmcNqVa8ReriOfeGdZ24WDjdWfFpbk5qsSKw0cOsdyCBxHj/a
         kSbPQXdOR9RIod+xm9Q0jI+voVISHQs56VsQCLM5h+HlNmqdRRk666fZPJheqBpnCa
         riEGbdihoh5cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79512C41671;
        Thu, 21 Sep 2023 16:11:12 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230921084110.31633-1-jgross@suse.com>
References: <20230921084110.31633-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20230921084110.31633-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.6a-rc3-tag
X-PR-Tracked-Commit-Id: 0fc6ff5a0f0488e09b496773c440ed5bb36d1f0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88a174a906fe9679a26c0f69fcc022743d2c8e05
Message-Id: <169531267248.30941.16423681976609784882.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 16:11:12 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Sep 2023 10:41:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.6a-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88a174a906fe9679a26c0f69fcc022743d2c8e05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
