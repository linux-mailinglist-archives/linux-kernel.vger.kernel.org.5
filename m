Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3155C7DEB3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348370AbjKBDP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348358AbjKBDPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:15:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CEE123
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:15:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF414C433C8;
        Thu,  2 Nov 2023 03:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698894940;
        bh=69/JMWEdxrjs9sM/ZUp4nCr8TpJrXbTqnYoypA46PJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qy4qJglOll25Asfqi5KU6k3cptPHb2v/icck/SFKNrfKpty3V2Sn2NQURM8/tQWkS
         i1ew98IzONKbpWOxDqsKofwgJXPzoq+pXfgwjGyoB6GX3EpTMuYLqU5/Ghtw1SgxIH
         jr8gaAHvBnKlcpdLq0z2nxbfueRES6iBKK5X3Pak5bAhEI/Krtpr0yKQCoZ2qs+5Lt
         8HoVHGXTL8qpGw4YzUhUpC1FoxL7SOR/KU5wOkPDTNF/rYQ80szPh5IG0WZGHcawRH
         fPJc2nhu6du8REe93XL4XyrdIp1QIX/2vdTqEBGurb/RkVthMEls/+CX0vFvyEIv4e
         MtWi4jHZpnHWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD614C395F3;
        Thu,  2 Nov 2023 03:15:39 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fs1qd7t7.fsf@meer.lwn.net>
References: <87fs1qd7t7.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fs1qd7t7.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.7
X-PR-Tracked-Commit-Id: cf63348b4c45384d02126f86676d5afc75d661a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: babe393974de0351c0e6cca50f5f84edaf8d7fa1
Message-Id: <169889493989.1076.16502637498263366608.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 03:15:39 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 11:24:04 -0600:

> git://git.lwn.net/linux.git tags/docs-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/babe393974de0351c0e6cca50f5f84edaf8d7fa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
