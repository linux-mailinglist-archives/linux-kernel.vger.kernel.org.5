Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B933477EBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbjHPV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbjHPV3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:29:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C19212E;
        Wed, 16 Aug 2023 14:29:11 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qWO4T-0007To-LC; Wed, 16 Aug 2023 23:28:53 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the rockchip tree
Date:   Wed, 16 Aug 2023 23:28:52 +0200
Message-ID: <2873632.NG923GbCHz@diego>
In-Reply-To: <20230815120307.3dce0db5@canb.auug.org.au>
References: <20230815120307.3dce0db5@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 15. August 2023, 04:03:07 CEST schrieb Stephen Rothwell:
> The following commits are also in the arm-soc tree as different commits
> (but the same patches):
> 
>   8cbdf5d28809 ("ARM: rockchip: Drop unused includes")
>   fc7696e2ae81 ("soc: rockchip: grf: Explicitly include correct DT includes")
> 
> These are commits
> 
>   ab7c1ad11da4 ("ARM: rockchip: Drop unused includes")
>   0e7ed4dda9ef ("soc: rockchip: Explicitly include correct DT includes")
> 
> in the arm-soc tree.

I've dropped the patches from my side now.


Thanks for catching the duplication
Heiko



