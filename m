Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125817DFDB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377802AbjKCB0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377644AbjKCB0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:26:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEEA187;
        Thu,  2 Nov 2023 18:26:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45F0FC433C7;
        Fri,  3 Nov 2023 01:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698974772;
        bh=//5GHmxZWE+RdGR7IAxAjoJOrEPnrQndbNswNuG5uDQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a0kn0bjMaoVRUCqfW9MmLvgratp2FEQhJKhPvG1zCdDlE5+06m4Ja/AesJ74wXKny
         qbbEBVDNQ7G60/HnwWUUczeqq9oADnuU/3I9hOmKtM3WVumMEhUmBJcH/tz21KILqI
         1v9GLX0/GMXXHJm/tuIlY/yx3ApcqqYGM5gMjwLKu+hUOGQBxuFVTwvbKxYCD6cIYB
         cncK6xT972Hmfg8MOG7+Ok1me1O95nokYe1+xSDmKTNiQuAY4Xh6Q30QI09FNofGWy
         GhB0LmxmDy/QdvOHh2r1hI8UugAB6MjM4ZpSy3t2WCxI20gck97VA+s8NJg5rCt6/X
         IYcFFjGXg8Bzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3110EC395FC;
        Fri,  3 Nov 2023 01:26:12 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4e8e9b1fd477b46139a77cb57323df5a7476b1b9.camel@HansenPartnership.com>
References: <4e8e9b1fd477b46139a77cb57323df5a7476b1b9.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <4e8e9b1fd477b46139a77cb57323df5a7476b1b9.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: a75a16c62a2540f11eeae4f2b50e95deefb652ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ed92e559a2ea572ae2bac5cbeddd1dc8cb667b6
Message-Id: <169897477219.31710.8207407080323640161.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:26:12 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 Nov 2023 08:28:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ed92e559a2ea572ae2bac5cbeddd1dc8cb667b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
