Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2824D7D88A2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjJZS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjJZS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:59:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953DF1AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:59:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 332ADC433C7;
        Thu, 26 Oct 2023 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698346749;
        bh=dHllpklj7kED/297XZYY5LGeedMCBVuegfDjlb0HTuM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K0sDo1UJUGDHiFVy9wX61/h0207j34R5zVbvGN9Tvep0qGLADFP7QBDIQ+DLlQtsn
         UOxqxRPTtso3QuUlHSpoHaYq/93DPIZ28GLv/TCOzWoXlwhwcTsAaWh2RBuQ09fYMv
         FBlbdL37+6reYbX4LWAtb8FFHlO5785CDvJ82CauYdoX3mdQRPIHySdqTs+nO6x6yy
         nLibF8EzCceIFBbps+WULgPDKo/SHnx/r4y0SRvShSdGXIL/Nl6A0xcIUtrSLZgHyX
         URz+/CoxqQR8JF9AY50wVvkcNYMTfiMdPZaR/jm90a/68Desbk1F5LQLN6MZTCbVZV
         HvFJq8fUHmr+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21314C3959F;
        Thu, 26 Oct 2023 18:59:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231026095510.23688-1-pabeni@redhat.com>
References: <20231026095510.23688-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231026095510.23688-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc8
X-PR-Tracked-Commit-Id: 53798666648af3aa0dd512c2380576627237a800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17cda15cc86e65e9725641daddcd7a63cc9ad01
Message-Id: <169834674912.28071.10248635912400848968.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Oct 2023 18:59:09 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
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

The pull request you sent on Thu, 26 Oct 2023 11:55:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17cda15cc86e65e9725641daddcd7a63cc9ad01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
