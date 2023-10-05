Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79757BA941
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjJESjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJESjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:39:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262A93
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:39:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1FF1C433C8;
        Thu,  5 Oct 2023 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696531170;
        bh=TZ6/vINZYzeuHgj6hf8EA6U0aoqe+o4/SxXZ1oXnEAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UVHID9ThKqPbs7uJarC6dj6k3PKqvi4QsRK/kL13UfdQP8ZRL/Mly8M8oMo2E0UoG
         wBCYKkT+9WipWxx1RVRaqLa036U+f+Pbp6qfTNUrvW7/J5N7aJ/ZF/ZccTK4iqCTQL
         2WvPjhyb7KyoJAJtsHWsVNSdFwRaDWTGGEOugiQ7JEliFx+2Mnu/b2+H89yLlMsEzT
         Sgy7pCHQaOLuAAdiL+Mk87p6H474CyIHV0YU/3pBDNuaGQsiFuA/PIzzN2MHYJNoGj
         nil6HVJTJSyAF4vCrQRV/VglpoZu0NTKhOXpqPyWG2TvmyQ2ZO1sVldXy5EPpa/UxS
         LrdCS6Dzwq52Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEF3EE632D2;
        Thu,  5 Oct 2023 18:39:30 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231005182140.3847567-1-kuba@kernel.org>
References: <20231005182140.3847567-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231005182140.3847567-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc5
X-PR-Tracked-Commit-Id: c29d984580212f8a5e75b65c99a745f29511f83a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f291209eca5eba0b4704fa0832af57b12dbc1a02
Message-Id: <169653117077.4044.9754330321075907934.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Oct 2023 18:39:30 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Oct 2023 11:21:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f291209eca5eba0b4704fa0832af57b12dbc1a02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
