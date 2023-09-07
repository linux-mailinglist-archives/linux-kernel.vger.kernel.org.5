Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540ED797ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbjIGWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjIGWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:53:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A51BD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:53:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD828C433C7;
        Thu,  7 Sep 2023 22:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694127226;
        bh=rgbMNq8tN0bVmMD6FjtQYZi+zsUYCMLP0Q+zIZrtTd0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Olqs1TTzgQ+t+SwuWSlTfwyBKTQR7Hnw8pUFtofqCaNfzOPnpg+gxpdaATKzlVK5T
         QjB03jDdzzCBF3NBtzfjPcGTOi3R5SjspFaVfagGD+HDIhUamI/pyi76Odffqce/q3
         dqqyt5T7QOGAwvc8FNkToW672HnEwqj7wZJ+J1jE0w6DcofmBxdm40ACau89SQUy3B
         F3EhaP3hnqYDQymtbKZ7p/Xb6jE82a1TF0RCxxMphEaf13CnmHyxdk6e+FjyPV91Qj
         czSdM9izRXk4muXQEwfa/STOahR868s4Rih9JYcFKYuSiAAoDa0GwXcrXFnXugPBOh
         exvCcT+C9S9DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACE8AE22AFB;
        Thu,  7 Sep 2023 22:53:46 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.6-merge-window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907123440.042F8C4936D@smtp.kernel.org>
References: <20230907123440.042F8C4936D@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907123440.042F8C4936D@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-merge-window
X-PR-Tracked-Commit-Id: ca0e36e3e39a4e8b5a4b647dff8c5938ca6ccbec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9b9ea589b47ba603acf18bbbbb44b1a662c61f5
Message-Id: <169412722670.28163.16928383695319786886.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 22:53:46 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 07 Sep 2023 13:34:30 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9b9ea589b47ba603acf18bbbbb44b1a662c61f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
