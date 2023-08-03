Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015176DE4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjHCCgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHCCf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637449C7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0704E61BB3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF536C433C8;
        Thu,  3 Aug 2023 02:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691030066;
        bh=TXkKpjfBwJUHSuaXgx+HvSYPxUQ+cDXkq2stWTEAw5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ACpiTaosOIA/uOtQYQbbbCUFsDWeT1t5/XPEnyu0iBK5JC0o5OiG1smC0IjXPmSp/
         xhbgfcDjg+oGnNHD7r2d4wXxEssiJswaU1nJxj+PUJH46lkElC+v7eE7Z7X834BR1g
         4ST0pl0hOBO5wveq4hl7Pb5lo5l7s+yIaxKGO8PeGr8gE3A4Q5J4dst4YJEl2RHim/
         k7kgTnls6Sq+xLU1wbteOl+ufq0m6h6PNBw2dKXQng4h3oo9c8Zr3HrRdElABBdGKz
         UN51faaciF40+3XDeaz8Qj/VgjN236JcrkRCu05nY+PPzL70DehZrRL35ARgWFdTg9
         9K6Cbzb+1dOUw==
Date:   Wed, 2 Aug 2023 19:34:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <simon.horman@corigine.com>, <jesse.brandeburg@intel.com>
Subject: Re: [net-next PATCH V4 0/2] octeontx2-af: TC flower offload changes
Message-ID: <20230802193424.79377f40@kernel.org>
In-Reply-To: <20230801153657.2875497-1-sumang@marvell.com>
References: <20230801153657.2875497-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 21:06:55 +0530 Suman Ghosh wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan
> 
> Suman Ghosh (2):
>   octeontx2-af: Code restructure to handle TC outer VLAN offload
>   octeontx2-af: TC flower offload support for inner VLAN
> 
> v4 changes:
> 	Resolved conflicts with 'main' branch

Still does not apply.

After you git format-patch the patches check out net-next/main
and git am /path/to/patches..
-- 
pw-bot: cr
