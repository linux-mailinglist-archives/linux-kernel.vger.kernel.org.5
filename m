Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298DF7E745E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbjKIW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbjKIW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:28:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA52D62;
        Thu,  9 Nov 2023 14:28:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2257DC433C8;
        Thu,  9 Nov 2023 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699568898;
        bh=zMVQ1ZqkBnfig6dJAO57aDj8+aPoUhjhlGfoj0AXYT8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p/Gj5JjtybjIs5Z7sBzEMrqd1S9s2T9WlV89MhtyUN054SV2skgF2b46RRDkBaZf9
         mrG/AIekSpEpkxvtXJ1mW0oM4cTb1HvSh/5YzYAYywFrBu/d8Pp4ngr58kZ+/+gc5t
         XjFUSEs6MBVmgyMrQa6tkn6wZhqCMd4EJG2yRFNzebazo0sZNMHVX6BYoIL2a3fABe
         m53pnvNXSozxWeewPg+BtxonmKlk6b70rlQHWkJ9vp2gyioupBm0pGZrcqk5gccBrm
         KiLlpTqVrF3mePUjohgY+2xJlQxoqBXoL+xc3ymosgQXrfxnul6yulzOTBFmN6kmDQ
         OwLJHG72D0WYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C730C43158;
        Thu,  9 Nov 2023 22:28:18 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231108130608.1321166-1-thierry.reding@gmail.com>
References: <20231108130608.1321166-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231108130608.1321166-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1
X-PR-Tracked-Commit-Id: 40592064a1a536adcced4ffea435c392eb9e7192
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3bfe643304143ce2727adc893cfa134ba27f968
Message-Id: <169956889804.16549.2262448488713717828.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Nov 2023 22:28:18 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  8 Nov 2023 14:06:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3bfe643304143ce2727adc893cfa134ba27f968

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
