Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B418092BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443962AbjLGUr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjLGUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D8C172D;
        Thu,  7 Dec 2023 12:47:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBEF9C433C9;
        Thu,  7 Dec 2023 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982021;
        bh=6dS2zuAvKrBBxrDNaS0kc8LPcERu1i40q36udX0aYpc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UKVJjbJe+upQhdSv3/4TUwwnzk3UU9nXmfLvTRWDhGbZjfGOlpOV23N/U4pVPXV8o
         GjAf/7u1qZmLiBtMcwwyxQxjnGYEjEqsNx8pnZ2K9bs6fD7Rr2ChGuSTDvrDSV5Gg3
         N+0En7MJ5zyX4E42dSm2yO8gd7ddZYZj3Tj//pfG+CagBbmRcICHxOOcm8+F6nbHjt
         AR2/vRGhqM0A/OYr9WPYgXVsHq6Km1kmf7QQAhdwJDPxQEf4vNPjHe7FZ1D4CGdoMq
         SAXmhtsj8zFSUk6Y6u7rUv7+yHLRJ/kPb/75GCFxCe6GVbpKSLHcukeVETR3m9PUeZ
         wy2/z+ZV/z2Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5D6EC43170;
        Thu,  7 Dec 2023 20:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.7-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8536f9$c6m0b@orviesa002-auth.jf.intel.com>
References: <8536f9$c6m0b@orviesa002-auth.jf.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8536f9$c6m0b@orviesa002-auth.jf.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-3
X-PR-Tracked-Commit-Id: 3494a594315b56516988afb6854d75dee5b501db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33d42bde99274217305327ab14cef9e182961ff3
Message-Id: <170198202087.1554.13904243869812227988.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Dec 2023 20:47:00 +0000
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PDx86 <platform-drivers-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 06 Dec 2023 20:16:52 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33d42bde99274217305327ab14cef9e182961ff3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
