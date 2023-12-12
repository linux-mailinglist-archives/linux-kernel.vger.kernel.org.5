Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB680F72C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjLLTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:49:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084879A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:49:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A901CC433C8;
        Tue, 12 Dec 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702410572;
        bh=iRox8wBzt74waqIhkUBhPBSuffNObnSpo3yDqzOx3pE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LWgVw7VHq0Z3qmvqGZ6T9VLRTKZr9Ss9CLlXCjjnRYvfD0CdOB29ltGskVveASe4G
         /grgx7mbx7FJeKwu8H6zpqhpkEhvinEtszX2qntUqeB5y78bUpNRvL3d7J8KF9ekXJ
         /AiTo8rdN+Hp6YAmUNqB5GJ1DtmBUc6DZgEN5BsyQlqH3nlaqRK6kb4NO95/NXpjtr
         4Npdg8wMA1mIq2QRNPXYPKHdWplF5ymarBtN36w3c2kHNyM8fO02OjmYGgrESVtNPd
         tKc6qkDYImKBNuzz7yPOn2BZpIMu0gFzq0t6l0AQzhfuHa1kVg6l7w+NBav4Tz2Pc/
         IP12CBqP3440A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97DADDFC906;
        Tue, 12 Dec 2023 19:49:32 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for 6.7-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231212193303.GA154795@mit.edu>
References: <20231212193303.GA154795@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231212193303.GA154795@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc6
X-PR-Tracked-Commit-Id: 6c02757c936063f0631b4e43fe156f8c8f1f351f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf52eed70e555e864120cfaf280e979e2a035c66
Message-Id: <170241057261.17345.424030301237809121.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Dec 2023 19:49:32 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Dec 2023 14:33:03 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf52eed70e555e864120cfaf280e979e2a035c66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
