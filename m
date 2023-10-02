Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDD7B4B77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjJBGbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJBGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:30:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08DAB4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:30:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60E17C433C9;
        Mon,  2 Oct 2023 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696228256;
        bh=51D3jAWjqLEab76pPQmJ5kfBAfDmgnzB+pvMpo7r1BU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KEw3MegVxhjpNh+d+zdBD+D1t6g0QLdeyOllMocnFBwfeTLqinBZ2vsQIBIpKktn7
         PQnf2RfOEJZZKvBLmmHhYqWbezoM/qdZBFYSW5rjGyij3YnkdCc/wh2+5HjrYo+WKy
         TkisFNlIMHJJ8NVbDGzw7zw4/DryK0TEc9aw4vK1xQ6Sevnh08juHoaUcO+NjuP57X
         cII9F/Gq8as9GEqdm8I8s/gm2zbZ7l3Q6uJ47niZxVc7Q6Yqatar/5RWOAO8h4AN62
         C1C/93NY6q/Wo08Z1L9/UhCeaF2HU9xc3APpSkPJzSbId+hcdNPoB0C23K9F51bALV
         F6656xD1VAthQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43BC2E632D2;
        Mon,  2 Oct 2023 06:30:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM
 is absent
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169622825626.32662.10323231031478671932.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 06:30:56 +0000
References: <20230922124741.360103-1-festevam@gmail.com>
In-Reply-To: <20230922124741.360103-1-festevam@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     kuba@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, l00g33k@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@denx.de,
        florian.fainelli@broadcom.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 09:47:41 -0300 you wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done
> before HW reset") the following error is seen on a imx8mn board with
> a 88E6320 switch:
> 
> mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done
> 
> [...]

Here is the summary with links:
  - [v3,net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent
    https://git.kernel.org/netdev/net/c/6ccf50d4d474

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


