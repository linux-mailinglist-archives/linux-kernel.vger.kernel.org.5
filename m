Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0D75B9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGTVxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGTVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAD271D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6DBE61CB8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B6AAC433D9;
        Thu, 20 Jul 2023 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689890024;
        bh=Ks/7SzKUrQWpvpD7qyUupUycx9MQHR2Gx+74B3iJ7lQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qy6zhdF3xa3LWBYitjL5iHR20cnNSmnnBAhYCC10PqjIUquz2oGRI+K/VNjWRSjmP
         zvt3uVlbem8aTgz/pTdsCb4EzHTJAwFIyqXuXSs2PHxzJoOEVpdH5einv1rQxLp+D+
         EbRpV9PhodWEkaRDMBITh56i7Y9Lsr4yvkZ+cdZfTUrUy4HYw4ArKPhE9w6xAXJBXm
         nuGpQdTlOZmvrEdckkM24Qhw0toUNvy+dSpKKhKpNn4twrS6F7fyaDa/S0LCKXU7SE
         6p/VEFTRpQyllwE9EOxSAC+bNwUn2Sswo4e6UvCb3IK4y7QTyRWlsVBT7ZxXpJVD/a
         MAAISpTppXTdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28AE2C595C4;
        Thu, 20 Jul 2023 21:53:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230720214559.163647-1-kuba@kernel.org>
References: <20230720214559.163647-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230720214559.163647-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc3
X-PR-Tracked-Commit-Id: 75d42b351f564b2568392a4e53cd74a3d9df4af2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57f1f9dd3abea322173ea75a15887ccf14bbbe51
Message-Id: <168989002415.13899.12157867587483013615.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jul 2023 21:53:44 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jul 2023 14:45:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57f1f9dd3abea322173ea75a15887ccf14bbbe51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
