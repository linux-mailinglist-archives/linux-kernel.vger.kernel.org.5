Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754B57EA1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKMRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKMRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:16:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33BE99
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:16:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F879C433C8;
        Mon, 13 Nov 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699895779;
        bh=Rbfv91x+BKBH2FbFB6c3iwawLdkT0jy5zhy29xwzIc8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JhvE/T8pPlsRU+aZ5YwzL4znZ+bW73PH+7MKCjSMUARCZSgzINmGFWh9wpNVK3j0N
         ZSSlmnNv3ELnIexK4P7RwkBdsKPcN2oSBMMzAP6MLpxvNVIv2iYvHwGo1hhiG4Qd98
         v6J8yATlXPAcrSar6Q5sR6NOhAXVH61QnzQHZlg7PJWRYhKJ+k1B8YdcVOcxScW3ib
         YLVd5ZMCdZmAOCRDRZqxAyh1mavE4iyZpBR4M1FVXSUToWFUg9xcTYZtAOo2FCgDhe
         I+ljP61V2xZ+WBjVQQq68yChqKCYCc4nErXz30VX25tX3QNs6W/oX+2Vw6a8UzDQos
         rQZ2qZo9G5IFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D9E1C04DD9;
        Mon, 13 Nov 2023 17:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1699891630.git.dsterba@suse.com>
References: <cover.1699891630.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1699891630.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc1-tag
X-PR-Tracked-Commit-Id: d3933152442b7f94419e9ea71835d71b620baf0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bacdd8996c77c42ca004440be610692275ff9d0
Message-Id: <169989577944.20902.9323359004196842840.pr-tracker-bot@kernel.org>
Date:   Mon, 13 Nov 2023 17:16:19 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Nov 2023 17:22:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bacdd8996c77c42ca004440be610692275ff9d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
