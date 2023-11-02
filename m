Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAE7DFA0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377223AbjKBSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377206AbjKBSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:38:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8E191
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57069C433CB;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950285;
        bh=o87AAGhIg8aXtpENTsqMhziDo2SunCpttKIEewidnew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JzgixPU5VN7BZq54XV21jvgk0hdcQOtjp130cc4hXEl/GBul98VUFN2C7Hh2Y9zMA
         I9HHv3fAFBEeWGKvkPhRZkknEQds+cjpbQK02Sa0IsV9QBtaulIOBBimt8AanAjt+e
         IcOQln9IyPWCFZPtdOFZbEg2dZyQ+UPIl8YSZLkN7X7u15jfhLY39zNd0LdlZcgjiD
         WlxpYtEFJdTSK6f/ALxz6eSlCw6Eid5FN0D8DnDY6NNalGIQZg2p2GWCUdYnZp6VRw
         io3u815t1+7XhX73s9aR19zl2ZDeuMEiqa/PlFRirYDJnP0snBiYUs0qk1MlvpYVYo
         xy/K5sR6zhzKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41367C43168;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd9qNaE+LACOh2nf04ua=M9UQZs2N=2uw8dFmKXPzkbxYA@mail.gmail.com>
References: <CAKYAXd9qNaE+LACOh2nf04ua=M9UQZs2N=2uw8dFmKXPzkbxYA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd9qNaE+LACOh2nf04ua=M9UQZs2N=2uw8dFmKXPzkbxYA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.7-rc1
X-PR-Tracked-Commit-Id: ee785c15b5906a69d4007b4754e8ae40fb41e0b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc737f11c218969d01799dd8eb478582b67aaa24
Message-Id: <169895028526.19486.6411627971726621254.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:38:05 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 14:43:13 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc737f11c218969d01799dd8eb478582b67aaa24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
