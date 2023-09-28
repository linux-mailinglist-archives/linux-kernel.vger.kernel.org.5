Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5E37B1F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjI1OKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjI1OK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FB19E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:10:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52164C433C9;
        Thu, 28 Sep 2023 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695910223;
        bh=ot+W6g9nu+I+9KjrXdlfhebhpZ6XR/Na3+FNvDuEvVM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GUnut2cGRtpD+l6MY8hzKgOhML5DluE8DR4HQh6jQLIOLidkEACFZAszNDPIPoSdq
         NPeV+n8vcdqYY+H8hRu7Cssgbw37KiG/zMhCf3fZyXHwztXsRmDydZWvxcwQHehWi5
         MeQe2Crr5IrgVicRRJn3KN+o7ah5RiPI+ZDH31BqhiUos9dnkt0mimeMtgnaYRlYl6
         6ejfdKbv2RX2Kpcc6F1iw9TKVeMlOCQMVE/tFXdvOu65iAQ9Y+aK8/Lzo7aEtOcMjL
         sHnZt34gIxd34xexgDuJ650jvs93LmewAtT+ohhNXEUVzIjJVR/Q1GIziIsTGRsdXM
         aHp0jFKABFAOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 358D6E29B00;
        Thu, 28 Sep 2023 14:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC
 driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169591022321.7456.1928532972585403523.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Sep 2023 14:10:23 +0000
References: <20230920115047.31345-1-harini.katakam@amd.com>
In-Reply-To: <20230920115047.31345-1-harini.katakam@amd.com>
To:     Katakam@ci.codeaurora.org, Harini <harini.katakam@amd.com>
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, esben@geanix.com, jsc@umbraculum.org,
        christophe.jaillet@wanadoo.fr, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Sep 2023 17:20:47 +0530 you wrote:
> LL TEMAC IP is no longer supported. Hence add an entry marking the
> driver as obsolete.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> ---
> This is an old driver with no bindings doc and hence the maintainers
> entry does not contain a link to documentation.
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC driver
    https://git.kernel.org/netdev/net-next/c/19f5eef8bf73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


