Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E709879801F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbjIHBZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbjIHBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:25:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374819A7;
        Thu,  7 Sep 2023 18:25:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DACFC433C9;
        Fri,  8 Sep 2023 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694136333;
        bh=TYSlM0bo1CH2FImbfJNdEq0J+orTftJBRpU/kO6N8Pc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I/RfF+EzDroYCD9EIoEG8xTTjXYGWkv5n3sHF2JxFhakjNVI2Yuuf/0mljcaRJCBu
         eGq4gEAkH0ubDtFe51gZKwbZdKC24Hi4NFluMU1z1KN9QPmkXnbKyTr2pTLwWaYAi+
         X7g5bzMuJcjVafw14uc9HLsmnakYHWTypKcypUDplC+xu0Oc8JevTyEfcJ0yqSQWtS
         Mr7rdH17/pZtodIK1PtX71gx9t72IBbsiTcYeQhVeDKJ84IXMJnW9MEm6IuiThPsSq
         5bgZrr0xVPyieluyjo575ih0mT20tMCXTNfB8jpo8ffqpVJnKsXMlHU1aDKzYSOckJ
         n0GQZRJUH2SrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C226E22AFB;
        Fri,  8 Sep 2023 01:25:33 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907145738.1185893-1-thierry.reding@gmail.com>
References: <20230907145738.1185893-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907145738.1185893-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.6-rc1
X-PR-Tracked-Commit-Id: 4aae44f65827f0213a7361cf9c32cfe06114473f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d844b351824d622fa28bb0cd7a8fecf9aae05ed
Message-Id: <169413633317.5754.12522196078382107571.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 01:25:33 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Sep 2023 16:57:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d844b351824d622fa28bb0cd7a8fecf9aae05ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
