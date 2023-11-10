Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D87E8367
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjKJUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbjKJUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:05:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51769D0;
        Fri, 10 Nov 2023 12:05:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEC27C433C8;
        Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699646740;
        bh=OBzaUjzWEEhvOCPAMonMwkAGd1oL8TEqU9xKzVaZs4I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qbEVmPBUm281rBsRDvEvB1w62U2JUalGXh1ehL2kvLiD+VM9GBlCKcKujqbWeX7uC
         g8gtH1wL7LQZQU3H1ZMVSD5kDAg0/mXcJEcMc/2sZZPSoiXUP4teDFy56OUwkrrYAH
         KkQFHk89kh03ynHZ4dw1JO99yJT3E/4HerkQ0JmzloUKCfTnt/WCCvNTsOvUo9kbf1
         X57xuqKPKDGfPH60eKsIQSEqQrPR62dwrRpjxGXcbeqUM5/9pVGFAHwPHNu5j7pDlS
         IjgNdMRl0r2c2y6ZK911p+Kvi6pZIjAR8wcYhiTZRCpP7Dqbf4iQMPSi0uUM0kEkMA
         +fg6FUTF/vZ8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4B66C43158;
        Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.7-merge-window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <37bfc2b52cdf44300d906fc69084bc29.broonie@kernel.org>
References: <37bfc2b52cdf44300d906fc69084bc29.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <37bfc2b52cdf44300d906fc69084bc29.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.7-merge-window
X-PR-Tracked-Commit-Id: bef4a48f4ef798c4feddf045d49e53c8a97d5e37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae4f52a729a17a48865a008a6c7dd4c44077ec54
Message-Id: <169964673986.27739.6560435806981013516.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 20:05:39 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 13:59:58 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.7-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae4f52a729a17a48865a008a6c7dd4c44077ec54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
