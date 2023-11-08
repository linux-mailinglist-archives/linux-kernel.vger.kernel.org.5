Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F37E4E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjKHBGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjKHBG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:06:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD87E7;
        Tue,  7 Nov 2023 17:06:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23AC5C433C7;
        Wed,  8 Nov 2023 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405585;
        bh=Jo/ADV1o5u758rj4x+HCsjSun3AayVuHMfYxn/9/MDY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CH7EmB9gQZB7ySR/fU6CdLfBR0KPEZhtz84ovnN2E7NC5M3AbKTUOwWrSb9Lg9Xew
         ywIB5iu1LHJGk8Ci2QxmIDpRVk3UdHD/9W8HDrdFjlUYjOZLVir+mNxAT4YWOd4T4a
         MSa5+tS9UylPnlAp/hEDmgPImvtdbKAEU4GynomuL5ts5oShnAEZXnctyClACmJk/O
         1L7d7EXkecnpuPA+q+f5bgqiM6iq1l4SGSsGgGT42uUnY5HP/+SMQa3Z9sQqpw7IMl
         iwQ5jUzHl2eazw9+i8iMMwCSqNS5bE9hclp1Mtzqd1IP6/zopuQNwSW/qetP8g03aN
         LFjRUCy6b8ajw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 129D2E00083;
        Wed,  8 Nov 2023 01:06:25 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231107031112.2563663-1-andersson@kernel.org>
References: <20231107031112.2563663-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231107031112.2563663-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.7
X-PR-Tracked-Commit-Id: 2a6e483ad047654a220c798080d0fc861ead2e07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c87271ee86e836d3beae7b8b0222e81e225fa6c5
Message-Id: <169940558506.17903.7973805923089372952.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:06:25 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 Nov 2023 19:11:09 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c87271ee86e836d3beae7b8b0222e81e225fa6c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
