Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF27DC35A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjJ3Xu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjJ3XuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DC011D;
        Mon, 30 Oct 2023 16:50:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39A30C433CC;
        Mon, 30 Oct 2023 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709809;
        bh=8CbYS5dh46H3/5Jl89Y++7Ad6YTTcq+rjqAMrBPBv3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fsE3Qy+GCScx8NYRBNRXqUlnsJC2WUDiCHZAWuTWfw8jWwKgYbDYaXv7a2DruM6uq
         KL+Ku16aDVsubiQn2rHKSeVhjzP5csW0kYGgdU+uFAPgO9uiwoBlAyGNZTpyuSMI1L
         MuSeMOK8YJQ/7BvHgf0P7YpzAPjUGU61T1K54J8fqLNZScaIDfgKR2xKp/rbExbKz9
         M4RuLtt1OqONerKyEfV/6D2xbjPaAUz3L/4BICeCfZ4nqsHMVgCMxYIUOYep486+XD
         lEEEpN2jJNR1pbMLqb7uRy2XvyTYv5F3u27+WQwhKYZQ0327GjhZDfoQHhKhOsOF2I
         8LjmEEjjtM1MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25B37C595D7;
        Mon, 30 Oct 2023 23:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30
X-PR-Tracked-Commit-Id: b827ac419721a106ae2fccaa40576b0594edad92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e87705289667a6c5185c619ea32f3d39314eb1b
Message-Id: <169870980914.17163.3315949638870235214.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:09 +0000
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 10:55:40 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e87705289667a6c5185c619ea32f3d39314eb1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
