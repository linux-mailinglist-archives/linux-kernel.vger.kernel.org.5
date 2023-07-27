Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03E765C66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjG0Tte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjG0Tt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927163A8D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C91D61F2E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E905FC433C8;
        Thu, 27 Jul 2023 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690487358;
        bh=UvHScns3KGd/gqfVTpwY4R+Cc42prp4rDYGWAbDSfiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HIMrSvd3tabqV5aFQS5Qm5RS79lJFbax0HsRMhG5239SjsF1ko4ma1yU6xEpbm66B
         8+dSxPrM78WEqT3nPzvkUNHSL67M7kbwhFmMPNsD0Ymu2UrgzqUMYvOmq3ZQfbiFpQ
         CIdfjzhGF8g0Rzcp5dnu/InG8r87n+z4+jsTQg0sjAZtN8kJN7spRhaYmAxan6XSq1
         ZD2HXM+QCUxhspfylrPHLzZ1Xv2jhUbxp3wb0zYNYw0Ze9XzYjnM37AI/5Nxc/HX10
         +ImCfZwxNAEKKVO2GMyiFyht7b/u0xBaM6XS4IXwT8iadg4f/04KCoI9bMkFnt21e3
         /ctAmS9r8QRYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5A3CC41672;
        Thu, 27 Jul 2023 19:49:17 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230727131250.40515-1-pabeni@redhat.com>
References: <20230727131250.40515-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230727131250.40515-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc4
X-PR-Tracked-Commit-Id: de52e17326c3e9a719c9ead4adb03467b8fae0ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57012c57536f8814dec92e74197ee96c3498d24e
Message-Id: <169048735787.11614.13816300430840436077.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jul 2023 19:49:17 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jul 2023 15:12:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57012c57536f8814dec92e74197ee96c3498d24e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
