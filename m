Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B247D6F35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjJYO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbjJYO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914DA3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:29:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953D6C433C8;
        Wed, 25 Oct 2023 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698244150;
        bh=Ix20120weNMmvfY4E3/6k1Qf3kxX8RqfeojT8Bmf7ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qSJJaTM9HVoq8mS+Uu800KIlFmTE4Kb4qjPN7iEDMt6H5/SxaDFMfUDHcz9RTnkYM
         qcCp5DpxC5Z4m0FA9EIrWAtrI37dqeOTFMJwRMDA38GHMwGDv0f+/yMOU0UtkhLIDq
         KyAXdke9riD0SidUPW8WvZ/sM2tRmZzR+ACnJ/LzskQxWEuQv/yz5Ig1JjSP0vwR+G
         asO0aSOrM2qgRppiq/YMF1vYjn8/hyBc0JIRm3UBsIkO/9GirAweHk3QU0Ipmx9WX7
         t0BmH5N4chPjsR1Vjowji4BYqkZ3QMeOU9fnx+nIOOKsX+TJWXo0A+xytvnK5idlpX
         t4x7lvqDfy2pg==
Date:   Wed, 25 Oct 2023 07:29:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     davem@davemloft.net, patchwork-bot+netdevbpf@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@armlinux.org.uk, f.fainelli@gmail.com,
        edumazet@google.com, pabeni@redhat.com, kabel@kernel.org,
        ansuelsmth@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, robh@kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v7 0/7] Create a binding for the Marvell
 MV88E6xxx DSA switches
Message-ID: <20231025072908.54f71143@kernel.org>
In-Reply-To: <20231025093632.fb2qdtunzaznd73z@skbuf>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
        <169822622768.10826.14051215485905127447.git-patchwork-notify@kernel.org>
        <20231025093632.fb2qdtunzaznd73z@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 12:36:32 +0300 Vladimir Oltean wrote:
> Can you please revert this series? It breaks the boot on the Turris MOX
> board.

Done!
