Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8287E4E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjKHBGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343870AbjKHBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:06:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C78F193
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:06:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39569C433CA;
        Wed,  8 Nov 2023 01:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405589;
        bh=dfj2hd4ilX/1jymM62qXay3QF53rgvhqmFYA+A2x2Is=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q2AFCBj7qcsL9M4DvTbfnovCDIa6/75ur8LJ8MbMXdBGlMINXm0OZAkDq6pluv1dZ
         94TWzpD0hvcZQM0XPmNvdisamRI9+hFJAOGNW4fTs4fmR+PrtR5WZwzW9A7aNyIZss
         vl5Jh3AaFB8FDt1s0I0MSVUCPv7U5z6gTncLHIIXWBo2U6J9WOXp/xdop+k6ecCY+G
         ypVzgi309P8ej8IB8lgyCisZplU+xNsLOvMS+9bmhL1wx7bk0KMwCP3kvHq9x2AcsK
         9s53c51jXQCs9Q4jgW5MLPZAouG0lt9oCv7IZNeSVY+MRncyqdWXTsfhhCEMgVNo//
         9zD5cSgRwUg5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25B9BE00083;
        Wed,  8 Nov 2023 01:06:29 +0000 (UTC)
Subject: Re: [GIT PULL] PCMCIA odd cleanups and fixes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUk62d3X1ETRrcuQ@shine.dominikbrodowski.net>
References: <ZUk62d3X1ETRrcuQ@shine.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUk62d3X1ETRrcuQ@shine.dominikbrodowski.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.7-rc1
X-PR-Tracked-Commit-Id: 4f733de8b78a209501041a4b0a44c83ece0e8933
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3fbdb8ad33491f7c241a1167d7e3009f6e3f085
Message-Id: <169940558914.17903.10545845857794269015.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:06:29 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Nov 2023 20:13:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3fbdb8ad33491f7c241a1167d7e3009f6e3f085

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
