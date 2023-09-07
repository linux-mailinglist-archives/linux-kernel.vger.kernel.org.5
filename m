Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78EE797ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIGWxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbjIGWxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:53:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99C1BCD;
        Thu,  7 Sep 2023 15:53:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45331C433C8;
        Thu,  7 Sep 2023 22:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694127209;
        bh=mdDyM7SK+8Ru9ob/pykfsPJ0cYfAmVzZFbKlCqyWKXk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CAUVasVRQ//1NnHdAlBLUDX1PSRDfKTg3GSUjx9qnL6T+ND5DaTOoXfF2OqfR+KiE
         QKX1AzypZTPzpExlUOoN7GaPwWw3IPnVRwbVQFNBVKWChpOGVfr+8NOHU/qMInLgTU
         9PIxJW8VeFr5kQq2C+A4ZyvnEN4yj3gIy7Ol+NXB7aiFAlrRWUKvGh3OxOzT8wdjF1
         qB+MlyR7n6U2BA0doBgcUZZgx8lpOVvA0ZxLjj4ghsKFUyTnP57FYmnndc8uRwqsYx
         xkXhKdeMGILmnC//U4lrLiYqjt8rr/K+DLq1oRIoAgXykokVpk5xZQCmdH11xeUNI7
         104sW74PCppCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C821C4166F;
        Thu,  7 Sep 2023 22:53:29 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.6-merge-window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907122815.41D27C32788@smtp.kernel.org>
References: <20230907122815.41D27C32788@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907122815.41D27C32788@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-merge-window
X-PR-Tracked-Commit-Id: 1f11f4202caf5710204d334fe63392052783876d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32904dec06adf350e04c2b2e6e6dbb321d852c6f
Message-Id: <169412720917.28163.8395714023587697841.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 22:53:29 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 07 Sep 2023 13:28:02 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32904dec06adf350e04c2b2e6e6dbb321d852c6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
