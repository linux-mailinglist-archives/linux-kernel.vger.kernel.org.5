Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78778B3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjH1PGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjH1PGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:06:13 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31AF0;
        Mon, 28 Aug 2023 08:06:07 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 00F208DA8B8; Mon, 28 Aug 2023 17:06:05 +0200 (CEST)
Date:   Mon, 28 Aug 2023 17:06:05 +0200
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Message-ID: <ZOy33RB8aj3455ZQ@desktop>
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
 <20230824153059.212244-3-linkmauve@linkmauve.fr>
 <f79087c0-cc44-4fb6-fa2e-b43db5dfd6d4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79087c0-cc44-4fb6-fa2e-b43db5dfd6d4@linaro.org>
Jabber-ID: linkmauve@linkmauve.fr
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 24, 2023 at 06:28:07PM +0200, Krzysztof Kozlowski wrote:
> On 24/08/2023 17:30, Emmanuel Gil Peyrot wrote:
> > From: azkali <a.ffcc7@gmail.com>
> > 
> > This is used as the USB-C Power Delivery controller of the Nintendo
> > Switch.
> > 
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > Signed-off-by: azkali <a.ffcc7@gmail.com>
> > Signed-off-by: Adam Jiang <chaoj@nvidia.com>
> > Signed-off-by: CTCaer <ctcaer@gmail.com>
> 
> These do not look like real identities. In this and previous patchset
> your author emails bounces, so I propose to drop all stale addresses and
> all anonymous entries.

I and the authors find that policy inacceptable, our work should be
credited and our copyright should hold despite our choice of name.

Given the amount of issues in this patchset I will drop it for now, we
will come back with a better patchset for this particular device in a
while.

> 
> Best regards,
> Krzysztof
> 

Thanks for the review, I already tried to clean it up but it was clearly
not as good as the expectations here.

-- 
Link Mauve
