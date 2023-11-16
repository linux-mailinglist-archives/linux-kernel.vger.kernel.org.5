Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F67EE110
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbjKPNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345174AbjKPNHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:07:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF07193
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:06:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D317DC433C7;
        Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700140018;
        bh=5qk9VczzTb12p9ri5AV/VUJSsCmoyaMwsBOWcCucr/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uPhzmF6CXBEuGNtidr4fVrGvoDC6uML8UpNFIC243BWx1bQUdGXGojASFHgLNoHVS
         F3o6NQ4+y5ToLCsFN/oEqSpk5CjbMDVESUDdN16TbR1o2oLnCA9Otr7bEQUi2gWlsi
         Sbjs/UwW0dikRO9+Fxf9fy/9O972Dy4QIkiQ+rZltVhSXb05t13JHUI5orcZ9pPp88
         WihdHV7xNft+s1i8zWfdDHysdnRHSGAQuHPATGFEA2H9moWwayv70nMOPf1+Jm3sjo
         J6Rl0ko2fe5RaKl4FjVTG5u4bNukhxUHTmKpWu3M1IuZ4xXJS/kW6zSznJrDA+pfSL
         mNpNpyTgNDX3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE2D2E1F660;
        Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231116122140.28033-1-pabeni@redhat.com>
References: <20231116122140.28033-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231116122140.28033-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc2
X-PR-Tracked-Commit-Id: cff088d924df871296412e6b819823f42d1bb9a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7475e51b87969e01a6812eac713a1c8310372e8a
Message-Id: <170014001877.19711.5713646184426687588.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Nov 2023 13:06:58 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Nov 2023 13:21:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7475e51b87969e01a6812eac713a1c8310372e8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
