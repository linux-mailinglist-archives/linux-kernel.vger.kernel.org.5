Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1127C8B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjJMQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjJMQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69DAD;
        Fri, 13 Oct 2023 09:39:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B307BC433C7;
        Fri, 13 Oct 2023 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215195;
        bh=YIyodcYU7tvuNNX91+0d1//LTYc1g53rjS6Ls2vn/Wo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fPZTlwLE1re1ZiCQmwPuirxRneb4I7ltQq1T8z6RSxDdVyiGObu2QdQOI7nacPTGv
         R9UkPPMJak5jYHX7AzwTzdoaLp44MW5Xld7Ar7LS11xjaHcxCou7xTgMvRjC5nwNAC
         0T5t57T/pxhcviMkeouj/KJozv69ZvjCE/7lB8eTQZu0w/EyNbRRgfKl9eR8GoXOms
         A/hXPzjh+EK++qSTYPEFLhSkMqwKALCNdgJAphjTdW2sJQ2cAr+AEmLRYXj2YN8fti
         cxAYj7AdkxIA+hQO5v0NCd7cgnvjVUa8cvzH2xoMV8PRAqTgMZ9ExwV1gE2zrmsohg
         quika6xgqtzcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 936F5C691EF;
        Fri, 13 Oct 2023 16:39:55 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6-rc6] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231013131141.669dc1c9@sal.lan>
References: <20231013131141.669dc1c9@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231013131141.669dc1c9@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-5
X-PR-Tracked-Commit-Id: c46f16f156ac58afcf4addc850bb5dfbca77b9fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c367d8eadc00ff04bfab184ccd07b34ea89661a
Message-Id: <169721519559.5219.1754295751090358749.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 16:39:55 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 13:11:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c367d8eadc00ff04bfab184ccd07b34ea89661a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
