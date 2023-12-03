Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528D78025E8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjLCRNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:13:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C60C5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:13:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77BDC433C8;
        Sun,  3 Dec 2023 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701623605;
        bh=rlaUK9BhjAxFUUruue+V+gdSfXD9N/wY0G+9oUs7vp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ej5APuMwlpVatywcA69Z6fCzo/KKY6+s7kERhGPkwKUQKpzWB/fjnj6b4TUSQb87T
         PCo3Vtbv7o7pSgXBThWxrlF7diWQDiqQcqJjI/wygKKPvoto5W2c8mcvz/XtUvI47q
         xKd78TPBEzaj502FxEVXWqpvl1B/ktUyknnTPiRIj7OE4b8t0HZJg9jsEzzt5NRPl6
         ccKGfY54wavyq88udlTqLIkw4CSiy08jEDEI4aNdzpHqX4uor3zOyOvHA+PcB18J5S
         Ts9lfc6+QH8e/YPnBfOyxTD4lJSXJOYQ2IOLcHIPNFJQD4Kv49909gD5TVxyJ2BHzz
         ISkSxJXyOZKgw==
Date:   Sun, 3 Dec 2023 17:13:20 +0000
From:   Simon Horman <horms@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 5/5] octeontx2-af: Update Tx link register range
Message-ID: <20231203171320.GO50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-6-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-6-gakula@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:28:18PM +0530, Geetha sowjanya wrote:
> From: Rahul Bhansali <rbhansali@marvell.com>
> 
> On new silicons the TX channels for transmit level has increased.
> This patch fixes the respective register offset range to
> configure the newly added channels.
> 
> Fixes: b279bbb3314e ("octeontx2-af: NIX Tx scheduler queue config support")
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

