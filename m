Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FA792FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbjIEUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbjIEUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:12:36 -0400
X-Greylist: delayed 206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:12:02 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138AE9;
        Tue,  5 Sep 2023 13:12:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D37EC4AF6D;
        Tue,  5 Sep 2023 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942939;
        bh=c70HEGCjw41ftKYeaYNL/y2D/6sbbLFGGwTxN9B51iE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O0cmWlTAMgyA2H8wD4W6i+B7t8Q/K+V5gRr/gpbdQ03mGq6Zcv2Kv14YYN2g8iSNG
         C7CLhTGKKTbJfmFd90gImlYBKQsIyNzkUdovDEG24tF5TSzDM7kVZxdgJgs2oYpXGG
         x4lDTqi/XdH0oGnrOmc2TkhK8okFiTa1AgN1bxZIQ/YZH9mTXfbmWjv5h4fViecBt8
         J2bdSwi4Nd9jeRnuVj+xJithrk0D0zWv/J0oPpoKpTa9OfLbN6WF2QerDh1+pl6XC5
         m4t+Z0ybW1esRORtcXOxz9zus1wONmHpseHHi3547wYwbjVrFxHQ5UTIAiThWoWPbf
         ZbbFAGdgk647A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49863C2BBF6;
        Tue,  5 Sep 2023 19:42:19 +0000 (UTC)
Subject: Re: [GIT PULL] remaining MM updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904140819.b49a4ff6366047ddcb2d9b1f@linux-foundation.org>
References: <20230904140819.b49a4ff6366047ddcb2d9b1f@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230904140819.b49a4ff6366047ddcb2d9b1f@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-09-04-14-00
X-PR-Tracked-Commit-Id: e68d343d2720779362cb7160cb7f4bd24979b2b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5eea5820c7340d39e56e169e1b87199391105f6b
Message-Id: <169394293929.11207.3847960336009299639.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:19 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 14:08:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-09-04-14-00

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5eea5820c7340d39e56e169e1b87199391105f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
