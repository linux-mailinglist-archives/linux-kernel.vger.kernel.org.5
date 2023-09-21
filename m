Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3B7A9D20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIUT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjIUT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D86A4C;
        Thu, 21 Sep 2023 10:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE479C433CD;
        Thu, 21 Sep 2023 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695316207;
        bh=U9zZ09uXyoXXSUyFPKcYObsYfa/kMWbxZwUKl6YhkHw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dmrj+0g1LdhWc+xmSrg53ESNqFSfstDP4DNkfP7uSnfmtcoKQm3woqxZj81UBAsbd
         3wng837Zi/dbK4+HCXURtOxIcLvZ3oXsEIa+G3eDjAqaqHfwUm0aK8hP6QIYPpn2VZ
         0VJpGRJn6jQnO7SRdZ9b2+GHJjVj0+vW1gqKZCR4rNEcCeF9d2KVedJT+5U5NybO2c
         Huzr6bVV5rfR14yNONi0gfBIE6L1wvsRhUw6g4qtpb3FrVqlsWzbhEaLk8q0Ry/OnE
         KPDGflQcR+OEzQL0CDTcxTlZK1VltoOh62UQES7J/4T85HrDAhMFiJQdWgk463xPrV
         v2adrfREZnKoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CDD1E11F79;
        Thu, 21 Sep 2023 17:10:07 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230921050647.4048805-1-linux@roeck-us.net>
References: <20230921050647.4048805-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230921050647.4048805-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.6-rc3
X-PR-Tracked-Commit-Id: 2dd1d862817b850787f4755c05d55e5aeb76dd08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b300c0fdf0045ede109a349aa9c79f81bfae086a
Message-Id: <169531620742.32358.15288942471103702375.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 17:10:07 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Sep 2023 22:06:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b300c0fdf0045ede109a349aa9c79f81bfae086a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
