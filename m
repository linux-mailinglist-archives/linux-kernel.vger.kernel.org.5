Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26180AD73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjLHUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLHUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:00:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC51732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:00:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED643C433CA;
        Fri,  8 Dec 2023 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702065609;
        bh=ccVyJywDtakW5RRvzMvP5y8hniWjIRmmn42GDLPIj5k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dvE7dYcgjNe94aEVgcygBzvp/qB8BWPMqEMo85kAigt0WVM3Y145/S7qx3rSwu0cd
         2nHU0XAi061gFDQxqYbiYTdKRBi3T6GedlJHS5YsexmxYjSYN63x/dCoj9X6tzko3y
         rN0WO0SJVtFnja6Sg6od/LmY4s6doJuGnibSS5xfE4PWlqoz3ItQsYAjl4DJWeCTo9
         2u+4WytxKQ6RkD2C0RV++kf2Cq7ePLlNrYN5wOBnQ5/SKkVKCaXwarWvKb99das71e
         MG6B3iV8Bwfqtt5oPeIk/SLV3w+/aahX2rXMyQx7boN1yHsnUZA8ox8v0KvffBT9/V
         KcgbGw7XjhtLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB480C04E24;
        Fri,  8 Dec 2023 20:00:08 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231208185147.1252216-1-linux@roeck-us.net>
References: <20231208185147.1252216-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231208185147.1252216-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.7-rc5
X-PR-Tracked-Commit-Id: 307004e8b254ad28e150b63f299ab9caa4bc7c3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dfe14fca933dc729fd7671c7b8fa616d74856b7
Message-Id: <170206560882.12654.8670040269857932970.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 20:00:08 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Dec 2023 10:51:47 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dfe14fca933dc729fd7671c7b8fa616d74856b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
