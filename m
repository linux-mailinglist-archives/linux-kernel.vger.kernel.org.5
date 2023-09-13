Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0C79F250
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjIMToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjIMTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:44:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467119AD;
        Wed, 13 Sep 2023 12:44:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECE4EC433B9;
        Wed, 13 Sep 2023 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694634277;
        bh=V/eIRdAij02rCdoLefetyatXcmELDzozmxu021tesPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IX5ddWkUUmyjZyKPBjv66AklHsxWvY8v8CtLQeaQlYzIGL3ceQHoWFpLQSoPpOerf
         aWzcrbOY4C4fhv4ikW69xTFX08tuK27tOqx4Pt3FIjXl+R6av9fb7MmX18dd/wbdVD
         f6i1/fuiGtln8xi2fVLIiHTVfWborvAHN0oa7iHxfJ14yb114fPGz119EfVRBy6Knz
         EZUeKH0mJY1RalCE+MOO4wHsFX7X84Tho51BuldZLpype8sdnEohvi0+ElpLGuFcyP
         1MqbBypigOh6U1VxbUNiqoBSk6iwG8znnf/7j8lXUzAPNs/+syMjAMTh86N2hyhq2j
         x1D6TFHYzXYVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC2FDE1C281;
        Wed, 13 Sep 2023 19:44:36 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQDBhMmGlXPll86B@p100>
References: <ZQDBhMmGlXPll86B@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQDBhMmGlXPll86B@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc2
X-PR-Tracked-Commit-Id: 08700ec705043eb0cee01b35cf5b9d63f0230d12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 847165d7c83ddb32aefab3ad4e7424fad919eb05
Message-Id: <169463427689.14198.2655761096386719389.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Sep 2023 19:44:36 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Sep 2023 21:52:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/847165d7c83ddb32aefab3ad4e7424fad919eb05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
