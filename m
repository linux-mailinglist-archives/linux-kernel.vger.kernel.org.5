Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CB7D8568
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjJZO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjJZO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:59:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86485B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:59:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC7DC433C9;
        Thu, 26 Oct 2023 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698332376;
        bh=ZROp2oPSB9jGPftAzPt+SBtEusxJ/81vyabcRXqWoHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5Vy8LWfM7+8DoEZQ5CTdEZnfIZen84yqEIAJsFEuFAdn0dUs9Sjc0Y09jfi2ndfP
         ai6ZaB1Kn92ShsEWdZEuqZDWZh+1ncmv2d/oRkBiYnO5tAoTro/QtzH+CtP5U55/ck
         ra9szOwhESHZvnnDN5gbC4e1yTlr3qUSuMFukjGciOFakWhiC9sh0Z/LlA3i07Midy
         TAd0MbPymz4UH0TcmM/XibqCiZx6SEXDE7DjpuNrN1Q/piy2VNbaATk1WjM/Ml2pT2
         VchHWjr+XEeh0i6eognmjY10q/ypgyyTSclpcw1Db+qdBb/0XlEYxCVLX6/F3lXxvc
         pj+TAGj7aUW2A==
Date:   Thu, 26 Oct 2023 15:59:30 +0100
From:   Simon Horman <horms@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3] MAINTAINERS: Remove linuxwwan@intel.com mailing
 list
Message-ID: <20231026145930.GC225043@kernel.org>
References: <20231025130332.67995-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025130332.67995-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:03:32PM +0700, Bagas Sanjaya wrote:
> Messages submitted to the ML bounce (address not found error). In
> fact, the ML was mistagged as person maintainer instead of mailing
> list.
> 
> Remove the ML to keep Cc: lists a bit shorter and not to spam
> everyone's inbox with postmaster notifications.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

From my PoV this is a good step that cleans up the cited issue - a dead ML.
And futher changes can be addressed by follow-up patches, as appropriate.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  Changes since v2 [1]:
> 
>    * Keep M Chetan Kumar in MAINTAINERS, as Johannes is trying to
>      keep in touch with him. As a result, this v3 is reduced to a
>      single patch.
> 
>  [1]: https://lore.kernel.org/netdev/20231023032905.22515-2-bagasdotme@gmail.com/

...
